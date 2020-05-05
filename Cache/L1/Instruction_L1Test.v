`include "Instruction_L1.v"

module test;

reg [16:1] WriteAddress_Full;
reg [16:1] WriteValue;
reg [16:1] ReadAddress_Full;
wire [16:1] ReadValue;
wire WriteHit, ReadHit;
reg mode;
reg clk;

Instruction_L1 inscache (WriteAddress_Full, WriteValue, 
    ReadAddress_Full, ReadValue, 
    WriteHit, ReadHit, 
    clk, mode);

initial begin
    $monitor($time, ": mode: %b, WriteAdd = %b (%d), WriteVal = %b (%d) : WHit -  %b \n\t\t\t\t\tReadAdd = %b (%d), ReadVal = %b (%d) : RHit -  %b", 
    mode,
    WriteAddress_Full, WriteAddress_Full,
    WriteValue, WriteValue,
    WriteHit,  
    ReadAddress_Full, ReadAddress_Full, 
    ReadValue, ReadValue, 
    ReadHit);
end

initial begin
    clk = 1'b0;
    mode = 1'b1; // Write
    WriteAddress_Full = 16'd0;
    WriteValue = 16'd23;
    ReadAddress_Full = 16'd0;

    #100 mode = 1'b0; ReadAddress_Full = 16'd0;
    #100 mode = 1'b1; WriteAddress_Full = 16'd1; WriteValue = 16'd42;
    #100 mode = 1'b0; ReadAddress_Full = 16'd1;
    #100 mode = 1'b1; WriteAddress_Full = 16'd8; WriteValue = 16'd62;
    #100 mode = 1'b0; ReadAddress_Full = 16'd8;
    #1000 $finish;
end

always #100 clk = !clk; 

endmodule