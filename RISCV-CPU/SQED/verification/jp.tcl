clear -all
analyze -sva ./QEDFiles/qed.v
analyze -sva ./QEDFiles/qed_i_cache.v
analyze -sva ./QEDFiles/modify_instruction.v
analyze -sva ./QEDFiles/inst_constraints.v
analyze -sva ./QEDFiles/qed_decoder.v
analyze -sva ./QEDFiles/inst_constraints.v
analyze -sva ./QEDFiles/qed_instruction_mux.v
analyze -sva ./verilog/ALU.v
analyze -sva ./verilog/ALUcontrol.v 
analyze -sva ./verilog/control_path.v
analyze -sva ./verilog/data_memory.v
analyze -sva ./verilog/EX_MEM_reg.v 
analyze -sva ./verilog/EX.v 
analyze -sva ./verilog/forwarding.v 
analyze -sva ./verilog/hazard_detection.v 
analyze -sva ./verilog/ID_EX_reg.v
analyze -sva ./verilog/ID.v
analyze -sva ./verilog/if_id_pipe.v
analyze -sva ./verilog/IF.v
analyze -sva ./verilog/mux3_1.v 
analyze -sva ./verilog/RISC_V.v
analyze -sva ./verilog/adder.v
analyze -sva ./verilog/registers.v
analyze -sva ./verilog/mux2_1.v
analyze -sva ./verilog/imm_gen.v
analyze -sva ./verilog/instruction_memory.v
analyze -sva ./verilog/PC.v
analyze -sva ./verilog/MEM_WB_reg.v
elaborate -top top -bbox_a 9000
reset outside_reset reset
#set_engine_mode {B  I}
clock clk
prove -bg -all
