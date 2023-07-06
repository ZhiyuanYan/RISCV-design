`timescale 1ns / 1ps

module Sim_DecInstru1;

	// Inputs
	reg [31:0] inst;
	reg clock;
	reg resetDec;
	reg enableDec;

	// Outputs
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [31:0] imm_out;
	wire [11:0] codif;
//	wire state;

	// Instantiate the Unit Under Test (UUT)
	DECO_INSTR uut (
		.inst(inst), 
		.clock(clock),
		.resetDec(resetDec),
		.enableDec(enableDec),
		.rs1(rs1), 
		.rs2(rs2), 
		.rd(rd), 
		.imm_out(imm_out), 
		.codif(codif)
//		.state(state)
	);




	initial begin
		// Initialize Inputs
	//	always
clock=0;
//#40;

//INSTRUCCI�N AUIPC, RESET
inst = 32'b00001111000011110000111100010111;
resetDec=1;  
enableDec=0;                                                                                       
#20;
//INSTRUCCI�N AUIPC (#1)
inst = 32'b00001111000011110000111100010111;
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N lui (#2)

inst = 32'b00001111000011110000111100110111;
resetDec=0; 
enableDec=1;                                                                                           
#20;


//INSTRUCCI�N JAL (#3) funcional
inst = 32'b00001111000011110000111101101111;
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N JAL (#3) reset desactivado y enable desactivado
inst = 32'b00001111000011110000111101101111;
resetDec=0;
enableDec=0; 
#20
//INSTRUCCI�N JAL (#3) reset activado y enable activado
inst = 32'b00001111000011110000111101101111;
resetDec=1;
enableDec=1; 
#20
//INSTRUCCI�N JAL (#3) reset desactivado y enable desactivado
inst = 32'b00001111000011110000111101101111;
resetDec=0;
enableDec=0; 
#20

//Instrucci�n BEQ (#4)
inst = {7'b1010101,5'b00011,5'b00110,3'b000,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n BNE (#5)
inst = {7'b1010101,5'b00011,5'b00110,3'b001,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20

//Instrucci�n BLT (#6)
inst = {7'b1010101,5'b00011,5'b00110,3'b100,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n BGE (#7)
inst = {7'b1010101,5'b00011,5'b00110,3'b101,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n BLTU (#8)
inst = {7'b1010101,5'b00011,5'b00110,3'b110,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n BGEU (#9)
inst = {7'b1010101,5'b00011,5'b00110,3'b111,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SB (#10)
inst = {7'b1010101,5'b00011,5'b00110,3'b000,5'b11011,7'b0100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SH (#11)
inst = {7'b1010101,5'b00011,5'b00110,3'b001,5'b11011,7'b0100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SW (#12)
inst = {7'b1010101,5'b00011,5'b00110,3'b010,5'b11011,7'b0100011};
resetDec=0;
enableDec=1; 
#20

//Instrucci�n LB (#13)
inst = {7'b1010101,5'b00011,5'b00110,3'b000,5'b11011,7'b0000011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n LH (#14)
inst = {7'b1010101,5'b00011,5'b00110,3'b001,5'b11011,7'b0000011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n LW (#15)
inst = {7'b1010101,5'b00011,5'b00110,3'b010,5'b11011,7'b0000011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n LBU (#16)
inst = {7'b1010101,5'b00011,5'b00110,3'b100,5'b11011,7'b0000011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n LHU (#17)
inst = {7'b1010101,5'b00011,5'b00110,3'b101,5'b11011,7'b0000011};
resetDec=0;
enableDec=1; 
#20

//Instrucci�n ADDI (#18)
inst = {7'b1010101,5'b00011,5'b00110,3'b000,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SLTI (#19)
inst = {7'b1010101,5'b00011,5'b00110,3'b010,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n sltiu (#20)
inst = {7'b1010101,5'b00011,5'b00110,3'b011,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n XORI (#21)
inst = {7'b1010101,5'b00011,5'b00110,3'b100,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n ORI (#22)
inst = {7'b1010101,5'b00011,5'b00110,3'b110,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n ANDI (#23)
inst = {7'b1010101,5'b00011,5'b00110,3'b111,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SLLI (#24)
inst = {7'b0000000,5'b00011,5'b00110,3'b001,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SRLI (#25)
inst = {7'b0000000,5'b00011,5'b00110,3'b101,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n SRAI (#26)
inst = {7'b0100000,5'b00011,5'b00110,3'b101,5'b11011,7'b0010011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n JALR (#27)
inst = {17'b010000000011,5'b00100,3'b000,5'b11011,7'b1100111};
resetDec=0;
enableDec=1; 
#20


//INSTRUCCI�N add (#28)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b000, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N sub (#29)
inst = {2'b01,{5{1'b0}},5'b11001,5'b11001,3'b000, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N sll (#30)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b001, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N slt (#31)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b010, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N sltu (#32)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b011, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N xor (#33)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b100, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N srl (#34)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b101, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N sra (#35)
inst = {2'b01,{5{1'b0}},5'b11001,5'b11001,3'b101, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N or (#36)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b110, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N and (#37)
inst = {2'b00,{5{1'b0}},5'b11001,5'b11001,3'b111, 5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20

//IRQ
//INSTRUCCI�N SBREAK (#38)
inst = {{11{1'b0}},1'b1,{13{1'b0}},7'b0011000};
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N ADDRMS (#39) rs1=00100
inst = {{12{1'b0}},5'b00100,3'b001,5'b00000,7'b0011000};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N ADDRME (#40) 
inst = {{17{1'b0}},3'b010,5'b00100,7'b0011000};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N TISIRR (#41) rs1=00100
inst = {{7{1'b0}},5'b00100,5'b00100,3'b011,5'b00000,7'b0011000};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N IRRSTATE (#42) 
inst = {{17{1'b0}},3'b100,5'b00100,7'b0011000};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N clraddrm (#43) 
inst = {{17{1'b0}},3'b101,5'b00000,7'b0011000};
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N CLRIRQ (#44)
inst = {12'b101010101010,5'b00100,3'b110, 5'b00000,7'b0011000};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N RETIRQ (#45) 
inst = {{17{1'b0}},3'b111,5'b00000,7'b0011000};
resetDec=0;
enableDec=1; 
#20

//MULTIPLICADOR
//INSTRUCCI�N MUL (#46)
inst = {{6{1'b0}},1'b1,5'b00011,5'b00110,3'b000,5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N MULH (#47)
inst = {{6{1'b0}},1'b1,5'b00011,5'b00110,3'b001,5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N MULHSU (#48)
inst = {{6{1'b0}},1'b1,5'b00011,5'b00110,3'b010,5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N MULHU (#49)
inst = {{6{1'b0}},1'b1,5'b00011,5'b00110,3'b011,5'b11001,7'b0110011};
resetDec=0;
enableDec=1; 
#20


//INSTRUCCIONES INV�LIDAS
//Instrucci�n tipo sb inv�lida 5,6
inst = {7'b1010101,5'b00011,5'b00110,3'b010,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n tipo sb inv�lida
inst = {7'b1010101,5'b00011,5'b00110,3'b011,5'b11011,7'b1100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n Inv�lida tipo s
inst = {7'b1010101,5'b00011,5'b00110,3'b100,5'b11011,7'b0100011};
resetDec=0;
enableDec=1; 
#20
//Instrucci�n TIPO i inv�lida 17
inst = {7'b1010101,5'b00011,5'b00110,3'b111,5'b11011,7'b0000011};
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N 24-26 (INV�LIDA)
inst = 32'b00001111000011110001111100010011;
resetDec=0;
enableDec=1; 
#20

//INSTRUCCI�N 28-37 (NO CUMPLE)
inst = 32'b00001111000011110000111100110011;
resetDec=0;
enableDec=1; 
#20


//UNA INSTRUCCI�N Parecida IRQ (Inv�lida)
inst = 32'b00001111000011110000111100011000;
resetDec=0;
enableDec=1; 
#20


//UNA INSTRUCCI�N DEL MULTIPLIPLICADOR (Inv�lida)
inst = 32'b00000011010101010110001100110011;
resetDec=0;
enableDec=1; 
#20


//UNA INSTRUCCI�N DEL MULTIPLIPLICADOR (Inv�lida)
inst = 32'b00001111000011110000111100110011;
resetDec=0;
enableDec=1; 
#20
//INSTRUCCI�N DIFERENTE A LAS CODIFICADAS (opcode distinto)
inst = 32'b10001111000011110000111100110011;
resetDec=0;
enableDec=1; 
#20



//INSTRUCCI�N DIFERENTE A LAS CODIFICADAS2 (opcode distinto)
inst = 32'b00001111000011110000111111111111;
resetDec=0;
enableDec=1; 
		
		// Wait 100 ns for global reset to finish
	//	#100;
        
		// Add stimulus here
end

always #5 clock=~clock;   
endmodule
