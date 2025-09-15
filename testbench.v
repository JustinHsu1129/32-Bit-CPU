module MIPSStimulus();
parameter ClockDelay = 100;
reg clk, reset;
wire [31:0] current_pc; 

// Use the synthesized netlist
MIPSpipeline myMIPS(clk, reset, current_pc);  // Check actual port names from synthesized file

initial clk = 0;
always #(ClockDelay/2) clk = ~clk;

initial begin
    $dumpfile("mips_gate_level.vcd");
    $dumpvars(0, MIPSStimulus);
    
    reset = 1;
    #(ClockDelay/4);
    reset = 0;
    
    $finish;
end
endmodule