module MEM_WB_reg(input clk, reset, write,
                  input [31:0] read_data_in, alu_res_in,
                  input [4:0] rd_in,
                  input memtoReg_in, regWrite_in,
                  output reg [31:0] read_data_out, alu_res_out,
                  output reg [4:0] rd_out,
                  output reg memtoReg_out, regWrite_out);
                  
always@(posedge clk) begin
    if(reset) begin
        read_data_out <= 0;
        alu_res_out <= 0;
        rd_out <= 0;
        memtoReg_out <= 0;
        regWrite_out <= 0;
    end
    else begin
        if(write) begin
            read_data_out <= read_data_in;
            alu_res_out <= alu_res_in;
            rd_out <= rd_in;
            memtoReg_out <= memtoReg_in;
            regWrite_out <= regWrite_in;
        end
    end
end
                  
endmodule
