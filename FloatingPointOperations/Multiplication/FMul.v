`include "Bit5Adder.v"
`include "Bit6Adder.v"
`include "Multiplier_16Bit.v"
`include "Bit5MUX.v"
`include "Bit10MUX.v"


module FMul_HalfPrecision(
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    Exponent_Overflow
);

// Special Conditions
output Exponent_Overflow;
wire ZeroCheck;

// Initial
input in_Sign_1;
input [5:1] in_Exponent_1;
input [10:1] in_Mantissa_1;
input in_Sign_2;
input [5:1] in_Exponent_2;
input [10:1] in_Mantissa_2;

output out_Sign;
output [5:1] out_Exponent;
output [10:1] out_Mantissa;

// Check for Zeros - if one op is 0 answer is 0
assign ZeroCheck = !(|in_Mantissa_1 | |in_Exponent_1) | !(|in_Mantissa_2 | |in_Exponent_2);

// Out Sign = xor of 2 input signs
assign out_Sign = ((!in_Sign_1) & in_Sign_2) | (in_Sign_1 & (!in_Sign_2));

// Out Exponent = Sum of 2 input Exponents
wire [6:1] exp_extended, exp_subbed;
wire expcarry;
Bit5Adder expadd (in_Exponent_1, in_Exponent_2, exp_extended[5:1], exp_extended[6]);
// Subtract 15 from result as in result 15 offset is done 2 times
Bit6Adder expsub (exp_extended, 6'b110001, exp_subbed, expcarry);

//assign out_Exponent = exp_subbed[5:1];
Bit5MUX expchooser (exp_subbed[5:1], 5'b00000, ZeroCheck, out_Exponent);

// Out Mantissa = Product of 2 input Mantissas
wire [16:1] in_1_extended, in_2_extended;
wire [36:1] prod_extended;
assign in_1_extended[10:1] = in_Mantissa_1;
assign in_1_extended[16:11] = 6'b000001;
assign in_2_extended[10:1] = in_Mantissa_2; 
assign in_2_extended[16:11] = 6'b000001;
Multiplier_16Bit mul (in_1_extended, in_2_extended, prod_extended);

wire [11:1] prod;

//assign out_Mantissa = prod_extended[20:11];
Bit10MUX mantissachooser (prod_extended[20:11], 10'b0000000000, ZeroCheck, out_Mantissa);

assign Exponent_Overflow = exp_subbed[6];

// always @(*)
//     $display("LOL: %b", prod_extended);

endmodule