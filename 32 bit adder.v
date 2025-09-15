//32 bit wide adder

module Add(
    output [31:0] Sum,
    input [31:0] A, B
);

assign Sum = A + B;

endmodule