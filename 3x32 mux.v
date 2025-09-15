//3 x 32 mux

module mux_3x32(
    input  [1:0] sel,
    input  [31:0] A, B, C,
    output [31:0] dataOut
);

always @(*) begin
    case (sel)
        2'b00: dataOut = A;
        2'b01: dataOut = B;
        2'b10: dataOut = C;
        2'b11: dataOut = C;
        default: dataOut = A;
        // Default case for safety
    endcase
end

endmodule