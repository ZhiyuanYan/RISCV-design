clear -all
analyze -sva QEDFiles/qed.v
analyze -sva QEDFiles/qed_i_cache.v
analyze -sva QEDFiles/modify_instruction.v
analyze -sva QEDFiles/inst_constraints.v
analyze -sva QEDFiles/qed_decoder.v
analyze -sva QEDFiles/inst_constraints.v
analyze -sva QEDFiles/qed_instruction_mux.v
analyze -sva verilog/ALU.v 
analyze -sva verilog/DECO_INSTR.v
analyze -sva verilog/FSM.v
analyze -sva verilog/IRQ.v
analyze -sva verilog/MEMORY_INTERFACE.v
analyze -sva verilog/REG_FILE.v 
analyze -sva verilog/mriscvcore.v 
analyze -sva verilog/UTILITY.v
analyze -sva verilog/MULT.v 
elaborate -top top -bbox_a 9000
#reset ~outside_resetn ~rstn
reset ~outside_resetn
clock clk
prove -bg -all
