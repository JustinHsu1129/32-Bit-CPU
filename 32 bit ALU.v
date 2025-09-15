//32 bit ALU
//bus A and bus B are the two inputs (usually from data register)

/*

ALU Control:
00 = Arithmetic add
01 = Arithmetic subtract
10 = bitwise XOR
11 = set less than (SLT)

*/

module ALU(
    input [31:0] busA, busB,
    input [1:0] ALUControl,
    output reg [31:0] out,
    output overflow,
    output negative,
    output zero
);

  always @(*) begin
    case (ALUControl)
      2'b00: out = busA + busB;
      // Add
      2'b01: out = busA - busB;
      // Subtract
      2'b10: out = busA ^ busB;
      // Bitwise XOR
      2'b11: out = (busA < busB) ? 32'b1 : 32'b0;
      // Set less than
      default: out = 32'b0;
    endcase
  end

  // Flags
  assign zero = (out == 32'b0);
  // 1 if result is zero
  assign negative = out[31];
  // MSB indicates sign in 2's complement
  assign overflow = ((ALUControl == 2'b00) && (busA[31] == busB[31]) && (out[31] != busA[31])) ||
  ((ALUControl == 2'b01) && (busA[31] != busB[31]) && (out[31] != busA[31]));

endmodule