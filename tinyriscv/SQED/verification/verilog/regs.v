 /*                                                                      
 Copyright 2019 Blue Liang, liangkangnan@163.com
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
 Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */

`include "defines.v"

// 通用寄存器模块
module regs(

    input wire clk,
    input wire rst,
    input wire outside_rst,

    // from ex
    input wire we_i,                      // 写寄存器标志
    input wire[`RegAddrBus] waddr_i,      // 写寄存器地址
    input wire[`RegBus] wdata_i,          // 写寄存器数据
    input qed_vld_out_id_ex,
    input qed_vld_out_if_id,
    // from jtag
    input wire jtag_we_i,                 // 写寄存器标志
    input wire[`RegAddrBus] jtag_addr_i,  // 读、写寄存器地址
    input wire[`RegBus] jtag_data_i,      // 写寄存器数据

    // from id
    input wire[`RegAddrBus] raddr1_i,     // 读寄存器1地址

    // to id
    output reg[`RegBus] rdata1_o,         // 读寄存器1数据

    // from id
    input wire[`RegAddrBus] raddr2_i,     // 读寄存器2地址

    // to id
    output reg[`RegBus] rdata2_o,         // 读寄存器2数据

    // to jtag
    output reg[`RegBus] jtag_data_o       // 读寄存器数据

    );

    reg[`RegBus] regs[0:`RegNum - 1];

    // 写寄存器
    always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            // 优先ex模块写操作
            if ((we_i == `WriteEnable) && (waddr_i != `ZeroReg)) begin
                regs[waddr_i] <= wdata_i;
            end else if ((jtag_we_i == `WriteEnable) && (jtag_addr_i != `ZeroReg)) begin
                regs[jtag_addr_i] <= jtag_data_i;
            end
        end
    end

    // 读寄存器1
    always @ (*) begin
        if (raddr1_i == `ZeroReg) begin
            rdata1_o = `ZeroWord;
        // 如果读地址等于写地址，并且正在写操作，则直接返回写数据
        end else if (raddr1_i == waddr_i && we_i == `WriteEnable) begin
            rdata1_o = wdata_i;
        end else begin
            rdata1_o = regs[raddr1_i];
        end
    end

    // 读寄存器2
    always @ (*) begin
        if (raddr2_i == `ZeroReg) begin
            rdata2_o = `ZeroWord;
        // 如果读地址等于写地址，并且正在写操作，则直接返回写数据
        end else if (raddr2_i == waddr_i && we_i == `WriteEnable) begin
            rdata2_o = wdata_i;
        end else begin
            rdata2_o = regs[raddr2_i];
        end
    end

    // jtag读寄存器
    always @ (*) begin
        if (jtag_addr_i == `ZeroReg) begin
            jtag_data_o = `ZeroWord;
        end else begin
            jtag_data_o = regs[jtag_addr_i];
        end
    end

    //QED 
    // EDIT: Insert the qed ready logic -- tracks number of committed instructions
    (* keep *)
    wire qed_ready;
    (* keep *)
    reg [15:0] num_orig_insts;
    (* keep *)
    reg [15:0] num_dup_insts;
    wire [1:0] num_orig_commits;
    wire [1:0] num_dup_commits;
	wire __START__;
	wire qed_reach_commit;
	// assign qed_reach_commit = qed_vld_out_id_ex || (qed_vld_out_if_id && (!rst) && (we_i) && (waddr_i));
	assign qed_reach_commit = qed_vld_out_id_ex;
    assign __START__ = (qed_reach_commit && (num_orig_insts==0)&&(num_dup_insts==0));
	assume property ((~__START__)||((regs[0] == regs[16])&&(regs[1] == regs[17])&&(regs[2] == regs[18])&&(regs[3] == regs[19])&&(regs[4] == regs[20])&&(regs[5] == regs[21])
	&&(regs[6] == regs[22])&&(regs[7] == regs[23])&&(regs[8] == regs[24])&&(regs[9] == regs[25])&&(regs[10] == regs[26])&&(regs[11] == regs[27])&&(regs[12] == regs[28])
	&&(regs[13] == regs[29])&&(regs[14] == regs[30])&&(regs[15] == regs[31])));


    // wire latched_rd;
    // assign latched_rd = we_i ? waddr_i : jtag_addr_i;
    assign num_orig_commits = (qed_reach_commit == 1)&&(we_i==1)&&(waddr_i < 16)&&(waddr_i != 5'b0)? 2'b01 : 2'b00 ;
    assign num_dup_commits = (qed_reach_commit == 1)&&(we_i==1)&&(waddr_i >= 16)? 2'b01  : 2'b00 ;
   
    always @(posedge clk) begin
	 if (outside_rst == `RstEnable) begin
	   num_orig_insts <= 16'b0;
	   num_dup_insts <= 16'b0;
	 end else begin
	   num_orig_insts <= num_orig_insts + {14'b0,num_orig_commits};
	   num_dup_insts <= num_dup_insts + {14'b0,num_dup_commits};
	 end
    end

    assign qed_ready = (num_orig_insts == num_dup_insts)&&(num_orig_insts!=0);

    assert property ((!(qed_ready&&(qed_reach_commit)))||(regs[1] == regs[17]));
endmodule
