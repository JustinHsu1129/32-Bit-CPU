# 32 Bit MIPS CPU

This is a 32 bit MIPS CPU that closely follows the CPU described here: https://www.fpga4student.com/2017/06/32-bit-pipelined-mips-processor-in-verilog-1.html. However this CPU is written behaviorally rather than structurally.

This CPU has a 5 stage pipeline and includes modules for forwarding, flush control, stall control, and solving hazards.

## Layout

Layout of this CPU has been done with openlane2. I am still in the process of implementing low power techniques such as clock gating and different voltage domains. I plan to create a custom PDN as well as clock tree, but I haven't had the time to do so yet. Maybe someday when school decides to stop giving me work I'll have time to get back to it.

There is a VCD file generated from running the testbench through icarus verilog. However, when I try to upload the VCD file onto the openroad GUI for power analysis purposes, it refuses to read the VCD file and I have 0 idea as to why exactly. As a result, there is no IR analysis or power density analysis, which really sucks.

