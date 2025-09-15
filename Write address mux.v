//Mux for write address
//2 to 1 mux for 5 bit write address input

module writeMux(
    input  [4:0] inA, inB,
    input  sel,
    output [4:0] out
);

assign out = sel ? inB : inA;

endmodule