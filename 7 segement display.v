module SevenSegmentDisplayDecoder(
    input wire [3:0] bcd,      // 4-bit Binary-Coded Decimal (BCD) input
    output wire [6:0] segments // 7-segment display output
);

// Assigns the correct segment pattern for each digit (0-9)
assign segments =
    //              ABCDEFG
    (bcd == 4'd0) ? 7'b1111110 : // 0
    (bcd == 4'd1) ? 7'b0110000 : // 1
    (bcd == 4'd2) ? 7'b1101101 : // 2
    (bcd == 4'd3) ? 7'b1111001 : // 3
    (bcd == 4'd4) ? 7'b0110011 : // 4
    (bcd == 4'd5) ? 7'b1011011 : // 5
    (bcd == 4'd6) ? 7'b1011111 : // 6
    (bcd == 4'd7) ? 7'b1110000 : // 7
    (bcd == 4'd8) ? 7'b1111111 : // 8
    (bcd == 4'd9) ? 7'b1110011 : // 9
    7'b0000000; // Default case (all segments off)

endmodule
