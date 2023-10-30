`timescale 1ns / 1ps
/*
REG_FILE by CKDUR.

Instructions: 
1. Instance REG_FILE, not true_dpram_sclk
2. Connect rd, rs1 and rs2 input/output to their respective buses.
3. Connect rdi, rs1i, rs2i from DECO_INSTR (These are the indexes)
4. If 'rdw_rsrn' is 1 logic, then rd data is written to registers according to rdi
   If 'rdw_rsrn' is 0 logic, then rs1 and rs2 are filled with data from registers according to rs1 and rs2.
   Note: ALWAYS is doing this, if you dont want rd write the registers, you MUST put rdw_rsrn to 0 and maintain rs1i and rs2i constant.
5. Profit!

*/

// Code extracted from: https://www.altera.com/support/support-resources/design-examples/design-software/verilog/ver-true-dual-port-ram-sclk.html
module true_dpram_sclk
(
	input [31:0] data_a,
	input qed_vld_out_q,
	input [4:0] addr_a, addr_b,
	input we_a, clk, rst,
	input outside_resetn,
	output reg [31:0] q_a, q_b
);
	// Declare the RAM variable
	reg [31:0] ram[31:0];
	(* keep *)
	reg qed_vld_out_final;
	reg addr_a_temp;
	// Port A
	always @ (posedge clk)
	begin
		if(!outside_resetn) begin
			qed_vld_out_final<=0;
		end else begin
		qed_vld_out_final<=qed_vld_out_q;
		if (we_a) begin
				ram[addr_a] <= data_a;
				addr_a_temp <= addr_a;
			end
		q_a <= addr_a?ram[addr_a]:32'd0;		// Assign zero if index is zero because zero register
		q_b <= addr_b?ram[addr_b]:32'd0;		// Assign zero if index is zero because zero register
	end
	end

	assign qed_reach_commit = qed_vld_out_final||(qed_vld_out_q && outside_resetn && we_a && addr_a);
	assume property (~(qed_reach_commit && (num_orig_insts==0)&&(num_dup_insts==0))||((ram[0] == ram[16])&&(ram[1] == ram[17])&&(ram[2] == ram[18])&&(ram[3] == ram[19])&&(ram[4] == ram[20])&&(ram[5] == ram[21])
	&&(ram[6] == ram[22])&&(ram[7] == ram[23])&&(ram[8] == ram[24])&&(ram[9] == ram[25])&&(ram[10] == ram[26])&&(ram[11] == ram[27])&&(ram[12] == ram[28])
	&&(ram[13] == ram[29])&&(ram[14] == ram[30])&&(ram[15] == ram[31])));
	// EDIT: Insert the qed ready logic -- tracks number of committed instructions
	(* keep *)
	wire qed_ready;
	(* keep *)
	reg [15:0] num_orig_insts;
	(* keep *)
	reg [15:0] num_dup_insts;
	wire [1:0] num_orig_commits;
	wire [1:0] num_dup_commits;
	

	assign num_orig_commits = ((qed_reach_commit == 1)&&(we_a==1)&&(addr_a_temp < 16))&&(addr_a_temp!=5'b00000)? 2'b01 : 2'b00 ;


   // When destination register is 5'b0, it remains the same for both original and duplicate
//    assign num_dup_commits = (cpuregs_write == 1)&&(dstarf1 >= 16)//arfwe1 = architecture register file write enable  dstarf1 = destination of the architecture register file 
   	assign num_dup_commits = ((qed_reach_commit == 1)&&(we_a==1)&&(addr_a_temp >= 16))? 2'b01  : 2'b00 ;

   	always @(posedge clk) begin
		if (!outside_resetn) begin
	  		num_orig_insts <= 16'b0;
	   		num_dup_insts <= 16'b0;
			// qed_vld_out_final<=0;
		end else begin
	   		num_orig_insts <= num_orig_insts + {14'b0,num_orig_commits};
	   		num_dup_insts <= num_dup_insts + {14'b0,num_dup_commits};
	end
     end

   	assign qed_ready = (num_orig_insts == num_dup_insts)&&(num_orig_insts!=0);
	assert property ((!(qed_ready&&(qed_reach_commit)))||(ram[1] == ram[17]));
endmodule

module REG_FILE(
    input clk,
    input rst,
    input outside_resetn,
    input qed_vld_out_q,
	input [31:0] rd,
	input [4:0] rdi,
	input rdw_rsrn,
	output [31:0] rs1,
	input [4:0] rs1i,
	output [31:0] rs2,
	input [4:0] rs2i
	);
	
	wire [31:0] data_a;
	wire [4:0] addr_a, addr_b;
	wire we_a;
	wire [31:0] q_a, q_b;
	
	assign data_a = rd;
	assign addr_a = rdw_rsrn?rdi:rs1i;
	assign addr_b = rs2i;
	assign we_a = rdw_rsrn;
	assign rs1 = q_a;
	assign rs2 = q_b;
	
	true_dpram_sclk MEM_FILE
(
	.data_a(data_a),
	.qed_vld_out_q(qed_vld_out_q),
	.addr_a(addr_a), .addr_b(addr_b),
	.we_a(we_a), .clk(clk), .rst(rst), 
	.outside_resetn(outside_resetn),
	.q_a(q_a), .q_b(q_b)
);
	
endmodule

