//32 bit wide Instruction Memory
//Depth of 4096 words

// `define SYNTHESIS when running synthesis tools like Yosys/OpenLane
// To define in Yosys, use the command: read_verilog -D SYNTHESIS your_file.v

module InstructionMem(
    output [31:0] instruction,
    input [31:0] address
 );

// Memory depth is 64 words. Adjust if your program is larger.
reg [31:0] instMem [63:0];

/*

//`ifdef SYNTHESIS
    // --- FOR SYNTHESIS ---
    // Direct initialization of your program. The synthesis tool will infer a ROM.
    initial begin
        // It's good practice to initialize the whole memory to a default value,
        // such as a 'nop' instruction, to avoid undefined states (latches).
        integer i;
        for (i = 0; i < 64; i = i + 1) begin
            instMem[i] = 32'h00000013; // RISC-V NOP
        end

        // Your specific instructions (converted from binary to hex)
        instMem[0]  = 32'h38100003;
        instMem[1]  = 32'h38110004;
        instMem[2]  = 32'h08000005;
        instMem[3]  = 32'h38100001;
        instMem[4]  = 32'h38110001;
        instMem[5]  = 32'h02309022;
        instMem[6]  = 32'h1611FFFC;
        instMem[7]  = 32'h02119820;
        instMem[8]  = 32'hAE530010;
        instMem[9]  = 32'h8E540010;
        instMem[10] = 32'h0214A82A;
        instMem[11] = 32'h8E530010;
        instMem[12] = 32'h3A530001;
        instMem[13] = 32'h3AB50001;
        instMem[14] = 32'h02A00008;
    end
//`else
    // --- FOR SIMULATION ---
    // $readmemb is faster and more convenient for simulation.
    // Ensure "Instructions.txt" contains your binary code.
/*    initial begin
        $readmemb("Instructions.txt", instMem);
    end
`endif */


// The instruction fetch logic remains the same.
// It performs word-alignment by ignoring the two least significant bits.
assign instruction = instMem[address >> 2];

endmodule

/*

//use a smaller memory bc openlane can't support smth so large LMAO

 module InstructionMem(
    output [31:0] instruction,
    input [31:0] address
 );

reg [31:0] instMem [4095:0]; //32 bits wide, 4096 deep, 32 * 4096 = ~131Kb

//load instructions from instruction file into the instruction register


//comment out this part for synthesis bc you obv can't synthesize the instructions file

initial begin

    $readmemb("Instructions.txt", instMem);

end


//fetch instructions and perform word alignment
//when address changes, we want to assign get the instruction stored at the address
//this functions as the program counter, right shift 2 to divide by 4
//dividing by 4 aligns to the word
assign instruction = instMem[address >> 2];
endmodule

*/