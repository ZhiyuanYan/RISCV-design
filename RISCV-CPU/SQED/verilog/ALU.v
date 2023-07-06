module ALU(input [3:0] ALUop,
           input [31:0] ina, inb,
           output zero,
           output reg [31:0] out);

always@(*) begin
    if(ALUop == 4'b0010) begin // ld, sd, add
        out <= ina + inb; 
    end
    else if(ALUop == 4'b0110) begin // sub, beq, bne
        out <= ina - inb; 
    end
    else if(ALUop == 4'b0000) begin // and
        out <= ina & inb;
    end
    else if(ALUop == 4'b0001) begin // or
        out <= ina | inb;
    end
    else if(ALUop == 4'b0011) begin // xor
        out <= ina ^ inb;
    end
    else if(ALUop == 4'b0101) begin //srl, srli   
        out <= ina >> inb[4:0];
    end
    else if(ALUop == 4'b0100) begin //sll, slli
        out <= ina << inb[4:0];
    end
    else if(ALUop == 4'b1001) begin // sra, srai
        out <= ina >>> inb[4:0];
    end
    else if(ALUop == 4'b0111) begin // sltu, bltu, bgeu
        if(inb != 0) begin
            out <= 1;
        end
        else begin
            out <= 0;
        end
    end
    else if(ALUop == 4'b1000) begin // slt, blt, bge
        if(ina < inb) begin
            out <= 1;
        end
        else begin
            out <= 0;
        end
    end
end

assign zero = out ? 0 : 1;         

endmodule
