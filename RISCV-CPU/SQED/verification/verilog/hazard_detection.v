module hazard_detection(input [4:0] rd,
                        input [4:0] rs1,
                        input [4:0] rs2,
                        input MemRead,
                        output reg PCwrite,
                        output reg IF_IDwrite,
                        output reg control_sel);

always@(*) begin
    if(MemRead && ((rd == rs1) || (rd == rs2))) begin
        PCwrite = 0;
        IF_IDwrite = 0;
        control_sel = 1;
    end
    else begin
        PCwrite = 1;
        IF_IDwrite = 1;
        control_sel = 0;
    end
end

endmodule
