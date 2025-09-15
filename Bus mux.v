//mux for choosing between bus A or bus B
//a 2x1 mux that takes 32 bit inputs

module busMux(
    input [31:0] busA, busB,
    input sel,
    output [31:0] out
);

assign out = sel ? busA : busB;

endmodule