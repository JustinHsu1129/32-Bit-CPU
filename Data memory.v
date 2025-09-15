// 32 bit data memory
// write on rising clock edge


//use smth smaller bc openlane is googoo baby mode

module dataMem(
    output [31:0] data,
    input  [31:0] address,
    input  [31:0] writeData,
    input         writeEnable,
    input         MemRead,
    input         clk
);

// The rest of the module's content is correct
// 32-bit word memory, depth = 16384
  reg [31:0] dataMem [16383:0];
// Read: asynchronous (combinational)
  assign data = (MemRead) ? dataMem[address[15:2]] : 32'b0;
// Write: synchronous (on rising edge of clock)
  always @(posedge clk) begin
    if (writeEnable) begin
      dataMem[address[15:2]] <= writeData;
    end
  end

endmodule
