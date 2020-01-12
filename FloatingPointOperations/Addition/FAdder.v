`include "ExpSubtractor.v"
`include "BarrelShifter5Bit.v"
`include "NormaliseShift.v"
//`include "Bit11Adder.v"
//`include "Bit5Adder.v"
`include "Bit10MUX.v"
//`include "Bit5MUX.v"
`include "Complement2s_11Bit.v"
//`include "Complement2s_5Bit.v"


module FAdder_HalfPrecision(
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa
);

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

// Get the Smaller Operand and Normalize it to the larger operand using ExpSubtractor module
wire smallerOperand;
wire [5:1] Exponent_Diff;
wire [5:1] Max_Exponent;

ExpSubtractor expsub (in_Exponent_1, in_Exponent_2, Exponent_Diff, smallerOperand);

// Based on smallerOperand decide which operand is larger or smaller
wire largerOperand_Sign;
wire [5:1] largerOperand_Exponent;
wire [11:1] largerOperand_Mantissa;

wire smallerOperand_Sign_Normalised;
wire [11:1] smallerOperand_Mantissa;
wire [11:1] smallerOperand_Mantissa_Normalised;

assign largerOperand_Sign = ((!smallerOperand) & in_Sign_1) | ((smallerOperand) & in_Sign_2);

Bit5MUX m5_1 (in_Exponent_1, in_Exponent_2, smallerOperand, largerOperand_Exponent);
// assign largerOperand_Exponent[1] = ((!smallerOperand) & in_Exponent_1[1]) | ((smallerOperand) & in_Exponent_2[1])
// assign largerOperand_Exponent[2] = ((!smallerOperand) & in_Exponent_1[2]) | ((smallerOperand) & in_Exponent_2[2])
// assign largerOperand_Exponent[3] = ((!smallerOperand) & in_Exponent_1[3]) | ((smallerOperand) & in_Exponent_2[3])
// assign largerOperand_Exponent[4] = ((!smallerOperand) & in_Exponent_1[4]) | ((smallerOperand) & in_Exponent_2[4])
// assign largerOperand_Exponent[5] = ((!smallerOperand) & in_Exponent_1[5]) | ((smallerOperand) & in_Exponent_2[5])

Bit10MUX m10_1 (in_Mantissa_1, in_Mantissa_2, smallerOperand, largerOperand_Mantissa[10:1]);
// assign largerOperand_Mantissa[1] = ((!smallerOperand) & in_Mantissa_1[1]) | ((smallerOperand) & in_Mantissa_2[1])
// assign largerOperand_Mantissa[2] = ((!smallerOperand) & in_Mantissa_1[2]) | ((smallerOperand) & in_Mantissa_2[2])
// assign largerOperand_Mantissa[3] = ((!smallerOperand) & in_Mantissa_1[3]) | ((smallerOperand) & in_Mantissa_2[3])
// assign largerOperand_Mantissa[4] = ((!smallerOperand) & in_Mantissa_1[4]) | ((smallerOperand) & in_Mantissa_2[4])
// assign largerOperand_Mantissa[5] = ((!smallerOperand) & in_Mantissa_1[5]) | ((smallerOperand) & in_Mantissa_2[5])
// assign largerOperand_Mantissa[6] = ((!smallerOperand) & in_Mantissa_1[6]) | ((smallerOperand) & in_Mantissa_2[6])
// assign largerOperand_Mantissa[7] = ((!smallerOperand) & in_Mantissa_1[7]) | ((smallerOperand) & in_Mantissa_2[7])
// assign largerOperand_Mantissa[8] = ((!smallerOperand) & in_Mantissa_1[8]) | ((smallerOperand) & in_Mantissa_2[8])
// assign largerOperand_Mantissa[9] = ((!smallerOperand) & in_Mantissa_1[9]) | ((smallerOperand) & in_Mantissa_2[9])
// assign largerOperand_Mantissa[10] = ((!smallerOperand) & in_Mantissa_1[10]) | ((smallerOperand) & in_Mantissa_2[10])
assign largerOperand_Mantissa[11] = 1'b1;

assign smallerOperand_Sign_Normalised = ((smallerOperand) & in_Sign_1) | ((!smallerOperand) & in_Sign_2);

wire largerOperand;
assign largerOperand = !smallerOperand;
Bit10MUX m10_2 (in_Mantissa_1, in_Mantissa_2, largerOperand, smallerOperand_Mantissa[10:1]);
// assign smallerOperand_Mantissa[1] = ((smallerOperand) & in_Mantissa_1[1]) | ((!smallerOperand) & in_Mantissa_2[1])
// assign smallerOperand_Mantissa[2] = ((smallerOperand) & in_Mantissa_1[2]) | ((!smallerOperand) & in_Mantissa_2[2])
// assign smallerOperand_Mantissa[3] = ((smallerOperand) & in_Mantissa_1[3]) | ((!smallerOperand) & in_Mantissa_2[3])
// assign smallerOperand_Mantissa[4] = ((smallerOperand) & in_Mantissa_1[4]) | ((!smallerOperand) & in_Mantissa_2[4])
// assign smallerOperand_Mantissa[5] = ((smallerOperand) & in_Mantissa_1[5]) | ((!smallerOperand) & in_Mantissa_2[5])
// assign smallerOperand_Mantissa[6] = ((smallerOperand) & in_Mantissa_1[6]) | ((!smallerOperand) & in_Mantissa_2[6])
// assign smallerOperand_Mantissa[7] = ((smallerOperand) & in_Mantissa_1[7]) | ((!smallerOperand) & in_Mantissa_2[7])
// assign smallerOperand_Mantissa[8] = ((smallerOperand) & in_Mantissa_1[8]) | ((!smallerOperand) & in_Mantissa_2[8])
// assign smallerOperand_Mantissa[9] = ((smallerOperand) & in_Mantissa_1[9]) | ((!smallerOperand) & in_Mantissa_2[9])
// assign smallerOperand_Mantissa[10] = ((smallerOperand) & in_Mantissa_1[10]) | ((!smallerOperand) & in_Mantissa_2[10])
assign smallerOperand_Mantissa[11] = 1'b1;

// Normalise the smaller mantissa - i.e. right shift it by exp_diff times
BarrelShifterRight shifter_1 (smallerOperand_Mantissa, Exponent_Diff, smallerOperand_Mantissa_Normalised);

// Apply Sign to operands
wire diff_signs = ((!largerOperand_Sign) & smallerOperand_Sign_Normalised) | (largerOperand_Sign & (!smallerOperand_Sign_Normalised));

wire [11:1] smallerOperand_Mantissa_Normalised_2scomp;
Complement2s_11Bit tc_11_2 (smallerOperand_Mantissa_Normalised, smallerOperand_Mantissa_Normalised_2scomp);

wire [11:1] smallerOperand_Mantissa_Normalised_Signed;
Bit10MUX m10_s_1 (smallerOperand_Mantissa_Normalised[10:1], smallerOperand_Mantissa_Normalised_2scomp[10:1], diff_signs, smallerOperand_Mantissa_Normalised_Signed[10:1]);
assign smallerOperand_Mantissa_Normalised_Signed[11] = ((!diff_signs) & smallerOperand_Mantissa_Normalised[11]) | ((diff_signs) & smallerOperand_Mantissa_Normalised_2scomp[11]);
// Now Add the larger operand mantissa with normalised smaller operand mantissa
wire [11:1] addedValue;
wire carry;
Bit11Adder addr (largerOperand_Mantissa, smallerOperand_Mantissa_Normalised_Signed, addedValue, carry);

// Ignore the carry and normalise the output - i.e. if output is 0010 make it to 1000 by shifting left and decreasing exponent of larger operand
wire [5:1] norm_shift;
wire [11:1] addedValue_Normalised;
NormaliseShift ns (addedValue, norm_shift);
BarrelShifterLeft shifter_2 (addedValue, norm_shift, addedValue_Normalised);
wire [5:1] norm_shift_2scomp;
wire [5:1] finalexp_norm;
wire carry_2;
Complement2s_5Bit tc (norm_shift, norm_shift_2scomp);
Bit5Adder addr_2 (largerOperand_Exponent, norm_shift_2scomp, finalexp_norm, carry_2);

assign out_Sign = largerOperand_Sign;
assign out_Exponent = finalexp_norm;
assign out_Mantissa = addedValue_Normalised[10:1];

endmodule