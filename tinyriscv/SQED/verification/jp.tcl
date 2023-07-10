clear -all
analyze -sva ./QEDFiles/qed.v
analyze -sva ./QEDFiles/qed_i_cache.v
analyze -sva ./QEDFiles/modify_instruction.v
analyze -sva ./QEDFiles/inst_constraints.v
analyze -sva ./QEDFiles/qed_decoder.v
analyze -sva ./QEDFiles/inst_constraints.v
analyze -sva ./QEDFiles/qed_instruction_mux.v
analyze -sva ./verilog/clint.v
analyze -sva ./verilog/csr_reg.v
analyze -sva ./verilog/ctrl.v
analyze -sva ./verilog/defines.v
analyze -sva ./verilog/div.v
analyze -sva ./verilog/ex.v
analyze -sva ./verilog/full_handshake_tx.v
analyze -sva ./verilog/full_handshake_rx.v
analyze -sva ./verilog/gen_dff.v
analyze -sva ./verilog/gen_buf.v
analyze -sva ./verilog/id.v
analyze -sva ./verilog/id_ex.v
analyze -sva ./verilog/if_id.v
analyze -sva ./verilog/pc_reg.v
analyze -sva ./verilog/regs.v
analyze -sva ./verilog/rib.v
analyze -sva ./verilog/tinyriscv.v
elaborate -top top -bbox_a 9000 -bbox_mul 9000
reset ~outside_rst ~rst
#set_engine_mode {B  I}
clock clk
prove -bg -all
