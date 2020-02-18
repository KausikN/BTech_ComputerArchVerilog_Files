`include "PCAdder.v"
`include "DFF.v"

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
DFF PC_1 (clk, nextPC[1], reset, PC[1]);
DFF PC_2 (clk, nextPC[2], reset, PC[2]);
DFF PC_3 (clk, nextPC[3], reset, PC[3]);
DFF PC_4 (clk, nextPC[4], reset, PC[4]);
DFF PC_5 (clk, nextPC[5], reset, PC[5]);
DFF PC_6 (clk, nextPC[6], reset, PC[6]);
DFF PC_7 (clk, nextPC[7], reset, PC[7]);
DFF PC_8 (clk, nextPC[8], reset, PC[8]);
DFF PC_9 (clk, nextPC[9], reset, PC[9]);
DFF PC_10 (clk, nextPC[10], reset, PC[10]);
DFF PC_11 (clk, nextPC[11], reset, PC[11]);
DFF PC_12 (clk, nextPC[12], reset, PC[12]);
DFF PC_13 (clk, nextPC[13], reset, PC[13]);
DFF PC_14 (clk, nextPC[14], reset, PC[14]);
DFF PC_15 (clk, nextPC[15], reset, PC[15]);
DFF PC_16 (clk, nextPC[16], reset, PC[16]);

// Next Program Counter Value
PCAdder addr (PC, 16'b0000000000000001, nextPC);

endmodule