`include "FMul.v"

module test;

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

FMul_HalfPrecision fmul (
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    Exponent_Overflow, 
    Exponent_Underflow
    );

initial begin
    $monitor($time, ": op1: %b - %b - %b (%b - %d - %d) , op2: %b - %b - %b (%b - %d - %d) , out: %b - %b - %b (%b - %d - %d), Exponent_Overflow: %b, Exponent_Underflow: %b", 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, out_Sign, out_Exponent, out_Mantissa, 
    Exponent_Overflow, 
    Exponent_Underflow
    );
end

initial begin
    in_Sign_1 = 1'b1; in_Exponent_1 = 5'b10010; in_Mantissa_1 = 10'b0100000000;
    in_Sign_2 = 1'b0; in_Exponent_2 = 5'b10010; in_Mantissa_2 = 10'b0100000000;
end

endmodule