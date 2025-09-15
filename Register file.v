//32 Bit register file
//there are 32 available registers, with reg0 storing 0 permanently
//need two input and outputs to support simultaneous read write
//only 32 registers so [4:0]
//writes happen on clock edge, but reads can happen immediately (they can also happen on clock edge)
//use smaller one bc openlane is baby mode

module RegFile(
    input clk,
    input reset,
    input reg_write,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    // 32 registers, each 32 bits
    reg [31:0] regs [31:0];
    
    integer i;

    // synchronous reset: clear all registers
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end
        else if (reg_write && write_reg != 0) begin
            // write new data (except register 0)
            regs[write_reg] <= write_data;
        end
    end

    // read ports (combinational)
    //if read_reg is 0, set read_data to 0, else set read_data to what is in the register
    assign read_data1 = (read_reg1 == 0) ? 32'b0 : regs[read_reg1];
    assign read_data2 = (read_reg2 == 0) ? 32'b0 : regs[read_reg2];

endmodule

