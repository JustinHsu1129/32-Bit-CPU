//Control unit
//6 bit opcode
//table of control signals in notes and resources page

module Control(
    output reg RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignZero,
    output reg [1:0] ALUop,
    input [5:0] Opcode
);

// The rest of the module's content is correct
always @(*) begin

    case (Opcode)

        //the instruction type is based on the opcode, which is a unique identifier provided by the ISA
        //refer to https://www.researchgate.net/figure/Instruction-List-of-the-MIPS-Processor_tbl2_354149702 for more on MIPS opcode

         6'b000000 : begin // R - type
            RegDst = 1'b1;
            ALUSrc = 1'b0;
            MemToReg= 1'b0;
            RegWrite= 1'b1;
            MemRead = 1'b0;
            MemWrite= 1'b0;
            Branch = 1'b0;
            ALUop = 2'b10;
            Jump = 1'b0;
            SignZero= 1'b0;
            end
        6'b100011 : begin // lw - load word
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemToReg= 1'b1;
            RegWrite= 1'b1;
            MemRead = 1'b1;
            MemWrite= 1'b0;
            Branch = 1'b0;
            ALUop = 2'b00;
            Jump = 1'b0;
            SignZero= 1'b0; // sign extend
            end
        6'b101011 : begin // sw - store word
            RegDst = 1'bx;
            ALUSrc = 1'b1;
            MemToReg= 1'bx;
            RegWrite= 1'b0;
            MemRead = 1'b0;
            MemWrite= 1'b1;
            Branch = 1'b0;
            ALUop = 2'b00;
            Jump = 1'b0;
            SignZero= 1'b0;
            end
        6'b000101 : begin // bne - branch if not equal
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemToReg= 1'b0;
            RegWrite= 1'b0;
            MemRead = 1'b0;
            MemWrite= 1'b0;
            Branch = 1'b1;
            ALUop = 2'b01;
            Jump = 1'b0;
            SignZero= 1'b0; // sign extend
            end
        6'b001110 : begin // XORI - XOR immidiate
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            MemToReg= 1'b0;
            RegWrite= 1'b1;
            MemRead = 1'b0;
            MemWrite= 1'b0;
            Branch = 1'b0;
            ALUop = 2'b11;
            Jump = 1'b0;
            SignZero= 1'b1; // zero extend
            end
        6'b000010 : begin // j - Jump
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemToReg= 1'b0;
            RegWrite= 1'b0;
            MemRead = 1'b0;
            MemWrite= 1'b0;
            Branch = 1'b0;
            ALUop = 2'b00;
            Jump = 1'b1;
            SignZero= 1'b0;
            end
        default : begin 
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            MemToReg= 1'b0;
            RegWrite= 1'b0;
            MemRead = 1'b0;
            MemWrite= 1'b0;
            Branch = 1'b0;
            ALUop = 2'b10;
            Jump = 1'b0;
            SignZero= 1'b0;
            end
        
    endcase

end

endmodule