///////////////////////////////////REGISTER_FILE_MODULE///////////////////////////////////////////////////////
module registers(input clk,reg_write,
                 input outside_reset, 
                 input qed_vld_out_ex_mem,
                 input [4:0] read_reg1,read_reg2,write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1,read_data2);
  
  reg [31:0] Registers [0:31];
  
  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) begin
      Registers[i] = i;
    end
  end
  
  always@(posedge clk) begin
    if(reg_write && write_reg)
      Registers[write_reg] <= write_data;
  end
  
  assign read_data1 = (read_reg1 != 5'b0) ? //it is different from x0
                      (((reg_write == 1'b1)&&(read_reg1 == write_reg)) ? 
                      write_data : Registers[read_reg1]) : 32'b0;
                      
  assign read_data2 = (read_reg2 != 5'b0) ? //it is different from x0
                      (((reg_write == 1'b1)&&(read_reg2 == write_reg)) ? 
                      write_data : Registers[read_reg2]) : 32'b0;


wire qed_reach_commit;
assign qed_reach_commit = qed_vld_out_ex_mem;

   // EDIT: Insert the qed ready logic -- tracks number of committed instructions
   (* keep *)
   wire qed_ready;
   (* keep *)
   reg [15:0] num_orig_insts;
   (* keep *)
   reg [15:0] num_dup_insts;
   wire [1:0] num_orig_commits;
   wire [1:0] num_dup_commits;
   
// assign __START__ = (qed_reach_commit && (num_orig_insts==0)&&(num_dup_insts==0));
    assume property ((~(qed_reach_commit&& (num_orig_insts==0)&&(num_dup_insts==0)))||((Registers[0] == Registers[16])&&(Registers[1] == Registers[17])&&(Registers[2] == Registers[18])&&(Registers[3] == Registers[19])&&(Registers[4] == Registers[20])&&(Registers[5] == Registers[21])
    &&(Registers[6] == Registers[22])&&(Registers[7] == Registers[23])&&(Registers[8] == Registers[24])&&(Registers[9] == Registers[25])&&(Registers[10] == Registers[26])&&(Registers[11] == Registers[27])&&(Registers[12] == Registers[28])
    &&(Registers[13] == Registers[29])&&(Registers[14] == Registers[30])&&(Registers[15] == Registers[31])));




   assign num_orig_commits = (qed_reach_commit == 1)&&(reg_write==1)&&(write_reg < 16)&&(write_reg != 5'b0)? 2'b01 : 2'b00 ;


   // When destination register is 5'b0, it remains the same for both original and duplicate
//    assign num_dup_commits = (cpuregs_write == 1)&&(dstarf1 >= 16)//arfwe1 = architecture register file write enable  dstarf1 = destination of the architecture register file 
   assign num_dup_commits = (qed_reach_commit == 1)&&(reg_write==1)&&(write_reg >= 16)? 2'b01  : 2'b00 ;
   
   
   always @(posedge clk) begin
	if (outside_reset) begin
	   num_orig_insts <= 16'b0;
	   num_dup_insts <= 16'b0;
	end else begin
	   num_orig_insts <= num_orig_insts + {14'b0,num_orig_commits};
	   num_dup_insts <= num_dup_insts + {14'b0,num_dup_commits};
	end
     end

   assign qed_ready = (num_orig_insts == num_dup_insts)&&(num_orig_insts!=0);
   assert property ((!(qed_ready&&(qed_reach_commit)))||(Registers[1] == Registers[17]));
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
