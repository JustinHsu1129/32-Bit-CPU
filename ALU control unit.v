//ALU control unit
//the control values are found in notes and references page

module ALUControl(
    input  [5:0] Function,
    input  [1:0] ALUop,
    output reg [1:0] ALUControl
);

wire [7:0] ALUControlIn;

assign ALUControlIn = {ALUop, Function};

always @(ALUControlIn) begin

    case (ALUControlIn) 

        8'b11xxxxxx: ALUControl=2'b01;
        8'b00xxxxxx: ALUControl=2'b00;
        8'b01xxxxxx: ALUControl=2'b10;
        8'b10100000: ALUControl=2'b00;
        8'b10100010: ALUControl=2'b10;
        8'b10101010: ALUControl=2'b11;
        default: ALUControl=2'b00;

    endcase
end

endmodule