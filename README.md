# RISC-V Cores with SQED Detection
This repository contains several RISC-V cores based on Verilog design that incorporate SQED modules.
 

1. mriscvcore (Original repository: [link](https://github.com/onchipuis/mriscvcore))
     The MRISCVCORE RISC-V core with the QED module has been added to JasperGold for testing purposes in this repository. When model checking process starts from reset, the result is safe. However, when starting from a symbolic starting state, the result is deemed unsafe. This occurs because, despite the instructions being transmitted from QED module correctly, one of them is not executed and gets flushed due to the presence of a duplicate instruction.

2. RISCV-CPU (Original repository: [link](https://github.com/georgetoader/RISCV-CPU))
      In this repository, the RISCV-CPU RISC-V core is being developed with an ongoing effort to add the QED module. Currently, there are some bugs that need to be fixed. You can find the core and the QED module in the "RISCV-CPU/SQED" folder.

3. Tang_E203_Mini (Original repository: [link](https://github.com/Lichee-Pi/Tang_E203_Mini))
     The Tang_E203_Mini repository contains a RISC-V core; however, there are additional modules present that are not part of the core. Further work is required to remove these additional components.

4. tinyriscv (Original repository: [link](https://github.com/liangkangnan/tinyriscv))
     The tinyriscv repository is dedicated to developing a RISC-V core. Similar to RISCV-CPU, the QED module is being added, but there are known bugs that need fixing. You can find the core and the QED module in the "tinyriscv/SQED" folder.
