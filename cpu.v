module SimpleCPU(
    input wire clk,
    input wire reset,
    output reg[7:0] out
    );

// Define Opcodes
parameter NOP = 4'b0000; // No operation
parameter LOAD_ACC = 4'b0001; // Load accumulator
parameter ADD_ACC = 4'b0010; // Add to accumulator
parameter SUB_ACC = 4'b0011; // Subtract from accumulator
parameter STORE_ACC = 4'b0100; // Store accumulator
parameter LOAD_IMM = 4'b0101; // Load immediate value
parameter JUMP = 4'b0110; // Jump to address
parameter JUMP_CARRY = 4'b0111; // Jump if carry
parameter JUMP_ZERO = 4'b1000; // Jump if zero
parameter OUTPUT = 4'b1110; // Output value
parameter HALT = 4'b1111; // Halt execution

// Halt signal
reg halt;
always @(negedge clk) begin
    if (instr[7:4] == HALT && step == 2)
        halt <= 1;
    else
        halt <= 0;
end

// Memory Address Register Control
reg mem_addr_enable;
always @(negedge clk) begin
    if (step == 0 || (instr[7:4] == LOAD_ACC && step == 2) || 
        (instr[7:4] == ADD_ACC && step == 2) || 
        (instr[7:4] == SUB_ACC && step == 2) || 
        (instr[7:4] == STORE_ACC && step == 2))
        mem_addr_enable <= 1;
    else
        mem_addr_enable <= 0;
end

// RAM Control Signals
reg ram_write, ram_read;
always @(negedge clk) begin
    ram_write <= (instr[7:4] == STORE_ACC && step == 3);
    ram_read <= (step == 1 || (instr[7:4] == LOAD_ACC && step == 3) || 
                 (instr[7:4] == ADD_ACC && step == 3) || 
                 (instr[7:4] == SUB_ACC && step == 3));
end

// Instruction Register Control Signals
reg instr_fetch, instr_load;
always @(negedge clk) begin
    instr_load <= (step == 1);
    instr_fetch <= (instr[7:4] != NOP && step == 2);
end

// Accumulator Register Control Signals
reg acc_load, acc_output;
always @(negedge clk) begin
    acc_load <= (instr[7:4] == LOAD_IMM && step == 2) || 
                (instr[7:4] == LOAD_ACC && step == 3) || 
                (instr[7:4] == ADD_ACC && step == 4) || 
                (instr[7:4] == SUB_ACC && step == 4);
    acc_output <= (instr[7:4] == STORE_ACC && step == 3) || 
                  (instr[7:4] == OUTPUT && step == 2);
end

// ALU Control Signals
reg alu_output, alu_subtract;
always @(negedge clk) begin
    alu_output <= (instr[7:4] == ADD_ACC && step == 4) || (instr[7:4] == SUB_ACC && step == 4);
    alu_subtract <= (instr[7:4] == SUB_ACC && step == 4);
end

// B Register Control
reg b_register_load;
always @(negedge clk) begin
    b_register_load <= (instr[7:4] == ADD_ACC && step == 3) || (instr[7:4] == SUB_ACC && step == 3);
end

// Output Register Control
reg output_load;
always @(negedge clk) begin
    output_load <= (instr[7:4] == OUTPUT && step == 2);
end

// Program Counter Control
reg pc_enable, pc_output, pc_jump;
always @(negedge clk) begin
    pc_enable <= (step == 1);
    pc_output <= (step == 0);
    pc_jump <= (instr[7:4] == JUMP && step == 2) || 
               (instr[7:4] == JUMP_CARRY && step == 2 && flags[1]) || 
               (instr[7:4] == JUMP_ZERO && step == 2 && flags[0]);
end

// Flags Register
reg flags_load;
always @(negedge clk) begin
    flags_load <= (instr[7:4] == ADD_ACC && step == 4) || (instr[7:4] == SUB_ACC && step == 4);
end

// Define Bus
wire [7:0] bus;
assign bus = pc_output ? program_counter : 
             ram_read ? memory[addr_register] : 
             instr_fetch ? instr[3:0] : 
             acc_output ? accumulator : 
             alu_output ? alu_result : 8'b0;

// Program Counter
reg [3:0] program_counter;
always @(posedge clk or posedge reset) begin
    if (reset)
        program_counter <= 0;
    else if (pc_enable)
        program_counter <= program_counter + 1;
    else if (pc_jump)
        program_counter <= bus[3:0];
end

// Step Counter
reg [2:0] step;
always @(posedge clk or posedge reset) begin
    if (reset)
        step <= 0;
    else if (step == 5 || pc_jump)
        step <= 0;
    else if (halt || step == 6)
        step <= 6;
    else
        step <= step + 1;
end

// Memory Address Register
reg [3:0] addr_register;
always @(posedge clk or posedge reset) begin
    if (reset)
        addr_register <= 0;
    else if (mem_addr_enable)
        addr_register <= bus[3:0];
end

// Memory
reg [7:0] memory[16];
always @(posedge clk) begin
    if (ram_write)
        memory[addr_register] <= bus;
end

// Instruction Register
reg [7:0] instr;
always @(posedge clk or posedge reset) begin
    if (reset)
        instr <= 0;
    else if (instr_load)
        instr <= bus;
end

// ALU and Registers
reg [7:0] accumulator, b_register;
wire [7:0] alu_b_input;
wire [8:0] alu_result;
wire zero_flag, carry_flag;

always @(posedge clk or posedge reset) begin
    if (reset)
        accumulator <= 0;
    else if (acc_load)
        accumulator <= bus;
end

always @(posedge clk or posedge reset) begin
    if (reset)
        b_register <= 0;
    else if (b_register_load)
        b_register <= bus;
end

assign zero_flag = (alu_result[7:0] == 0);
assign alu_b_input = alu_subtract ? ~b_register + 1 : b_register;
assign carry_flag = alu_result[8];
assign alu_result = accumulator + alu_b_input;

// Flags Register
reg [1:0] flags;
always @(posedge clk or posedge reset) begin
    if (reset)
        flags <= 0;
    else if (flags_load)
        flags <= {carry_flag, zero_flag};
end

// Output Register
always @(posedge clk or posedge reset) begin
    if (reset)
        out <= 0;
    else if (output_load)
        out <= bus;
end

endmodule
