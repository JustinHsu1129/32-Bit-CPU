# 32 Bit MIPS CPU

This is a 32 bit MIPS CPU that closely follows the CPU described here: https://www.fpga4student.com/2017/06/32-bit-pipelined-mips-processor-in-verilog-1.html. However this CPU is written behaviorally rather than structurally.

This CPU has a 5 stage pipeline and includes modules for forwarding, flush control, stall control, and solving hazards.

## Layout

Layout of this CPU has been done with openlane2. I am still in the process of implementing low power techniques such as clock gating and different voltage domains. I plan to create a custom PDN as well as clock tree, but I haven't had the time to do so yet. Maybe someday when school decides to stop giving me work I'll have time to get back to it.

There is a VCD file generated from running the testbench through icarus verilog. However, when I try to upload the VCD file onto the openroad GUI for power analysis purposes, it refuses to read the VCD file and I have 0 idea as to why exactly. As a result, there is no IR analysis or power density analysis, which really sucks.

## Layout

![Layout](Images/Pasted%20image%2020250915004236.png)

## Placement Density

![Placement Density](Images/Pasted%20image%2020250915223449.png)

## Power Density

yeah idk why this isn't working lmao. Can't upload the VCD file, tells me there's an error on line 233 for a unknown variable that does not exist on line 233. 0 idea what the issue could possibly be. ChatGPT has not been helpful in diagnosing the issue.

![Power Density](Images/Pasted%20image%2020250915223621.png)

## Routing Congestion

![Routing Congestion](Images/Pasted%20image%2020250915223638.png)

## Estimated Congestion (RUDY)

This is the approximate routing congestion as determined by the RUDY metric, where RUDY = rectangular uniform wire density. RUDY assumes the wire demand is spread uniformly across the rectangle.

![Estimated Congestion (RUDY)](Images/Pasted%20image%2020250915223850.png)

## IR Drop

yeah same issue as power density idk why this isn't working either. Cannot upload VCD so it seems like it's only tracking static power so there is basically 0 voltage drop across the entire chip.

![IR Drop](/Users/jhsu2022/my_designs/32-Bit-CPU/Images/Pasted%image%20250915224006.png)
