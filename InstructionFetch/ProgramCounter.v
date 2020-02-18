`include "PCAdder.v"
`include "DFF_16Bit.v"

module ProgramCounter (
    clk, 
    PC,
    reset
);

input clk;
input reset;

output [16:1] PC;
wire [16:1] nextPC;

// Program Counter Register
DFF_16Bit pc (clk, nextPC, PC, reset);

// Next Program Counter Value
PCAdder addr (PC, 16'b0000000000000001, nextPC);

endmodule