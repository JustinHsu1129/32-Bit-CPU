module BinaryToBCDConverter(
    input wire [7:0] bin,    // 8-bit binary input
    output reg [11:0] bcd    // 12-bit BCD output (hundreds, tens, ones)
);

integer i;

always @(bin) begin
    bcd = 0; // Initialize BCD output to zero

    // Perform the double-dabble algorithm
    for (i = 0; i < 8; i = i + 1) begin
        // Adjust BCD digits if they are greater than 4
        if (bcd[3:0] > 4)
            bcd[3:0] = bcd[3:0] + 3; // Adjust ones place
        
        if (bcd[7:4] > 4)
            bcd[7:4] = bcd[7:4] + 3; // Adjust tens place
        
        if (bcd[11:8] > 4)
            bcd[11:8] = bcd[11:8] + 3; // Adjust hundreds place

        // Shift left and insert next binary bit
        bcd = {bcd[10:0], bin[7 - i]};
    end
end

endmodule
