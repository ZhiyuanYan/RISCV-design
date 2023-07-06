module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);

always@(*) begin
    if(ALUop == 2'b00) begin // ld, sd
        ALUinput <= 4'b0010;
    end
    if(ALUop == 2'b10) begin
        if((funct3 == 3'b000) && (funct7 == 7'b0000000)) begin // add
            ALUinput <= 4'b0010;
        end
        else if((funct3 == 3'b000) && (funct7 == 7'b0100000)) begin // sub
            ALUinput <= 4'b0110;
        end
        else if((funct3 == 3'b111) && (funct7 == 7'b0000000)) begin // and
            ALUinput <= 4'b0000;
        end
        else if((funct3 == 3'b110) && (funct7 == 7'b0000000)) begin // or
            ALUinput <= 4'b0001;
        end
        else if((funct3 == 3'b100) && (funct7 == 7'b0000000)) begin // xor
            ALUinput <= 4'b0011;
        end
        else if((funct3 == 3'b101) && (funct7 == 7'b0000000)) begin // srl, srli
            ALUinput <= 4'b0101;
        end
        else if((funct3 == 3'b001) && (funct7 == 7'b0000000)) begin // sll, slli
            ALUinput <= 4'b0100;
        end
        else if((funct3 == 3'b101) && (funct7 == 7'b0100000)) begin // sra, srai
            ALUinput <= 4'b1001;
        end
        else if((funct3 == 3'b011) && (funct7 == 7'b0000000)) begin // sltu
            ALUinput <= 4'b0111;
        end
        else if((funct3 == 3'b010) && (funct7 == 7'b0000000)) begin // slt
            ALUinput <= 4'b1000;
        end
    end
    if(ALUop == 2'b01) begin
        if((funct3 == 3'b000) || (funct3 == 3'b001)) begin // beq || bne
            ALUinput <= 4'b0110;
        end
        if((funct3 == 3'b100) || (funct3 == 3'b101)) begin // blt || bge
            ALUinput <= 4'b1000;
        end
        if((funct3 == 3'b110) || (funct3 == 3'b111)) begin // bltu || bgeu
            ALUinput <= 4'b0111;
        end
    end
end
            
endmodule
