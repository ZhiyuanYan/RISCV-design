module IF_ID_reg(clk,reset,outside_reset,write,pc_in,qed_vld_out,instruction_in, pc_out, instruction_out,qed_vld_out_if_id);
  
  input clk,write,reset, qed_vld_out,outside_reset;
  input [31:0] pc_in;
  input [31:0] instruction_in;
  
  output reg [31:0] pc_out;
  output reg [31:0] instruction_out;
  output reg [31:0] qed_vld_out_if_id;
  always@(posedge clk) begin
    if (reset) begin
      pc_out<=32'b0;
      instruction_out<=32'b0;
    end
    else begin
      if(write) begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
      end
    end
  end
  always@(posedge clk) begin
  if(outside_reset)
    qed_vld_out_if_id <= 0;
  else
    qed_vld_out_if_id <= qed_vld_out;
  end
endmodule
