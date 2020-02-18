`include "InstructionFetch.v"

module test;

reg clk;
reg reset;
wire [16:1] PC;
wire [16:1] CurInstruction;

reg [16:1] RegisterFile_1,  RegisterFile_2,  RegisterFile_3,  RegisterFile_4,  
    RegisterFile_5,  RegisterFile_6,  RegisterFile_7,  RegisterFile_8,  
    RegisterFile_9,  RegisterFile_10, RegisterFile_11, RegisterFile_12, 
    RegisterFile_13, RegisterFile_14, RegisterFile_15, RegisterFile_16, 
    RegisterFile_17, RegisterFile_18, RegisterFile_19, RegisterFile_20, 
    RegisterFile_21, RegisterFile_22, RegisterFile_23, RegisterFile_24, 
    RegisterFile_25, RegisterFile_26, RegisterFile_27, RegisterFile_28, 
    RegisterFile_29, RegisterFile_30, RegisterFile_31, RegisterFile_32; 

InstructionFetch_16Bit insf (
    clk, CurInstruction, reset, 
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

initial begin
    $monitor($time, "-> Current Instruction: %b : %b (%d)", 
        PC, 
        CurInstruction, CurInstruction
    );
end

always #5 
    clk = !clk;

initial begin
    // Init Register File
    RegisterFile_1 =  16'b0000000000000000;
    RegisterFile_2 =  16'b0000000000000001;
    RegisterFile_3 =  16'b0000000000000010;
    RegisterFile_4 =  16'b0000000000000011;
    RegisterFile_5 =  16'b0000000000000100;
    RegisterFile_6 =  16'b0000000000000101;
    RegisterFile_7 =  16'b0000000000000110;
    RegisterFile_8 =  16'b0000000000000111;
    RegisterFile_9 =  16'b0000000000001000;
    RegisterFile_10 = 16'b0000000000001001;
    RegisterFile_11 = 16'b0000000000001010;
    RegisterFile_12 = 16'b0000000000001011;
    RegisterFile_13 = 16'b0000000000001100;
    RegisterFile_14 = 16'b0000000000001101;
    RegisterFile_15 = 16'b0000000000001110;
    RegisterFile_16 = 16'b0000000000001111;
    RegisterFile_17 = 16'b0000000000010000;
    RegisterFile_18 = 16'b0000000000010001;
    RegisterFile_19 = 16'b0000000000010010;
    RegisterFile_20 = 16'b0000000000010011;
    RegisterFile_21 = 16'b0000000000010100;
    RegisterFile_22 = 16'b0000000000010101;
    RegisterFile_23 = 16'b0000000000010110;
    RegisterFile_24 = 16'b0000000000010111;
    RegisterFile_25 = 16'b0000000000011000;
    RegisterFile_26 = 16'b0000000000011001;
    RegisterFile_27 = 16'b0000000000011010;
    RegisterFile_28 = 16'b0000000000011011;
    RegisterFile_29 = 16'b0000000000011100;
    RegisterFile_30 = 16'b0000000000011101;
    RegisterFile_31 = 16'b0000000000011110;
    RegisterFile_32 = 16'b0000000000011111;

    clk = 1'b0;
    reset = 1'b1;
    #10 reset = 1'b0;
    #1000 $finish;
end

endmodule