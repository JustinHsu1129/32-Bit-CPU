//Stall control unit
//Control logic in notes and resources page

module StallControl(
    output reg PC_WriteEn,
    output reg IFID_WriteEn, 
    output reg Stall_flush,
    input EX_MemRead,
    input [4:0] EX_rt,
    input [4:0] ID_rs,
    input [4:0] ID_rt,
    input [5:0] ID_Op
);

// MIPS Opcode definitions
parameter LW_OPCODE = 6'b100011;    // Load Word
parameter XORI_OPCODE = 6'b001110;
// XOR Immediate

always @(*) begin
    // Default: no stall
    PC_WriteEn = 1'b1;
    IFID_WriteEn = 1'b1;
    Stall_flush = 1'b0;
    
    // Check for load-use hazard
    if (EX_MemRead) begin
        // Case 1: EX_rt matches ID_rs (load target = source register)
        if (EX_rt == ID_rs) begin
            PC_WriteEn = 1'b0;
            IFID_WriteEn = 1'b0;
            Stall_flush = 1'b1;
        end
        // Case 2: EX_rt matches ID_rt, but only if ID instruction is NOT LW or XORI
        else if ((EX_rt == ID_rt) && (ID_Op != LW_OPCODE) && (ID_Op != XORI_OPCODE)) begin
            PC_WriteEn = 1'b0;
            IFID_WriteEn = 1'b0;
            Stall_flush = 1'b1;
        end
    end
end

endmodule