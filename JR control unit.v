//JR control unit
//jump register control unit

module JRControl(
    input [5:0] Function,
    input [1:0] ALUop,
    output reg [7:0] JRControl
);
    
wire [7:0] test;

assign test = {ALUop, Function};

always @(test) begin

    case(test)

        8'b10001000 : JRControl = 1'b1;
        default :   JRControl = 1'b0;

    endcase

end

endmodule