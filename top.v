`include "cpu.v"
`include "7seg.v"
`include "bin_to_bcd.v"

module TopModule(
    input CLK,            // System clock
    input RESET,          // Reset button
    output SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G, // 7-segment display segments
    output DIGIT_1, DIGIT_2, DIGIT_3, DIGIT_4  // 7-segment display digit control
);

// Internal signal declarations
reg [7:0] cpu_output; // Output from the CPU module
reg [23:0] clock_divider; // Clock divider for generating lower frequency clocks

// Clock division for CPU operation
always @(posedge CLK)
    clock_divider <= clock_divider + 1;

// Instantiate CPU module
CPU cpu_instance(
    .clk(clock_divider[15]),  // Slower clock for CPU operation
    .reset(RESET),            // Reset signal
    .out(cpu_output)          // CPU output data
);

// BCD conversion and 7-segment display handling
wire [11:0] bcd_output; // BCD representation of CPU output
bin_to_bcd bcd_converter(
    .binary(cpu_output),
    .bcd(bcd_output)
);

// 7-segment display outputs
reg [6:0] seg_units, seg_tens, seg_hundreds;

// Instantiate 7-segment decoders
SevenSegmentDecoder seg_decoder_units(
    .bcd(bcd_output[3:0]),
    .segments(seg_units)
);

SevenSegmentDecoder seg_decoder_tens(
    .bcd(bcd_output[7:4]),
    .segments(seg_tens)
);

SevenSegmentDecoder seg_decoder_hundreds(
    .bcd(bcd_output[11:8]),
    .segments(seg_hundreds)
);

// Multiplexing 7-segment display
reg [3:0] active_digit = 4'b1110;

always @(posedge clock_divider[10]) begin
    case (active_digit)
        4'b1110: begin
            active_digit <= 4'b1011;
            {SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G} <= seg_hundreds;
        end
        4'b1011: begin
            active_digit <= 4'b1101;
            {SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G} <= seg_tens;
        end
        4'b1101: begin
            active_digit <= 4'b1110;
            {SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G} <= seg_units;
        end
        default: begin
            active_digit <= 4'b1111;
        end
    endcase
end

// Assign digit control signals
assign {DIGIT_4, DIGIT_3, DIGIT_2, DIGIT_1} = active_digit;

endmodule
