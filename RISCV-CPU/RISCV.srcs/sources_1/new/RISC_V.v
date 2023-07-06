module RISC_V(input clk, // smenalul de ceas global
              input reset, // semnalul de reset global
              
              output [31:0] PC_EX, //adresa PC in etapa EX
              output [31:0] ALU_OUT_EX, // valoarea calculata de ALU in etapa EX
              output [31:0] PC_MEM, // adresa de salt calculata
              output PCSrc, // semnal de selectie pentru PC
              output[31:0] DATA_MEMORY_MEM, // valoarea citita din mem de date in MEM
              output [31:0] ALU_DATA_WB, // valoarea finala scrisa in etapa WB
              output [1:0] forwardA, forwardB, // semnalele de forwarding
              output pipeline_stall); // semnal de stall la detectia de hazarduri
              
    wire [31:0] PC_IF;
    wire [31:0] INSTRUCTION_IF;
    
    wire IF_IDwrite;
    wire PCwrite;
    
    wire [31:0] PC_ID;
    wire [31:0] INSTRUCTION_ID;
    wire [31:0] IMM_ID;
    wire [31:0] REG_DATA1_ID;
    wire [31:0] REG_DATA2_ID;
    
    wire [2:0] FUNCT3_ID;
    wire [6:0] FUNCT7_ID;
    wire [6:0] OPCODE_ID;
    wire [4:0] RD_ID;
    wire [4:0] RS1_ID;
    wire [4:0] RS2_ID;
    
    wire [4:0] RD_WB;
    wire RegWrite_WB;
    
    IF if_module(clk, reset, PCSrc, PCwrite, PC_MEM, PC_IF, INSTRUCTION_IF);
    
    IF_ID_reg IF_ID_Reg(clk, reset, IF_IDwrite, PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);
    
    ID instruction_decode(clk, PC_ID, INSTRUCTION_ID, RegWrite, ALU_DATA_WB, RD_WB, IMM_ID,
                          REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID,
                          RS1_ID, RS2_ID);
                          
    wire control_sel;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;  
    wire RegWrite;
    wire Branch;
    wire ALUSrc;
    wire [1:0] ALUop;
    
    control_path uut_control_path(OPCODE_ID, control_sel, Branch, MemRead, MemtoReg, ALUop, MemWrite,
                                 ALUSrc, RegWrite);
                                            
    wire ID_EX_write;
    wire MemRead_EX;
    wire MemtoReg_EX;
    wire MemWrite_EX;
    wire RegWrite_EX;
    wire Branch_EX;
    
    wire [31:0] REG_DATA1_EX;
    wire [31:0] REG_DATA2_EX;
    wire [4:0] RS1_EX;
    wire [4:0] RS2_EX;
    wire [4:0] RD_EX;
    
    wire [1:0] ALUop_out;
    wire ALUSrc_out;
    wire [31:0] IMM_EX;
    wire [2:0] FUNCT3_EX;
    wire [6:0] FUNCT7_EX;
    
    ID_EX_reg ID_EX_Reg(clk, reset, 1'b1,
                        PC_ID, REG_DATA1_ID, REG_DATA2_ID,
                        RS1_ID, RS2_ID, RD_ID,
                        ALUop, ALUSrc,
                        MemRead, MemWrite, Branch,
                        MemtoReg, RegWrite,
                        FUNCT3_ID, FUNCT7_ID,
                        IMM_ID, // input pana aici
                        PC_EX, REG_DATA2_EX, REG_DATA2_EX, // output de aici incolo
                        RS1_EX, RS2_EX, RD_EX,
                        ALUop_out, ALUSrc_out,
                        MemRead_EX, MemWrite_EX, Branch_EX,
                        MemtoReg_EX, RegWrite_EX,
                        FUNCT3_EX, FUNCT7_EX,
                        IMM_EX);

    wire ZERO_EX;
    wire [31:0] REG_DATA2_EX_MUX;
    
    wire [31:0] ALU_MEM;
    wire [31:0] PC_Branch_EX;
    
    EX uut_ex(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX,
              FUNCT3_EX, FUNCT7_EX,
              RS1_EX, RS2_EX, RD_EX,
              MemtoReg_EX, RegWrite_EX, MemWrite_EX, MemRead_EX,
              ALUop_out, ALUSrc_out, Branch_EX,
              forwardA, forwardB,
              ALU_DATA_WB, ALU_MEM,
              ZERO_EX,
              ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_MUX);
    
    hazard_detection uut_hazard_detection(RD_EX, RS1_ID, RS2_ID, MemRead_EX, PCwrite, ID_IDwrite, control_sel);            
    
    wire [31:0] REG_DATA2_MEM;
    wire [4:0] RD_MEM;
    wire ZERO_MEM;
    
    wire MemRead_MEM, MemWrite_MEM, MemtoReg_MEM, RegWrite_MEM, Branch_MEM;
    
    wire EX_MEM_write;
    
    EX_MEM_reg EX_MEM_Reg(clk, reset, 1'b1,
                          PC_BRANCH_EX, ALU_OUT_EX, REG_DATA2_EX_FINAL, RD_EX,
                          MemRead_EX, MemWrite_EX, Branch_EX, MemtoReg_EX, RegWrite_EX, ZERO_EX,
                          PC_MEM, ALU_MEM, REG_DATA2_MEM, RD_MEM,
                          MemRead_MEM, MemWrite_MEM, Branch_MEM, MemtoReg_MEM, RegWrite_MEM, ZERO_MEM);
                          
    data_memory uut_data_memory(clk, MemRead_MEM, MemWrite_MEM, ALU_MEM, REG_DATA2_MEM,
                                DATA_MEMORY_MEM);
                                
    wire MEM_WB_write;
    
    wire [31:0] ALU_WB;
    wire [31:0] DATA_MEMORY_WB;
    
    wire MemtoReg_WB;
    
    MEM_WB_reg MEM_WB_Reg(clk, reset, 1'b1,
                          DATA_MEMORY_MEM, ALU_MEM, RD_MEM, MemtoReg_MEM, RegWrite_MEM,
                          DATA_MEMORY_WB, ALU_WB, RD_WB, MemtoReg_WB, RegWrite_WB);                         
    
    mux2_1 mux_mem_wb(ALU_WB, DATA_MEMORY_WB, MemtoReg_WB, ALU_DATA_WB);
    
    forwarding uut_forwarding(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_WB, RegWrite_WB,
                              forwardA, forwardB);
                              
    assign pipeline_stall = control_sel;
    
    reg rez;
    always@(*) begin
        if(Branch_MEM == 1&& ZERO_MEM == 1) begin
            rez = 1;
        end
        else begin
            rez = 0;                          
        end
    end
    
    assign PCSrc = rez;
    
endmodule
