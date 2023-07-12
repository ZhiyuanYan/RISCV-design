module data_memory(input clk,
                   input outside_reset, 
                   input qed_vld_out_ex_mem,
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data);

reg [31:0] memory [0:31];

integer i;

initial begin
    for(i = 0; i < 31; i = i + 1) begin
        memory[i] = 0;
    end
end

always@(posedge clk) begin //scriere SINCRONA
    if(mem_write) begin
        memory[address[6:2]] <= write_data;
    end
end
always@(mem_read) begin //citire ASINCRONA
    if(mem_read) begin
        read_data <= memory[address[6:2]];
    end
end
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
    assume property ((~(qed_reach_commit&& (num_orig_insts==0)&&(num_dup_insts==0)))||((memory[0] == memory[16])&&(memory[1] == memory[17])&&(memory[2] == memory[18])&&(memory[3] == memory[19])&&(memory[4] == memory[20])&&(memory[5] == memory[21])
    &&(memory[6] == memory[22])&&(memory[7] == memory[23])&&(memory[8] == memory[24])&&(memory[9] == memory[25])&&(memory[10] == memory[26])&&(memory[11] == memory[27])&&(memory[12] == memory[28])
    &&(memory[13] == memory[29])&&(memory[14] == memory[30])&&(memory[15] == memory[31])));




   assign num_orig_commits = (qed_reach_commit == 1)&&(mem_write==1)&&(address[6:2] < 16)&&(address[6:2] != 5'b0)? 2'b01 : 2'b00 ;


   // When destination register is 5'b0, it remains the same for both original and duplicate
//    assign num_dup_commits = (cpuregs_write == 1)&&(dstarf1 >= 16)//arfwe1 = architecture register file write enable  dstarf1 = destination of the architecture register file 
   assign num_dup_commits = (qed_reach_commit == 1)&&(mem_write==1)&&(address[6:2] >= 16)? 2'b01  : 2'b00 ;
   
   
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
   assert property ((!(qed_ready&&(qed_reach_commit)))||(memory[1] == memory[17]));
endmodule
