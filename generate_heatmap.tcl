# generate_heatmap.tcl - Fixed power analysis and heatmap generation script
# This script runs a detailed power analysis and saves the output
# to a dedicated 'power' directory in the final results folder.

puts "--- Running Custom Power Heatmap Generation ---"

# Check if we're in the correct OpenROAD stage
if {![info exists ::env(SAVE_DIR)]} {
    if {[info exists ::env(RESULTS_DIR)]} {
        set ::env(SAVE_DIR) $::env(RESULTS_DIR)
    } else {
        puts "Warning: SAVE_DIR not found, using current directory"
        set ::env(SAVE_DIR) "."
    }
}

# Define the custom output directory inside the results folder
set power_dir "$::env(SAVE_DIR)/power"

# Create the directory if it doesn't exist
puts "Creating custom power report directory: $power_dir"
if {[catch {file mkdir $power_dir} error]} {
    puts "Error creating directory: $error"
    return
}

# Check if design is loaded and PDN exists
if {[catch {check_power_grid -net VPWR} pdn_check]} {
    puts "Warning: Power grid not found or not properly configured"
    puts "PDN Check result: $pdn_check"
}

# Function to safely run power analysis
proc safe_power_report {net_name output_dir} {
    set png_file "$output_dir/${net_name}_heatmap.png"
    set csv_file "$output_dir/${net_name}_heatmap.csv"
    set rpt_file "$output_dir/${net_name}_power.rpt"
    
    puts "Generating power analysis for net: $net_name"
    
    # Try different power analysis commands based on OpenROAD version
    if {[catch {
        # Method 1: Try with analyze_power_grid (newer OpenROAD)
        if {[info commands analyze_power_grid] ne ""} {
            analyze_power_grid -net $net_name
            write_pg_spice -net $net_name -file "$output_dir/${net_name}_power_grid.sp"
        }
        
        # Method 2: Try with report_power command
        if {[info commands report_power] ne ""} {
            # Redirect output to file
            set old_stdout [dup stdout]
            set rpt_fh [open $rpt_file w]
            dup $rpt_fh stdout
            
            report_power -net $net_name
            
            # Restore stdout
            close $rpt_fh
            dup $old_stdout stdout
            close $old_stdout
            
            puts "Power report saved to: $rpt_file"
        }
        
        # Method 3: Generate IR drop analysis if available
        if {[info commands check_power_grid] ne ""} {
            check_power_grid -net $net_name > "$output_dir/${net_name}_check.log" 2>&1
            puts "Power grid check saved to: $output_dir/${net_name}_check.log"
        }
        
    } power_error]} {
        puts "Error in power analysis for $net_name: $power_error"
        
        # Fallback: Create a simple report with available information
        set fallback_file "$output_dir/${net_name}_info.txt"
        set fb_fh [open $fallback_file w]
        puts $fb_fh "Power Analysis Report for net: $net_name"
        puts $fb_fh "Generated on: [clock format [clock seconds]]"
        puts $fb_fh "Design: $::env(DESIGN_NAME)"
        puts $fb_fh ""
        puts $fb_fh "Note: Detailed power analysis failed with error:"
        puts $fb_fh "$power_error"
        puts $fb_fh ""
        puts $fb_fh "This may be due to:"
        puts $fb_fh "1. Missing SAIF file for switching activity"
        puts $fb_fh "2. Incomplete PDN configuration"  
        puts $fb_fh "3. Design not fully placed and routed"
        close $fb_fh
        puts "Fallback report created: $fallback_file"
    }
}

# Generate power analysis for VPWR (power) net
safe_power_report "VPWR" $power_dir

# Generate power analysis for VGND (ground) net  
safe_power_report "VGND" $power_dir

# Try to generate a combined power summary
set summary_file "$power_dir/power_summary.rpt"
if {[catch {
    set sum_fh [open $summary_file w]
    puts $sum_fh "=== Power Analysis Summary ==="
    puts $sum_fh "Design: $::env(DESIGN_NAME)"
    puts $sum_fh "Technology: $::env(PLATFORM)"
    puts $sum_fh "Standard Cell Library: $::env(STD_CELL_LIBRARY)"
    puts $sum_fh "Generated on: [clock format [clock seconds]]"
    puts $sum_fh ""
    
    # Try to get basic design statistics
    if {[catch {
        puts $sum_fh "=== Design Statistics ==="
        if {[info commands report_design_area] ne ""} {
            puts $sum_fh "Design Area Information:"
            report_design_area
        }
        
        if {[info commands report_clock_skew] ne ""} {
            puts $sum_fh "\nClock Information:"
            report_clock_skew
        }
        
    } stats_error]} {
        puts $sum_fh "Basic statistics unavailable: $stats_error"
    }
    
    puts $sum_fh "\n=== Power Grid Configuration ==="
    puts $sum_fh "PDN Vertical Layer: $::env(FP_PDN_VLAYER)"
    puts $sum_fh "PDN Horizontal Layer: $::env(FP_PDN_HLAYER)"
    puts $sum_fh "PDN Vertical Width: $::env(FP_PDN_VWIDTH) um"
    puts $sum_fh "PDN Horizontal Width: $::env(FP_PDN_HWIDTH) um"
    puts $sum_fh "PDN Vertical Pitch: $::env(FP_PDN_VPITCH) um"
    puts $sum_fh "PDN Horizontal Pitch: $::env(FP_PDN_HPITCH) um"
    
    close $sum_fh
    puts "Power summary saved to: $summary_file"
} summary_error]} {
    puts "Error creating power summary: $summary_error"
}

# Generate a simple visualization script for external plotting
set plot_script "$power_dir/generate_plots.py"
if {[catch {
    set plot_fh [open $plot_script w]
    puts $plot_fh "#!/usr/bin/env python3"
    puts $plot_fh "# Power visualization script"
    puts $plot_fh "import matplotlib.pyplot as plt"
    puts $plot_fh "import pandas as pd"
    puts $plot_fh "import numpy as np"
    puts $plot_fh "import os"
    puts $plot_fh ""
    puts $plot_fh "# Check if CSV files exist and plot them"
    puts $plot_fh "csv_files = \['VPWR_heatmap.csv', 'VGND_heatmap.csv'\]"
    puts $plot_fh ""
    puts $plot_fh "for csv_file in csv_files:"
    puts $plot_fh "    if os.path.exists(csv_file):"
    puts $plot_fh "        try:"
    puts $plot_fh "            data = pd.read_csv(csv_file)"
    puts $plot_fh "            plt.figure(figsize=(10, 8))"
    puts $plot_fh "            plt.imshow(data.values, cmap='hot', interpolation='nearest')"
    puts $plot_fh "            plt.colorbar(label='Power Density')"
    puts $plot_fh "            plt.title(f'Power Heatmap - {csv_file}')"
    puts $plot_fh "            plt.savefig(f'{csv_file}_plot.png', dpi=300, bbox_inches='tight')"
    puts $plot_fh "            print(f'Generated plot for {csv_file}')"
    puts $plot_fh "        except Exception as e:"
    puts $plot_fh "            print(f'Error plotting {csv_file}: {e}')"
    puts $plot_fh "    else:"
    puts $plot_fh "        print(f'CSV file {csv_file} not found')"
    close $plot_fh
    
    # Make the script executable
    exec chmod +x $plot_script
    puts "Python plotting script created: $plot_script"
} plot_error]} {
    puts "Error creating plotting script: $plot_error"
}

puts "--- Custom Power Heatmap Generation Complete ---"
puts "Output reports saved in: $power_dir"
puts ""
puts "Generated files:"
puts "- VPWR power analysis reports"
puts "- VGND power analysis reports" 
puts "- power_summary.rpt: Overall power analysis summary"
puts "- generate_plots.py: Python script for visualization"
puts ""
puts "To generate plots (if CSV data available):"
puts "  cd $power_dir && python3 generate_plots.py"