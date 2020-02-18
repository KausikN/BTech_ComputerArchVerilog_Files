`include "RegisterFile.v"
`include "ProgramCounter.v"

module InstructionFetch_16Bit (
    clk,
    outInstruction, 
    reset
);

input clk;
input reset;

output [16:1] outInstruction;

// Program Counter
wire [16:1] PC;
ProgramCounter pc (clk, PC, reset);

// Register File
RegisterFile_16Bit_32Size rf (PC[5:1], outInstruction);

always @(*) begin
    $display("%b: PC = %b (%d) , outIns = %b (%d)", clk, PC, PC, outInstruction, outInstruction);
end

endmodule