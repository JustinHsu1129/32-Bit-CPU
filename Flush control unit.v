//Flush control
//Solves hazards, flushes instructions when jump instruction is performed
// Flush Block - Behavioral Version
// When flush=1, output all zeros (NOP).
// When flush=0, pass inputs through.

module flush_block(
    input flush, RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, JRControl,
    input [1:0] ALUop,
    output reg ID_RegDst, ID_ALUSrc, ID_MemToReg, ID_RegWrite, ID_MemRead, ID_MemWrite, ID_Branch, ID_JRControl,
    output reg [1:0] ID_ALUop
);

always @(*) begin
    if (flush) begin
        // When flushing, output all zeros (create NOP/bubble)
        ID_RegDst = 1'b0;
        ID_ALUSrc = 1'b0;
        ID_MemToReg = 1'b0;
        ID_RegWrite = 1'b0;
        ID_MemRead = 1'b0;
        ID_MemWrite = 1'b0;
        ID_Branch = 1'b0;
        ID_JRControl = 1'b0;
        ID_ALUop = 2'b00;
    end else begin
        // When not flushing, pass control signals through
        ID_RegDst = RegDst;
        ID_ALUSrc = ALUSrc;
        ID_MemToReg = MemToReg;
        ID_RegWrite = RegWrite;
        ID_MemRead = MemRead;
        ID_MemWrite = MemWrite;
        ID_Branch = Branch;
        ID_JRControl = JRControl;
        ID_ALUop = ALUop;
    end
end

endmodule

// Discard Instructions - Behavioral Version
// Generate flush signals for pipeline stages based on control flow changes
module Discard_Instr(
    output reg ID_flush,
    output reg IF_flush,
    input jump,
    input bne,
    input jr
);

always @(*) begin
    // IF stage flush: occurs on any control flow change
    IF_flush = jump |
    bne | jr;
    
    // ID stage flush: occurs on branches and jumps (but not unconditional jumps)
    ID_flush = bne |
    jr;
end

endmodule