//Sign extension and shift left 2
//it's 2 separate modules lmao

module signExtend(
    input  [15:0] in16,
    output [31:0] out32
);

assign out32 = {{16{in16[15]}}, in16};

endmodule

module shiftLeft(
    input  [31:0] in,
    output [31:0] out
);

assign out = {{in[29:0]}, 2'b0};

endmodule