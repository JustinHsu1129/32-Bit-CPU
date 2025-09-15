//Top level
//Instantiate all different parts of CPU here and connect them together
//MIPS 5-Stage Pipeline Processor

module MIPSpipeline(
    input clk,
    input reset,
    output [31:0] current_pc // <-- FIX: Added an output port
);

// Connect internal PC to the new output port
assign current_pc = PC; // <-- FIX: Assigned internal PC to the output

// Pipeline Stage Registers
reg [31:0] PC;
reg [31:0] IFID_PC4, IFID_Instruction;
reg [31:0] IDEX_PC4, IDEX_ReadData1, IDEX_ReadData2, IDEX_Im16_Ext, IDEX_Instruction;
reg [31:0] EXMEM_ALUResult, EXMEM_WriteData;
reg [31:0] MEMWB_ReadData, MEMWB_ALUResult;

// Pipeline Control Registers
reg IFID_flush;
reg IDEX_RegDst, IDEX_ALUSrc, IDEX_MemToReg, IDEX_RegWrite, IDEX_MemRead, IDEX_MemWrite, IDEX_Branch, IDEX_JRControl;
reg [1:0] IDEX_ALUop;
reg EXMEM_MemToReg, EXMEM_RegWrite, EXMEM_MemRead, EXMEM_MemWrite;
reg [4:0] EXMEM_WriteRegister;
reg MEMWB_MemToReg, MEMWB_RegWrite;
reg [4:0] MEMWB_WriteRegister;

// Combinational signals
reg [31:0] PC_next, PC4;
wire [31:0] instruction;
wire [31:0] ReadData1, ReadData2, ReadData1Out, ReadData2Out;
wire [31:0] sign_ext_out, zero_ext_out;
reg  [31:0] Im16_Ext;
wire [31:0] Bus_A_ALU, Bus_B_ALU, Bus_B_forwarded;
wire [31:0] ALU_Result;
wire [31:0] mem_read_data;
reg  [31:0] WB_WriteData;
reg [31:0] PCbne, PCj, PCjr;
// Control signals
wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignZero;
wire [1:0] ALUop;
wire [1:0] ALUControl;
wire [1:0] ForwardA, ForwardB;
wire JRControl;

// Flags and control
wire ZeroFlag, OverflowFlag, NegativeFlag;
reg bneControl;
wire IF_flush, ID_flush, Stall_flush;
reg  flush;
wire PC_WriteEn, IFID_WriteEn;
reg EX_JRControl;

// Intermediate wires for control signals before the ID/EX register
wire ID_RegDst_out, ID_ALUSrc_out, ID_MemToReg_out, ID_RegWrite_out, ID_MemRead_out, ID_MemWrite_out, ID_Branch_out, ID_JRControl_out;
wire [1:0] ID_ALUop_out;


// Instruction fields
wire [5:0] opcode = IFID_Instruction[31:26];
wire [4:0] rs = IFID_Instruction[25:21];
wire [4:0] rt = IFID_Instruction[20:16];
wire [4:0] rd = IFID_Instruction[15:11];
wire [15:0] imm16 = IFID_Instruction[15:0];
wire [5:0] func = IFID_Instruction[5:0];
// EX stage instruction fields
wire [4:0] EX_rs = IDEX_Instruction[25:21];
wire [4:0] EX_rt = IDEX_Instruction[20:16];
wire [4:0] EX_rd = IDEX_Instruction[15:11];
wire [4:0] EX_WriteRegister = IDEX_RegDst ? EX_rd : EX_rt;

//=================================================================
// Component Instantiations
//=================================================================

// Instruction Memory
InstructionMem IM(
    .instruction(instruction),
    .address(PC)
);
// PC Adder (for PC+4)
Add PC_Add4(
    .Sum(PC4),
    .A(PC),
    .B(32'd4)
);
// Control Unit
Control CU(
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemToReg(MemToReg),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUop(ALUop),
    .Jump(Jump),
    .SignZero(SignZero),
    .Opcode(opcode)
);
// JR Control Unit
JRControl JR_CU(
    .JRControl(JRControl),
    .ALUop(ALUop),
    .Function(func)
);
// ** MODULES 'Discard_Instr' and 'flush_block' have been removed and their logic is now below **

// Register File
RegFile RF(
    .clk(clk),
    .reset(reset),
    .reg_write(MEMWB_RegWrite),
    .read_reg1(rs),
    .read_reg2(rt),
    .write_reg(MEMWB_WriteRegister),
    .write_data(WB_WriteData),
    .read_data1(ReadData1),
    .read_data2(ReadData2)
);
// Stall Control Unit
StallControl STALL(
    .PC_WriteEn(PC_WriteEn),
    .IFID_WriteEn(IFID_WriteEn),
    .Stall_flush(Stall_flush),
    .EX_MemRead(IDEX_MemRead),
    .EX_rt(EX_rt),
    .ID_rs(rs),
    .ID_rt(rt),
    .ID_Op(opcode)
);
// Forwarding Unit
ForwardingUnit FU(
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .MEM_RegWrite(EXMEM_RegWrite),
    .WB_RegWrite(MEMWB_RegWrite),
    .MEM_WriteRegister(EXMEM_WriteRegister),
    .WB_WriteRegister(MEMWB_WriteRegister),
    .EX_rs(EX_rs),
    .EX_rt(EX_rt)
);
// WB Forward Unit
WB_forward WB_FU(
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WB_WriteData),
    .rs(rs),
    .rt(rt),
    .WriteRegister(MEMWB_WriteRegister),
    .RegWrite(MEMWB_RegWrite),
    .ReadData1Out(ReadData1Out),
    .ReadData2Out(ReadData2Out)
);
// Sign Extension
signExtend SE(
    .in16(imm16),
    .out32(sign_ext_out)
);
// Zero Extension
zeroExtend ZE(
    .in16(imm16),
    .out32(zero_ext_out)
);
// ALU Control Unit
ALUControl ALU_CU(
    .ALUop(IDEX_ALUop),
    .Function(IDEX_Instruction[5:0]),
    .ALUControl(ALUControl)
);
// 3x32 Mux for Forwarding A
// Note: Mux with name '3x32mux' is not compatible. Using manual logic.
wire [31:0] MuxA_inputA = IDEX_ReadData1;
wire [31:0] MuxA_inputB = EXMEM_ALUResult;
wire [31:0] MuxA_inputC = WB_WriteData;
assign Bus_A_ALU = (ForwardA == 2'b01) ? MuxA_inputC : ((ForwardA == 2'b10) ? MuxA_inputB : MuxA_inputA);
// 3x32 Mux for Forwarding B
// Note: Mux with name '3x32mux' is not compatible. Using manual logic.
wire [31:0] MuxB_inputA = IDEX_ReadData2;
wire [31:0] MuxB_inputB = EXMEM_ALUResult;
wire [31:0] MuxB_inputC = WB_WriteData;
assign Bus_B_forwarded = (ForwardB == 2'b01) ? MuxB_inputC : ((ForwardB == 2'b10) ? MuxB_inputB : MuxB_inputA);
// Bus Mux (for ALU's B input)
busMux ALU_B_Mux(
    .busA(Bus_B_forwarded),
    .busB(IDEX_Im16_Ext),
    .sel(IDEX_ALUSrc),
    .out(Bus_B_ALU)
);
// ALU
ALU MIPS_ALU(
    .busA(Bus_A_ALU),
    .busB(Bus_B_ALU),
    .ALUControl(ALUControl),
    .out(ALU_Result),
    .overflow(OverflowFlag),
    .negative(NegativeFlag),
    .zero(ZeroFlag)
);
// Data Memory
dataMem DM(
    .data(mem_read_data),
    .address(EXMEM_ALUResult),
    .writeData(EXMEM_WriteData),
    .writeEnable(EXMEM_MemWrite),
    .MemRead(EXMEM_MemRead),
    .clk(clk)
);
//=================================================================
// IF STAGE - Instruction Fetch
//=================================================================
always @(*) begin
    // PC + 4 is now a separate module
    // instruction is now an output of InstructionMem module
end

//=================================================================
// ID STAGE - Instruction Decode & Flush Logic
//=================================================================

// Logic to replace Discard_Instr module
// Flush the IF and ID stages if a jump or taken branch occurs
assign ID_flush = Jump || bneControl || JRControl;
assign IF_flush = Jump || bneControl || JRControl;
// Logic to replace flush_block module
// If flush is active, zero out the control signals to create a 'nop'.
// Otherwise, pass them through.
assign ID_RegDst_out   = flush ? 1'b0 : RegDst;
assign ID_ALUSrc_out   = flush ? 1'b0 : ALUSrc;
assign ID_MemToReg_out = flush ? 1'b0 : MemToReg;
assign ID_RegWrite_out = flush ? 1'b0 : RegWrite;
assign ID_MemRead_out  = flush ? 1'b0 : MemRead;
assign ID_MemWrite_out = flush ? 1'b0 : MemWrite;
assign ID_Branch_out   = flush ? 1'b0 : Branch;
assign ID_JRControl_out= flush ? 1'b0 : JRControl;
assign ID_ALUop_out    = flush ? 2'b0 : ALUop;
always @(*) begin
    // Select correct extension for immediate
    Im16_Ext = SignZero ? zero_ext_out : sign_ext_out;
    // Main flush signal combines flushes from jumps, branches, stalls, and prior cycles
    flush = ID_flush | IFID_flush | Stall_flush;
end

//=================================================================
// EX STAGE - Execute
//=================================================================
always @(*) begin
    // Forwarding logic is now a separate module
    // ALU source mux is now a separate module
    // ALU Control is now a separate module
    // ALU is now a separate module
end

//=================================================================
// MEM STAGE - Memory Access
//=================================================================
always @(*) begin
    // Data memory access is now a separate module
end

//=================================================================
// WB STAGE - Write Back
//=================================================================
always @(*) begin
    WB_WriteData = MEMWB_MemToReg ? MEMWB_ReadData : MEMWB_ALUResult;
end

//=================================================================
// Hazard Detection and PC Control
//=================================================================
always @(*) begin
    // Stall detection is now a separate module

    // Branch control
    bneControl = IDEX_Branch && ZeroFlag;
    // The condition for bne is branch & zero flag is true
    PCbne = IDEX_PC4 + (IDEX_Im16_Ext << 2);
    // Jump control
    PCj = {IFID_PC4[31:28], IFID_Instruction[25:0], 2'b00};
    // PC selection
    if (IDEX_JRControl)
        PC_next = Bus_A_ALU;
    else if (Jump)
        PC_next = PCj;
    else if (bneControl)
        PC_next = PCbne;
    else
        PC_next = PC4;
end

//=================================================================
// Sequential Logic - Pipeline Registers
//=================================================================
always @(posedge clk or posedge reset) begin
    if (reset) begin
        PC <= 32'b0;
        IFID_PC4 <= 32'b0;
        IFID_Instruction <= 32'b0;
        IFID_flush <= 1'b0;

        IDEX_PC4 <= 32'b0;
        IDEX_ReadData1 <= 32'b0;
        IDEX_ReadData2 <= 32'b0;
        IDEX_Im16_Ext <= 32'b0;
        IDEX_Instruction <= 32'b0;
        IDEX_RegDst <= 1'b0;
        IDEX_ALUSrc <= 1'b0;
        IDEX_MemToReg <= 1'b0;
        IDEX_RegWrite <= 1'b0;
        IDEX_MemRead <= 1'b0;
        IDEX_MemWrite <= 1'b0;
        IDEX_Branch <= 1'b0;
        IDEX_ALUop <= 2'b0;
        IDEX_JRControl <= 1'b0; 

        EXMEM_ALUResult <= 32'b0;
        EXMEM_WriteData <= 32'b0;
        EXMEM_WriteRegister <= 5'b0;
        EXMEM_MemToReg <= 1'b0;
        EXMEM_RegWrite <= 1'b0;
        EXMEM_MemRead <= 1'b0;
        EXMEM_MemWrite <= 1'b0;
        MEMWB_ReadData <= 32'b0;
        MEMWB_ALUResult <= 32'b0;
        MEMWB_WriteRegister <= 5'b0;
        MEMWB_MemToReg <= 1'b0;
        MEMWB_RegWrite <= 1'b0;
    end else begin
        // IF/ID Pipeline Register
        if (PC_WriteEn)
            PC <= PC_next;
        if (IFID_WriteEn) begin
            IFID_PC4 <= PC4;
            IFID_Instruction <= instruction;
        end
        IFID_flush <= IF_flush;
        // ID/EX Pipeline Register
        IDEX_PC4 <= IFID_PC4;
        IDEX_ReadData1 <= ReadData1Out;
        IDEX_ReadData2 <= ReadData2Out;
        IDEX_Im16_Ext <= Im16_Ext;
        IDEX_Instruction <= IFID_Instruction;
        
        // Latch the (potentially flushed) control signals into the pipeline register
        IDEX_RegDst <= ID_RegDst_out;
        IDEX_ALUSrc <= ID_ALUSrc_out;
        IDEX_MemToReg <= ID_MemToReg_out;
        IDEX_RegWrite <= ID_RegWrite_out;
        IDEX_MemRead <= ID_MemRead_out;
        IDEX_MemWrite <= ID_MemWrite_out;
        IDEX_Branch <= ID_Branch_out;
        IDEX_JRControl <= ID_JRControl_out;
        IDEX_ALUop <= ID_ALUop_out;
        
        // EX/MEM Pipeline Register
        EXMEM_ALUResult <= ALU_Result;
        EXMEM_WriteData <= Bus_B_forwarded;
        EXMEM_WriteRegister <= EX_WriteRegister;
        EXMEM_MemToReg <= IDEX_MemToReg;
        EXMEM_RegWrite <= IDEX_RegWrite;
        EXMEM_MemRead <= IDEX_MemRead;
        EXMEM_MemWrite <= IDEX_MemWrite;
        // MEM/WB Pipeline Register
        MEMWB_ReadData <= mem_read_data;
        MEMWB_ALUResult <= EXMEM_ALUResult;
        MEMWB_WriteRegister <= EXMEM_WriteRegister;
        MEMWB_MemToReg <= EXMEM_MemToReg;
        MEMWB_RegWrite <= EXMEM_RegWrite;

    end
end

// Get EX_JRControl for use in combinational logic
always @(*) begin
    EX_JRControl = IDEX_JRControl;
end

endmodule