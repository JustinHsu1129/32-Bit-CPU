//Forwarding unit
//solves data hazard in pipeline
//correct data at output of ALU is forwarded to input of ALU when data hazards are detected
//Data hazards are detected when the source register (EX_rs or EX_rt) of the current instruction 
//is the same as the destination register (MEM_WriteRegister or EX_WriteRegister) of the previous instruction

module ForwardingUnit(
    output reg [1:0] ForwardA, ForwardB,
    input MEM_RegWrite,
    input WB_RegWrite,
    input [4:0] MEM_WriteRegister,
    input [4:0] WB_WriteRegister,
    input [4:0] EX_rs,
    input [4:0] EX_rt
);

always @(*) begin
    // Default values
    ForwardA = 2'b00;
    ForwardB = 2'b00;
    // ForwardA logic
    if (MEM_RegWrite && (MEM_WriteRegister != 5'b00000) && (MEM_WriteRegister == EX_rs)) begin
        ForwardA = 2'b10;
    end
    else if (WB_RegWrite && (WB_WriteRegister != 5'b00000) && (WB_WriteRegister == EX_rs)) begin
        ForwardA = 2'b01;
    end
    
    // ForwardB logic
    if (MEM_RegWrite && (MEM_WriteRegister != 5'b00000) && (MEM_WriteRegister == EX_rt)) begin
        ForwardB = 2'b10;
    end
    else if (WB_RegWrite && (WB_WriteRegister != 5'b00000) && (WB_WriteRegister == EX_rt)) begin
        ForwardB = 2'b01;
    end
end

endmodule