https://www.fpga4student.com/2017/06/32-bit-pipelined-mips-processor-in-verilog-1.html

# MIPS datapath
![[Pasted image 20250906162111.png]]

This is a 32 bit 5 stage pipelined MIPS CPU

## Modules needed

1. Instruction memory
2. 32 bit adder
3. Register file
4. 32 bit ALU
5. Data memory
6. Zero extension module
7. MUX (choosing bus B)
8. Sign extension and shift left 2
9. MUX (write address)
10. Control unit
11. ALU control
12. JR Control
13. Forwarding unit
14. MUX (hazard)
15. Stall control unit
16. Flush control unit
17. WB forward unit
18. Top level
19. Testbench

Control unit control signals:

![[Pasted image 20250908200302.png]]

ALU control signals:

![[Pasted image 20250908200326.png]]

Stall control signals:

![[Pasted image 20250914204956.png]]

Final layout

![[Pasted image 20250915003425.png]]