//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V_IF_ID(input clk,   //semnalul de ceas global
                    input reset, //semnalul de reset global
                    
                    //semnale provenite din stagii viitoare
                    //sunt pre-setate pentru aceasta lucrare
                    //vor fi discutate in lucrarile urmatoare
                    input IF_ID_write,       //semnal de scriere pentru registrul de pipeline IF_ID
                    input PCSrc,PC_write,    //semnale de control pentru PC
                    input [31:0] PC_Branch,  //PC-ul calculat in etapa EX pentru instructiunile de salt
                    input RegWrite_WB,       //semnal de activare a scrierii in bancul de registri
                    input [31:0] ALU_DATA_WB,//rezultatul calculat de ALU
                    input [4:0] RD_WB,       //registrul rezultat in care se face scrierea
                    
                    //semnale de iesire din ID
                    //vor fi vizualizate pe simulare
                    output [31:0] PC_ID,          //adresa PC a instructiunii din etapa ID
                    output [31:0] INSTRUCTION_ID, //instructiunea curenta in etapa ID
                    output [31:0] IMM_ID,         //valoarea calculata
                    output [31:0] REG_DATA1_ID,   //valoarea primului registru sursa citit
                    output [31:0] REG_DATA2_ID,   //valoarea celui de-al doilea registru sursa citit
                    
                    output [2:0] FUNCT3_ID,  //funct3 din codificarea instructiunii
                    output [6:0] FUNCT7_ID,  //funct7 din codificarea instructiunii
                    output [6:0] OPCODE_ID,     //opcode-ul instructiunii
                    output [4:0] RD_ID,      //registru destinatie
                    output [4:0] RS1_ID,     //registru sursa1
                    output [4:0] RS2_ID);    //registru sursa2 
                    
                    
                    //semnalele de control generate in ID
                    //output RegWrite_ID,  //semnal pentru scrierea in bancul de registri
                    //output MemtoReg_ID,  //semnal pentru scrierea din memorie in registru
                    //output MemRead_ID,   //semnal pentru citirea din memoria de date
                    //output MemWrite_ID,  //semnal pentru scrierea in memoria de date
                    //output [1:0] ALUop_ID, //codificarea operatiei efectuate de ALU 
                    //output ALUSrc_ID,      //semnal pentru alegerea operanzilor in ALU
                    //output Branch_ID);     //semnal pentru instructiuni de salt
  
  //////////////////////////////////////////IF signals////////////////////////////////////////////////////////
  wire [31:0] PC_IF;               //current PC
  wire [31:0] INSTRUCTION_IF;
  
 
 /////////////////////////////////////IF Module/////////////////////////////////////
 IF instruction_fetch(clk, reset, 
                      PCSrc, PC_write,
                      PC_Branch,
                      PC_IF,INSTRUCTION_IF);
  
  
 //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
 IF_ID_reg IF_ID_REGISTER(clk,reset,
                          IF_ID_write,
                          PC_IF,INSTRUCTION_IF,
                          PC_ID,INSTRUCTION_ID);
  
  
 ////////////////////////////////////////ID Module//////////////////////////////////
 ID instruction_decode(clk,
                       PC_ID,INSTRUCTION_ID,
                       RegWrite_WB, 
                       ALU_DATA_WB,
                       RD_WB,
                       IMM_ID,
                       REG_DATA1_ID,REG_DATA2_ID,
                       FUNCT3_ID,
                       FUNCT7_ID,
                       OPCODE_ID,
                       RD_ID,
                       RS1_ID,
                       RS2_ID);
 

  
  
                                               
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
