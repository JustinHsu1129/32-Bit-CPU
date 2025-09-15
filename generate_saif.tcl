# generate_saif.tcl - Script to generate SAIF file within OpenLane flow
# This script should be placed in your design directory and referenced in config.json

proc generate_saif_file {} {
    puts "Starting SAIF file generation..."
    
    # Get the current design name and paths
    set design_name $::env(DESIGN_NAME)
    set results_path $::env(RESULTS_DIR)
    set tmp_path $::env(TMP_DIR)
    set design_path $::env(DESIGN_DIR)
    
    # Create a temporary directory for SAIF generation
    set saif_dir "${tmp_path}/saif_generation"
    file mkdir $saif_dir
    
    # Write the testbench file for SAIF generation
    set tb_file "${saif_dir}/${design_name}_saif_tb.v"
    set saif_file "${results_path}/${design_name}.saif"
    
    # Create testbench for SAIF generation
    set tb_content "
`timescale 1ns/1ps

module ${design_name}_saif_tb;

    // Clock and reset signals
    reg clk;
    reg rst;
    
    // Add your specific input/output signals here based on your MIPS pipeline
    // These should match your actual design ports
    reg \[31:0\] instruction;
    reg \[31:0\] data_in;
    wire \[31:0\] data_out;
    wire \[31:0\] pc_out;
    
    // Instantiate your design (using the synthesized netlist)
    ${design_name} dut (
        .clk(clk),
        .rst(rst),
        // Add your actual port connections here
        // .instruction(instruction),
        // .data_in(data_in),
        // .data_out(data_out),
        // .pc_out(pc_out)
        // ... other ports
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #12.5 clk = ~clk;  // 40MHz clock (25ns period)
    end
    
    // Test stimulus and SAIF file generation
    initial begin
        \$dumpfile(\"${design_name}_saif.vcd\");
        \$dumpvars(0, ${design_name}_saif_tb);
        
        // Enable SAIF dumping
        \$set_toggle_region(${design_name}_saif_tb.dut);
        \$toggle_start();
        
        // Reset sequence
        rst = 1;
        instruction = 32'h0;
        data_in = 32'h0;
        
        #100;
        rst = 0;
        #50;
        
        // Add your test vectors here
        // Example test sequence for MIPS pipeline
        repeat(1000) begin
            @(posedge clk);
            instruction = \$random;
            data_in = \$random;
        end
        
        // Stop toggle collection and generate SAIF
        \$toggle_stop();
        \$toggle_report(\"${saif_file}\", 1.0e-9, \"${design_name}_saif_tb.dut\");
        
        \$display(\"SAIF file generated: ${saif_file}\");
        \$finish;
    end
    
    // Timeout
    initial begin
        #1000000; // 1ms timeout
        \$display(\"Simulation timeout\");
        \$finish;
    end

endmodule
"
    
    # Write the testbench file
    set tb_fh [open $tb_file w]
    puts $tb_fh $tb_content
    close $tb_fh
    
    puts "Testbench written to: $tb_file"
    
    # Create simulation script
    set sim_script "${saif_dir}/run_saif_sim.tcl"
    set sim_content "
# Simulation script for SAIF generation
read_verilog ${results_path}/synthesis/${design_name}.synthesis.v
read_verilog $tb_file

# Read standard cell library
read_liberty $::env(LIB_SYNTH)

# Elaborate and simulate
synth -top ${design_name}_saif_tb
sim -clock clk -reset rst -n 10000

quit
"
    
    set sim_fh [open $sim_script w]
    puts $sim_fh $sim_content
    close $sim_fh
    
    # Alternative: Use Icarus Verilog if available
    set iverilog_script "${saif_dir}/run_iverilog.sh"
    set iverilog_content "#!/bin/bash
cd ${saif_dir}

# Compile with Icarus Verilog
iverilog -o ${design_name}_saif_sim \\
    -I${results_path}/synthesis \\
    -I$::env(PDK_ROOT)/$::env(PDK)/libs.ref/$::env(STD_CELL_LIBRARY)/verilog \\
    ${results_path}/synthesis/${design_name}.synthesis.v \\
    ${tb_file}

# Run simulation
vvp ${design_name}_saif_sim

echo \"SAIF generation completed\"
"
    
    set iverilog_fh [open $iverilog_script w]
    puts $iverilog_fh $iverilog_content
    close $iverilog_fh
    
    # Make script executable
    exec chmod +x $iverilog_script
    
    puts "SAIF generation scripts created in: $saif_dir"
    puts "To generate SAIF file, run: $iverilog_script"
    
    # Try to run the simulation automatically if iverilog is available
    if {[catch {exec which iverilog} result] == 0} {
        puts "Found Icarus Verilog, attempting to generate SAIF file..."
        if {[catch {exec $iverilog_script} sim_result] == 0} {
            puts "SAIF file generation successful!"
            puts $sim_result
        } else {
            puts "SAIF simulation failed: $sim_result"
            puts "Please run manually: $iverilog_script"
        }
    } else {
        puts "Icarus Verilog not found. Please install iverilog or run simulation manually."
        puts "Scripts available in: $saif_dir"
    }
}

# Call the procedure
generate_saif_file