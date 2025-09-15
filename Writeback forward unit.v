// WB Forward - Behavioral Version
// Handles Write-Back stage hazards by forwarding write data when needed

module WB_forward(
    input  [31:0] ReadData1, ReadData2, WriteData,
    input  [4:0] rs, rt, WriteRegister,
    input  RegWrite,
    output reg [31:0] ReadData1Out, ReadData2Out
);

always @(*) begin
    // Default: pass through original read data
    ReadData1Out = ReadData1;
    ReadData2Out = ReadData2;
    
    // Forward write data if there's a WB hazard
    // Condition: RegWrite=1 AND WriteRegister!=0 AND WriteRegister matches source register
    
    // Check for rs forwarding (ReadData1)
    if (RegWrite && (WriteRegister != 5'b00000) && (WriteRegister == rs)) begin
        ReadData1Out = WriteData;
    end
    
    // Check for rt forwarding (ReadData2)  
    if (RegWrite && (WriteRegister != 5'b00000) && (WriteRegister == rt)) begin
        ReadData2Out = WriteData;
    end
end

endmodule

// Compare Address - Behavioral Version
// Simple 5-bit address comparator
module CompareAddress(
    output reg equal,
    input [4:0] Addr1,
    input [4:0] Addr2
);

always @(*) begin
    equal = (Addr1 == Addr2);
end

endmodule