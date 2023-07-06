///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
  reg clk,reset;
  wire [31:0] PC_EX, ALU_OUT_EX, PC_MEM;
  wire PCSrc;
  wire [31:0] DATA_MEMORY_MEM, ALU_DATA_WB;
  wire [1:0] forwardA, forwardB;
  wire pipeline_stall;
  /*reg IF_ID_write;
  reg PCSrc,PC_write;
  reg [31:0] PC_Branch;
  reg RegWrite_WB; 
  reg [31:0] ALU_DATA_WB;
  reg [4:0] RD_WB;
  wire [31:0] PC_ID;
  wire [31:0] INSTRUCTION_ID;
  wire [31:0] IMM_ID;
  wire [31:0] REG_DATA1_ID,REG_DATA2_ID;
  wire [2:0] FUNCT3_ID;
  wire [6:0] FUNCT7_ID;
  wire [6:0] OPCODE_ID;
  wire [4:0] RD_ID;
  wire [4:0] RS1_ID;
  wire [4:0] RS2_ID;
  
  RISC_V_IF_ID procesor(clk,reset,
         IF_ID_write,
         PCSrc,PC_write,
         PC_Branch,
         RegWrite_WB, 
         ALU_DATA_WB,
         RD_WB,
         PC_ID,
         INSTRUCTION_ID,
         IMM_ID,
         REG_DATA1_ID,REG_DATA2_ID,
         FUNCT3_ID,
         FUNCT7_ID,
         OPCODE_ID,
         RD_ID,    
         RS1_ID,   
         RS2_ID);    
  
  always #5 clk=~clk;
  
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
       
       IF_ID_write = 1'b1;      
       PCSrc = 1'b0;
       PC_write = 1'b1;    
       PC_Branch = 32'b0;  
       RegWrite_WB = 1'b0;       
       ALU_DATA_WB = 32'b0;
       RD_WB = 5'b0;           
       
    #10 reset=1'b0;
    #200 $finish;
  end*/
  
    RISC_V processor(clk, reset,
                   PC_EX, ALU_OUT_EX, PC_MEM, PCSrc, DATA_MEMORY_MEM, ALU_DATA_WB,
                   forwardA, forwardB, pipeline_stall);
    
    always #5 clk=~clk;
    
    initial begin
        #0 clk = 1'b0;
           reset = 1'b1;
        #10 reset = 1'b0;
        #200 $finish;
    end
      
endmodule