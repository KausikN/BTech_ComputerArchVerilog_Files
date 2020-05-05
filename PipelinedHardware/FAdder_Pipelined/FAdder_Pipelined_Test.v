`include "FAdder_Pipelined.v"

module test;

reg clk, reset;
reg add;

reg in_Sign_1;
reg [5:1] in_Exponent_1;
reg [10:1] in_Mantissa_1;
reg in_Sign_2;
reg [5:1] in_Exponent_2;
reg [10:1] in_Mantissa_2;

wire out_Sign;
wire [5:1] out_Exponent;
wire [10:1] out_Mantissa;

wire Exponent_UnderFlow;
wire Output_OverFlow;

FAdder_HalfPrecision_Pipelined faddr (
    clk, 
    add, 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    SC_Output_OverFlow, SC_Exponent_UnderFlow, 
    reset
    );

initial begin
    $monitor($time, ":\nInput: op1: %b - %b - %b (%b - %d - %d) , op2: %b - %b - %b (%b - %d - %d) \nOutput: out: %b - %b - %b (%b - %d - %d), Overflow: %b, Underflow: %b", 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, out_Sign, out_Exponent, out_Mantissa, 
    SC_Output_OverFlow, SC_Exponent_UnderFlow
    );
end

initial begin
    reset = 1'b0;
    clk = 1'b0;
    add = 1'b0;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b1; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b1; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #5;
    in_Sign_1 = 1'b0; in_Exponent_1 = 5'b11100; in_Mantissa_1 = 10'b1110111101;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b11100; in_Mantissa_2 = 10'b1110111101;
    #100 $finish;
end

always #5
    clk = !clk;

endmodule