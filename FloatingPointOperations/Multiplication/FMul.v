`include "Bit5Adder.v"
`include "Bit6Adder.v"
`include "Multiplier_16Bit.v"
`include "Bit5MUX.v"
`include "Bit10MUX.v"


module FMul_HalfPrecision(
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    SC_Exponent_Overflow, 
    SC_Exponent_Underflow
);

// Special Conditions
output SC_Exponent_Overflow;
output SC_Exponent_Underflow;
wire SC_Operand_Infinity;
wire SC_Operand_Zero;

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
assign SC_Operand_Zero = !(|in_Mantissa_1 | |in_Exponent_1) | !(|in_Mantissa_2 | |in_Exponent_2);

// Check for Infinity - If one op is Infinity answer is Infinity
assign SC_Operand_Infinity = (&in_Mantissa_1 & &in_Exponent_1) | (&in_Mantissa_2 & &in_Exponent_2);

// Out Sign = xor of 2 input signs
assign out_Sign = ((!in_Sign_1) & in_Sign_2) | (in_Sign_1 & (!in_Sign_2));

// Out Exponent = Sum of 2 input Exponents
wire [6:1] exp_extended, exp_subbed;
wire expcarry;
Bit5Adder expadd (in_Exponent_1, in_Exponent_2, exp_extended[5:1], exp_extended[6]);
// Subtract 15 from result as in result 15 offset is done 2 times
Bit6Adder expsub (exp_extended, 6'b110001, exp_subbed, expcarry);

// Check for overflow by exp_extended - 45  = If +ve then overflow
wire [7:1] overflowcheck;
Bit6Adder checkoverflow (exp_extended, 6'b010011, overflowcheck[6:1], overflowcheck[7]);
assign SC_Exponent_Overflow = (overflowcheck[7] & (|overflowcheck[6:1])) | exp_plus1[6]; // 1 000000 is accepted as it is 45 - 45

// Check Special Conditions and Assign Output Exponent
wire [5:1] out_Exponent_Intermediate_1;
wire [6:1] exp_plus1;
Bit5Adder expplus1 (exp_subbed[5:1], 5'b00001, exp_plus1[5:1], exp_plus1[6]);
wire [5:1] exp_mux_in = (prod_extended[22]) ? exp_plus1 : exp_subbed[5:1];
// Check if one of the operands is 0 then output exponent is also 0
Bit5MUX expchooser1 (exp_mux_in, 5'b00000, SC_Operand_Zero, out_Exponent_Intermediate_1);
// Check if one of operands is Infinity then output exponent is all ones
Bit5MUX expchooser2 (out_Exponent_Intermediate_1, 5'b11111, SC_Operand_Infinity, out_Exponent);

// Out Mantissa = Product of 2 input Mantissas
wire [16:1] in_1_extended, in_2_extended;
wire [36:1] prod_extended;
assign in_1_extended[10:1] = in_Mantissa_1;
assign in_1_extended[16:11] = 6'b000001;
assign in_2_extended[10:1] = in_Mantissa_2; 
assign in_2_extended[16:11] = 6'b000001;
Multiplier_16Bit mul (in_1_extended, in_2_extended, prod_extended);

// If prod_extended[22] = 1, shift by once right and increase exp by 1
wire [10:1] prod_mux_in = (prod_extended[22]) ? prod_extended[21:12] : prod_extended[20:11];

// Check Special Conditions and Assign Output Mantissa
wire [10:1] out_Mantissa_Intermediate_1;
// Check if one of the operands is 0 then output mantissa is also 0
Bit10MUX mantissachooser1 (prod_mux_in, 10'b0000000000, SC_Operand_Zero, out_Mantissa_Intermediate_1);
// Check if one of operands is Infinity then output mantissa is all ones
Bit10MUX mantissachooser2 (out_Mantissa_Intermediate_1, 10'b1111111111, SC_Operand_Infinity, out_Mantissa);

assign SC_Exponent_Underflow = exp_subbed[6] & (!SC_Operand_Zero & !SC_Operand_Infinity & !SC_Exponent_Overflow);

// always @(*)
//     $display("LOL: %b", prod_extended);

endmodule