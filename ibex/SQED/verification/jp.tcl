clear -all
analyze -sva ./QEDFiles/qed.v
analyze -sva ./QEDFiles/qed_i_cache.v
analyze -sva ./QEDFiles/modify_instruction.v
analyze -sva ./QEDFiles/inst_constraints.v
analyze -sva ./QEDFiles/qed_decoder.v
analyze -sva ./QEDFiles/qed_instruction_mux.v
analyze -sv12 ./system_verilog/ibex_pkg.sv
analyze -sv12 ./system_verilog/ibex_tracer_pkg.sv
analyze -sv12 ./system_verilog/ibex_alu.sv
analyze -sv12 ./system_verilog/ibex_compressed_decoder.sv
analyze -sv12 ./system_verilog/ibex_controller.sv
analyze -sv12 ./system_verilog/ibex_core.sv
analyze -sv12 ./system_verilog/ibex_counter.sv
analyze -sv12 ./system_verilog/ibex_cs_registers.sv
analyze -sv12 ./system_verilog/ibex_csr.sv
analyze -sv12 ./system_verilog/ibex_decoder.sv
analyze -sv12 ./system_verilog/ibex_ex_block.sv
analyze -sv12 ./system_verilog/ibex_fetch_fifo.sv
analyze -sv12 ./system_verilog/ibex_icache.sv
analyze -sv12 ./system_verilog/ibex_id_stage.sv
analyze -sv12 ./system_verilog/ibex_if_stage.sv
analyze -sv12 ./system_verilog/ibex_load_store_unit.sv
analyze -sv12 ./system_verilog/ibex_lockstep.sv
analyze -sv12 ./system_verilog/ibex_multdiv_fast.sv
analyze -sv12 ./system_verilog/ibex_multdiv_slow.sv
#analyze -sv12 ./system_verilog/ibex_pmp_reset_default.svh
analyze -sv12 ./system_verilog/ibex_pmp.sv
analyze -sv12 ./system_verilog/ibex_prefetch_buffer.sv
analyze -sv12 ./system_verilog/ibex_register_file_ff.sv
analyze -sv12 ./system_verilog/ibex_wb_stage.sv
analyze -sv12 ./system_verilog/prim_buf.sv
analyze -sv12 ./system_verilog/prim_generic_buf.sv

elaborate -top top -bbox_a 9000 -bbox_mul 9000
reset ~outside_rstn ~rst_ni -non_resettable_regs 0

#set_engine_mode {B  I}
clock clk_i
prove -bg -all