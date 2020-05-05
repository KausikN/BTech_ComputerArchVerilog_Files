`include "FMul_Pipelined.v"

module test;

reg clk, reset;

reg in_Sign_1;
reg [5:1] in_Exponent_1;
reg [10:1] in_Mantissa_1;
reg in_Sign_2;
reg [5:1] in_Exponent_2;
reg [10:1] in_Mantissa_2;

wire out_Sign;
wire [5:1] out_Exponent;
wire [10:1] out_Mantissa;

wire Exponent_Overflow;
wire Exponent_Underflow;

FMul_HalfPrecision_Pipelined fmul (
    clk, 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    Exponent_Overflow, 
    Exponent_Underflow, 
    reset
    );

initial begin
    $monitor($time, ":\nInput: op1: %b - %b - %b (%b - %d - %d) , op2: %b - %b - %b (%b - %d - %d)\nOutput: out: %b - %b - %b (%b - %d - %d), Exponent_Overflow: %b, Exponent_Underflow: %b", 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, out_Sign, out_Exponent, out_Mantissa, 
    Exponent_Overflow, 
    Exponent_Underflow
    );
end

initial begin
    reset = 1'b0;
    clk = 1'b0;
    in_Sign_1 = 1'b1; in_Exponent_1 = 5'b00100; in_Mantissa_1 = 10'b0000010000;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11010; in_Mantissa_2 = 10'b0101010000;
    #5;
    in_Sign_1 = 1'b1; in_Exponent_1 = 5'b00000; in_Mantissa_1 = 10'b0000000000;
    in_Sign_2 = 1'b1; in_Exponent_2 = 5'b11010; in_Mantissa_2 = 10'b0101010000;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b00000; in_Mantissa_1 = 10'b0000000000;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11010; in_Mantissa_2 = 10'b0101010000;
    #5;
    in_Sign_1 = 1'b1; in_Exponent_1 = 5'b00000; in_Mantissa_1 = 10'b0000000000;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11010; in_Mantissa_2 = 10'b0101010000;
    #5;
    in_Sign_1 = 1'b1; in_Exponent_1 = 5'b00000; in_Mantissa_1 = 10'b0000000000;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11010; in_Mantissa_2 = 10'b0101010000;
    #100 $finish;
end

always #5
    clk = !clk;

endmodule