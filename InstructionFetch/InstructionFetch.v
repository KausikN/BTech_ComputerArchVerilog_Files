`include "RegisterFile.v"
`include "ProgramCounter.v"

module InstructionFetch_16Bit (
    clk,
    outInstruction, 
    reset, 
    RegisterFile_1,  RegisterFile_2,  RegisterFile_3,  RegisterFile_4,  
    RegisterFile_5,  RegisterFile_6,  RegisterFile_7,  RegisterFile_8,  
    RegisterFile_9,  RegisterFile_10, RegisterFile_11, RegisterFile_12, 
    RegisterFile_13, RegisterFile_14, RegisterFile_15, RegisterFile_16, 
    RegisterFile_17, RegisterFile_18, RegisterFile_19, RegisterFile_20, 
    RegisterFile_21, RegisterFile_22, RegisterFile_23, RegisterFile_24, 
    RegisterFile_25, RegisterFile_26, RegisterFile_27, RegisterFile_28, 
    RegisterFile_29, RegisterFile_30, RegisterFile_31, RegisterFile_32, 
    PC
);

input clk;
input reset;

input [16:1] RegisterFile_1,  RegisterFile_2,  RegisterFile_3,  RegisterFile_4,  
    RegisterFile_5,  RegisterFile_6,  RegisterFile_7,  RegisterFile_8,  
    RegisterFile_9,  RegisterFile_10, RegisterFile_11, RegisterFile_12, 
    RegisterFile_13, RegisterFile_14, RegisterFile_15, RegisterFile_16, 
    RegisterFile_17, RegisterFile_18, RegisterFile_19, RegisterFile_20, 
    RegisterFile_21, RegisterFile_22, RegisterFile_23, RegisterFile_24, 
    RegisterFile_25, RegisterFile_26, RegisterFile_27, RegisterFile_28, 
    RegisterFile_29, RegisterFile_30, RegisterFile_31, RegisterFile_32;

output [16:1] outInstruction;

// Program Counter
output [16:1] PC;
ProgramCounter pc (clk, PC, reset);

// Register File
RegisterFile_16Bit_1024Size rf (PC[10:1], outInstruction, 
    RegisterFile_1,  RegisterFile_2,  RegisterFile_3,  RegisterFile_4,  
    RegisterFile_5,  RegisterFile_6,  RegisterFile_7,  RegisterFile_8,  
    RegisterFile_9,  RegisterFile_10, RegisterFile_11, RegisterFile_12, 
    RegisterFile_13, RegisterFile_14, RegisterFile_15, RegisterFile_16, 
    RegisterFile_17, RegisterFile_18, RegisterFile_19, RegisterFile_20, 
    RegisterFile_21, RegisterFile_22, RegisterFile_23, RegisterFile_24, 
    RegisterFile_25, RegisterFile_26, RegisterFile_27, RegisterFile_28, 
    RegisterFile_29, RegisterFile_30, RegisterFile_31, RegisterFile_32);

// always @(*) begin
//     $display("%b: PC = %b (%d) , outIns = %b (%d)", clk, PC, PC, outInstruction, outInstruction);
// end

endmodule