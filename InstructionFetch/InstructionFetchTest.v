`include "InstructionFetch.v"

module test;

reg clk;
reg reset;
wire [16:1] CurInstruction;

InstructionFetch_16Bit insf (clk, CurInstruction, reset);

initial begin
    $monitor($time, ": Current Instruction: %b (%d)", 
        CurInstruction, CurInstruction
    );
end

always #5 
    clk = !clk;

initial begin
    clk = 1'b0;
    reset = 1'b1;
    #10 reset = 1'b0;
    #1000 $finish;
end

endmodule