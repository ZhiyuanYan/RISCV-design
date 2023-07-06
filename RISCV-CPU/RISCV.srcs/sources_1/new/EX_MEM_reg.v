module EX_MEM_reg(input clk, reset, write,
                  input [31:0] pc_branch_in, alu_res_in, reg_data2_in,
                  input [4:0] rd_in,
                  input memRead_in, memWrite_in, branch_in, memtoReg_in, regWrite_in,
                  input alu_zero_in,
                  output reg [31:0] pc_branch_out, alu_res_out, reg_data2_out,
                  output reg [4:0] rd_out,
                  output reg memRead_out, memWrite_out, branch_out, memtoReg_out, regWrite_out,
                  output reg alu_zero_out);

always@(posedge clk) begin
    if(reset) begin
        pc_branch_out <= 32'b0;
        alu_res_out <= 32'b0;
        reg_data2_out <= 32'b0;
        rd_out <= 5'b0;
        memRead_out <= 0;
        memWrite_out <= 0;
        branch_out <= 0;
        memtoReg_out <= 0;
        regWrite_out <= 0;
        alu_zero_out <= 0;
    end
    else begin
        if(write) begin
            pc_branch_out <= pc_branch_in;
            alu_res_out <= alu_res_in;
            reg_data2_out <= reg_data2_in;
            rd_out <= rd_in;
            memRead_out <= memRead_in;
            memWrite_out <= memWrite_in;
            branch_out <= branch_in;
            memtoReg_out <= memtoReg_in;
            regWrite_out <= regWrite_in;
            alu_zero_out <= alu_zero_in;
        end
    end
end

endmodule
