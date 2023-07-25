# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2022.12
# platform  : Linux 3.10.0-1160.el7.x86_64
# version   : 2022.12p001 64 bits
# build date: 2023.01.26 12:35:17 UTC
# ----------------------------------------
# started   : 2023-07-22 07:14:07 CST
# hostname  : mics-eda.(none)
# pid       : 37622
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:40515' '-style' 'windows' '-data' 'AAAAanicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpOGA8QGUYcPIgAwYAxtQaAYGVphCmBIAzrAJsQ==' '-proj' '/home/zhiyuanyan/mriscvcore/verification/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/zhiyuanyan/mriscvcore/verification/jgproject/.tmp/.initCmds.tcl'
ls
source jp_1.tcl
cover {(qed_ready&&(qed_reach_commit)}
cover {(RTL.REG_FILE_inst.MEM_FILE.qed_ready&&(qed_reach_commit))}
cover {(RTL.REG_FILE_inst.MEM_FILE.qed_ready&&(RTL.REG_FILE_inst.MEM_FILE.qed_reach_commit))}
prove -bg -property {<embedded>::cover:0}
cover {(RTL.REG_FILE_inst.MEM_FILE.qed_ready)}
prove -bg -property {<embedded>::cover:1}
cover {(RTL.REG_FILE_inst.MEM_FILE.num_orig_insts==1)}
prove -bg -property {<embedded>::cover:2}
cover {(RTL.REG_FILE_inst.MEM_FILE.num_dup_insts==1)}
prove -bg -property {<embedded>::cover:3}
cover {(RTL.MEMORY_INTERFACE.qed_vld_out==1)}
cover {(RTL.MEMORY_INTERFACE_inst.qed_vld_out==1)}
prove -bg -property {<embedded>::cover:4}
visualize -property <embedded>::cover:4 -new_window
cover {(RTL.FSM_inst.qed_vld_out_q==1)}
prove -bg -property {<embedded>::cover:5}
source jp_1.tcl
visualize -violation -property <embedded>::top.RTL.REG_FILE_inst.MEM_FILE._assert_2 -new_window
source jp_1.tcl
visualize -violation -property <embedded>::top.RTL.REG_FILE_inst.MEM_FILE._assert_2 -new_window
source jp_1.tcl
source jp_1.tcl
cover {RTL.REG_FILE_inst.MEM_FILE.qed_reach_commit}
prove -bg -property {<embedded>::cover:0}
source jp.tcl
source jp.tcl
source jp_1.tcl
source jp_1.tcl
visualize -violation -property <embedded>::top.RTL.REG_FILE_inst.MEM_FILE._assert_2 -new_window
cd 
ls
cd SQED_tinyriscv
ls
cd verification
ls
source tinyriscv.tcl
source tinyriscv.tcl
source tinyriscv.tcl
cover {precessor==0}
cover {RTL.u_regs.precessor==0}
prove -bg -property {<embedded>::cover:0}
cover {RTL.u_regs.qed_reach_commit==1}
prove -bg -property {<embedded>::cover:1}
visualize -property <embedded>::cover:1 -new_window
visualize -violation -property <embedded>::top.RTL.u_regs._assert_2 -new_window
cover {RTL.u_regs.qed_reach_commit==1}
source tinyriscv.tcl
source tinyriscv.tcl
get_reset_info
visualize -violation -property <embedded>::top.RTL.u_regs._assert_2 -new_window
get_reset_info
source tinyriscv.tcl
set_engine_mode {Hp Ht B AB D I AD M N AM G C AG G2 C2 Hps Hts Tri}
assume -disable <embedded>::top.RTL.u_regs._assume_1
assume -enable <embedded>::top.RTL.u_regs._assume_1
prove -bg -property {<embedded>::top.RTL.u_regs._assert_2}
visualize -violation -property <embedded>::top.RTL.u_regs._assert_2 -new_window
source tinyriscv.tcl
visualize -violation -property <embedded>::top.RTL.u_regs._assert_2 -new_window
source tinyriscv.tcl
cover {RTL.u_regs.qed_reach_commit}
prove -bg -property {<embedded>::cover:0}
prove -bg -property {<embedded>::cover:0}
source tinyriscv.tcl
visualize -violation -property <embedded>::top.RTL.u_regs._assert_2 -new_window
