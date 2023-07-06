module ID_EX_reg(input clk, reset, write,
                 input [31:0] pc_in, reg_data1_in, reg_data2_in,
                 input [4:0] rs1_in, rs2_in, rd_in,
                 input [1:0] aluOp_in,
                 input aluSrc_in,
                 input memRead_in, memWrite_in, branch_in, memtoReg_in, regWrite_in,
                 input [2:0] funct3_in,
                 input [6:0] funct7_in,
                 input [31:0] imm_in,
                 output reg [31:0] pc_out, reg_data1_out, reg_data2_out,
                 output reg [4:0] rs1_out, rs2_out, rd_out,
                 output reg [1:0] aluOp_out,
                 output reg aluSrc_out,
                 output reg memRead_out, memWrite_out, branch_out, memtoReg_out, regWrite_out,
                 output reg [2:0] funct3_out,
                 output reg [6:0] funct7_out,
                 output reg [31:0] imm_out);
                 
always@(posedge clk) begin
    if(reset) begin
        pc_out <= 32'b0;
        reg_data1_out <= 32'b0;
        reg_data2_out <= 32'b0;
        rs1_out <= 5'b0;
        rs2_out <= 5'b0;
        rd_out <= 5'b0;
        aluOp_out <= 2'b0;
        aluSrc_out <= 0;
        memRead_out <= 0;
        memWrite_out <= 0;
        branch_out <= 0;
        memtoReg_out <= 0;
        regWrite_out <= 0;
        funct3_out <= 3'b0;
        funct7_out <= 7'b0;
        imm_out <= 32'b0;
    end
    else begin
        if(write) begin
            pc_out <= pc_in;
            reg_data1_out <= reg_data1_in;
            reg_data2_out <= reg_data2_out;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;
            rd_out <= rd_in;
            aluOp_out <= aluOp_in;
            aluSrc_out <= aluSrc_in;
            memRead_out <= memRead_in;
            memWrite_out <= memWrite_in;
            branch_out <= branch_in;
            memtoReg_out <= memtoReg_in;
            regWrite_out <= regWrite_in;
            funct3_out <= funct3_in;
            funct7_out <= funct7_in;
            imm_out <= imm_in;
        end
    end
end

endmodule
