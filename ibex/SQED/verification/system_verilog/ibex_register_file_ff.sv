// Copyright lowRISC contributors.
// Copyright 2018 ETH Zurich and University of Bologna, see also CREDITS.md.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

/**
 * RISC-V register file
 *
 * Register file with 31 or 15x 32 bit wide registers. Register 0 is fixed to 0.
 * This register file is based on flip flops. Use this register file when
 * targeting FPGA synthesis or Verilator simulation.
 */
module ibex_register_file_ff #(
  parameter bit                   RV32E             = 0,
  parameter int unsigned          DataWidth         = 32,
  parameter bit                   DummyInstructions = 0,
  parameter bit                   WrenCheck         = 0,
  parameter logic [DataWidth-1:0] WordZeroVal       = '0
) (
  // Clock and Reset
  input  logic                 clk_i,
  input  logic                 rst_ni,
  input  logic                 outside_rstn,

  input  logic                 test_en_i,
  input  logic                 dummy_instr_id_i,
  input  logic                 dummy_instr_wb_i,

  //Read port R1
  input  logic [4:0]           raddr_a_i,
  output logic [DataWidth-1:0] rdata_a_o,

  //Read port R2
  input  logic [4:0]           raddr_b_i,
  output logic [DataWidth-1:0] rdata_b_o,


  // Write port W1
  input  logic [4:0]           waddr_a_i,
  input  logic [DataWidth-1:0] wdata_a_i,
  input  logic                 we_a_i,

  // This indicates whether spurious WE are detected.
  output logic                 err_o,
  input  logic                 qed_vld_out_id_ex,
  input  logic                 qed_vld_out_id_mid,
  input  logic                 qed_vld_out_final
);

  localparam int unsigned ADDR_WIDTH = RV32E ? 4 : 5;
  localparam int unsigned NUM_WORDS  = 2**ADDR_WIDTH;

  logic [DataWidth-1:0] rf_reg   [NUM_WORDS];
  logic [NUM_WORDS-1:0] we_a_dec;
  logic qed_vld_out_final_reg;
  always_comb begin : we_a_decoder
    for (int unsigned i = 0; i < NUM_WORDS; i++) begin
      we_a_dec[i] = (waddr_a_i == 5'(i)) ? we_a_i : 1'b0;
    end
  end

  // SEC_CM: DATA_REG_SW.GLITCH_DETECT
  // This checks for spurious WE strobes on the regfile.
  if (WrenCheck) begin : gen_wren_check
    // Buffer the decoded write enable bits so that the checker
    // is not optimized into the address decoding logic.
    logic [NUM_WORDS-1:0] we_a_dec_buf;
    prim_buf #(
      .Width(NUM_WORDS)
    ) u_prim_buf (
      .in_i(we_a_dec),
      .out_o(we_a_dec_buf)
    );

    prim_onehot_check #(
      .AddrWidth(ADDR_WIDTH),
      .AddrCheck(1),
      .EnableCheck(1)
    ) u_prim_onehot_check (
      .clk_i,
      .rst_ni,
      .oh_i(we_a_dec_buf),
      .addr_i(waddr_a_i),
      .en_i(we_a_i),
      .err_o
    );
  end else begin : gen_no_wren_check
    logic unused_strobe;
    assign unused_strobe = we_a_dec[0]; // this is never read from in this case
    assign err_o = 1'b0;
  end

  // No flops for R0 as it's hard-wired to 0
  // for (genvar i = 1; i < NUM_WORDS; i++) begin : g_rf_flops
  //   logic [DataWidth-1:0] rf_reg_q;

  //   always_ff @(posedge clk_i or negedge rst_ni or negedge outside_rstn) begin

  //     if (!rst_ni) begin
  //       rf_reg_q <= WordZeroVal;
  //     end else if (we_a_dec[i]) begin
  //       // qed_vld_out_final_reg <= qed_vld_out_final;
  //       rf_reg_q <= wdata_a_i;
  //       end

  //     end

  //   assign rf_reg[i] = rf_reg_q;
  // end
  always_ff @(posedge clk_i or negedge outside_rstn) begin
      if(~outside_rstn)
        qed_vld_out_final_reg <= 0;
      else begin
          if(we_a_i&&(waddr_a_i != 5'b0))begin
          qed_vld_out_final_reg <= qed_vld_out_final;
          rf_reg[waddr_a_i] <= wdata_a_i;
          end
    end
  end
    (* keep *)
    wire qed_ready;
    (* keep *)
    reg [15:0] num_orig_insts;
    (* keep *)
    reg [15:0] num_dup_insts;
    wire [1:0] num_orig_commits;
    wire [1:0] num_dup_commits;
	wire __NOTSTART__;
	wire qed_reach_commit;
    reg precessor;
	assign qed_reach_commit = qed_vld_out_final_reg || ((qed_vld_out_id_mid||qed_vld_out_final) && (outside_rstn) && (we_a_i) && (waddr_a_i));
	// assign qed_reach_commit = qed_vld_out_final;
    assign __NOTSTART__ = (qed_reach_commit && (num_orig_insts==0)&&(num_dup_insts==0));
	 always_ff @(posedge clk_i, negedge outside_rstn)begin
        if(~outside_rstn)
            precessor<= 0;
        else
            if(__NOTSTART__!=0)
                precessor <= 1;
    end
  assume property ((precessor)||((rf_reg[0] == rf_reg[16])&&(rf_reg[1] == rf_reg[17])&&(rf_reg[2] == rf_reg[18])&&(rf_reg[3] == rf_reg[19])&&(rf_reg[4] == rf_reg[20])&&(rf_reg[5] == rf_reg[21])
	&&(rf_reg[6] == rf_reg[22])&&(rf_reg[7] == rf_reg[23])&&(rf_reg[8] == rf_reg[24])&&(rf_reg[9] == rf_reg[25])&&(rf_reg[10] == rf_reg[26])&&(rf_reg[11] == rf_reg[27])&&(rf_reg[12] == rf_reg[28])
	&&(rf_reg[13] == rf_reg[29])&&(rf_reg[14] == rf_reg[30])&&(rf_reg[15] == rf_reg[31])));
    // wire latched_rd;
    // assign latched_rd = we_i ? waddr_i : jtag_addr_i;
    assign num_orig_commits = (qed_reach_commit == 1)&&(we_a_i==1)&&(waddr_a_i < 16)&&(waddr_a_i != 5'b0)? 2'b01 : 2'b00 ;
    assign num_dup_commits = (qed_reach_commit == 1)&&(we_a_i==1)&&(waddr_a_i >= 16)? 2'b01  : 2'b00 ;
   
  always_ff @(posedge clk_i, negedge outside_rstn)begin
	  if (~outside_rstn) begin
	   num_orig_insts <= 16'b0;
	   num_dup_insts <= 16'b0;
	  end else begin
	   num_orig_insts <= num_orig_insts + {14'b0,num_orig_commits};
	   num_dup_insts <= num_dup_insts + {14'b0,num_dup_commits};
	  end
  end

    assign qed_ready = (num_orig_insts == num_dup_insts)&&(num_orig_insts!=0);
    // assert property (rf_reg[17]==0);
    assert property ((!(qed_ready&&(qed_reach_commit)))||(rf_reg[2] == rf_reg[18]));
  // With dummy instructions enabled, R0 behaves as a real register but will always return 0 for
  // real instructions.
  if (DummyInstructions) begin : g_dummy_r0
    // SEC_CM: CTRL_FLOW.UNPREDICTABLE
    logic                 we_r0_dummy;
    logic [DataWidth-1:0] rf_r0_q;

    // Write enable for dummy R0 register (waddr_a_i will always be 0 for dummy instructions)
    assign we_r0_dummy = we_a_i & dummy_instr_wb_i;

    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        rf_r0_q <= WordZeroVal;
      end else if (we_r0_dummy) begin
        rf_r0_q <= wdata_a_i;
      end
    end

    // Output the dummy data for dummy instructions, otherwise R0 reads as zero
    assign rf_reg[0] = dummy_instr_id_i ? rf_r0_q : WordZeroVal;

  end else begin : g_normal_r0
    logic unused_dummy_instr;
    assign unused_dummy_instr = dummy_instr_id_i ^ dummy_instr_wb_i;

    // R0 is nil
    assign rf_reg[0] = WordZeroVal;
  end

  assign rdata_a_o = rf_reg[raddr_a_i];
  assign rdata_b_o = rf_reg[raddr_b_i];

  // Signal not used in FF register file
  logic unused_test_en;
  assign unused_test_en = test_en_i;

endmodule
