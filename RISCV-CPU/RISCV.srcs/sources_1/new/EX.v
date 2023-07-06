module EX(input [31:0] imm_ex, reg_data1_ex, reg_data2_ex, pc_ex,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_Ex,
          input [4:0] rs1_ex, rs2_ex, rd_ex,
          input MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex,
          input [1:0] aluOp_ex,
          input aluSrc_ex, branch_ex,
          input [1:0] forwardA, forwardB,
          input [31:0] alu_data_wb, alu_out_mem,// val rez alu in wb, respectiv, mem
          output Zero_ex,
          output [31:0] alu_out_ex, pc_branch_ex, reg_data2_ex_mux);
         
wire [31:0] inAlu1, inAlu2;

mux3_1 mux1(reg_data1_ex, alu_data_wb, alu_out_mem, forwardA, inAlu1);
mux3_1 mux2(reg_data2_ex, alu_data_wb, alu_out_mem, forwardB, reg_data2_ex_mux);

mux2_1 mux3(reg_data2_ex_mux, imm_ex, aluSrc_ex, inAlu2);          


wire [3:0] ALUinput;

ALUcontrol uut_ALUcontrol(aluOp_ex, FUNCT7_EX, FUNCT3_EX, ALUinput);
ALU uut_ALU(ALUinput, inAlu1, inAlu2, Zero_ex, alu_out_ex);

adder uut_adder(pc_ex, imm_ex, pc_branch_ex); // calculul adresei de salt; rezultatul
                                              // se propaga in MEM
         
endmodule
