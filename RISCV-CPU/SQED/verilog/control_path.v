module control_path(input [6:0] opcode,
                    input control_sel,
                    output reg MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc,
                    output reg [1:0] ALUop);

always@(*) begin
    if(control_sel == 'b1) begin
        MemRead <= 'b0;
        MemtoReg <= 'b0;
        MemWrite <= 'b0;
        RegWrite <= 'b0;
        Branch <= 'b0;
        ALUSrc <= 'b0;
        ALUop <= 2'b00;
    end
end
                    
always@(opcode) begin
    if(control_sel == 'b0) begin
    casex(opcode)
      7'b0000000: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000; //nop from ISA
      7'b0000011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b11110000; //lw
      7'b0100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10001000; //sw
      7'b0110011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00100010; //R32-format
      7'b0010011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10100010; //Register32-Immediate Arithmetic Instructions
      7'b1100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000101; //branch instructions
    endcase
    end
end
                    
endmodule
