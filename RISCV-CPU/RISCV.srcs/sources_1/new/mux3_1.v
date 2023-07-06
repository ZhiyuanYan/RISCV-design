module mux3_1(input [31:0] ina, inb, inc,
              input [1:0] sel,
              output reg [31:0] out);
              
always@(*) begin
    if(sel == 2'b00) begin
        out <= ina;
    end
    else if(sel == 2'b01) begin
        out <= inb;
    end
    else if(sel == 2'b10) begin
        out <= inc;
    end
end
              
endmodule
