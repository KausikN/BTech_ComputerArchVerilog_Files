`include "ExpSubtractor.v"
`include "BarrelShifter5Bit.v"
`include "NormaliseShift.v"
//`include "Bit11Adder.v"
//`include "Bit5Adder.v"
`include "Bit10MUX.v"
//`include "Bit5MUX.v"
`include "Complement2s_11Bit.v"
//`include "Complement2s_5Bit.v"

`include "DFF_11Bit.v"
`include "DFF_5Bit.v"
`include "DFF.v"


module FAdder_HalfPrecision_Pipelined(
    clk, 
    add, 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2_BeforeSignAdjust, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    SC_Output_OverFlow, SC_Exponent_UnderFlow, 
    reset
);

input clk, reset;

// Special Conditions
wire SC_Operand_Infinity;   // For checking if any one of the input operands is Infinity
wire SC_Operand_Zero;   // For checking if any one of the input operands is 0
wire SC_Mantissa_Zero;  // For checking if Output no is 0.0
output SC_Output_OverFlow; // For checking if Output Exponent Overflows
output SC_Exponent_UnderFlow; // For checking if Output no is denormalised - i.e. exponent of output underflows after renormalisation

// Initial
input add;  // If add = 1, do addition, else do subtraction
input in_Sign_1;
input [5:1] in_Exponent_1;
input [10:1] in_Mantissa_1;
input in_Sign_2_BeforeSignAdjust;   // Sign before accounting for addition or subtraction
input [5:1] in_Exponent_2;
input [10:1] in_Mantissa_2;

output out_Sign;
output [5:1] out_Exponent;
output [10:1] out_Mantissa;

wire [5:1] in_Exponent_1_1, in_Exponent_2_1;
wire in_Sign_1_1, in_Sign_2_1;

wire in_Sign_2;
assign in_Sign_2 = ((!add) & (!in_Sign_2_BeforeSignAdjust)) | (add & in_Sign_2_BeforeSignAdjust);

// Get the Smaller Operand and Normalize it to the larger operand using ExpSubtractor module
wire smallerOperand, smallerOperand_0;
wire [5:1] Exponent_Diff, Exponent_Diff_0;
wire [5:1] Max_Exponent;

ExpSubtractor expsub (in_Exponent_1, in_Exponent_2, Exponent_Diff_0, smallerOperand_0); // if smallerOperand = 1, in_Exponent_1 is smaller Operand

// Layer 1
DFF_5Bit ff_expdiff(clk, Exponent_Diff_0, Exponent_Diff, reset);
DFF_5Bit ff_exp_1(clk, in_Exponent_1, in_Exponent_1_1, reset);
DFF_5Bit ff_exp_2(clk, in_Exponent_2, in_Exponent_2_1, reset);
DFF ff_so(clk, smallerOperand_0, smallerOperand, reset);
DFF ff_insign1(clk, in_Sign_1, in_Sign_1_1, reset);
DFF ff_insign2(clk, in_Sign_2, in_Sign_2_1, reset);

wire largerOperand;
assign largerOperand = !smallerOperand;
// Based on smallerOperand decide which operand is larger or smaller
wire largerOperand_Sign, largerOperand_Sign_1;
wire [5:1] largerOperand_Exponent, largerOperand_Exponent_1, largerOperand_Exponent_2;
wire [11:1] largerOperand_Mantissa, largerOperand_Mantissa_0, largerOperand_Mantissa_1;

wire smallerOperand_Sign_Normalised;
wire [5:1] smallerOperand_Exponent;
wire [11:1] smallerOperand_Mantissa;
wire [11:1] smallerOperand_Mantissa_Normalised, smallerOperand_Mantissa_Normalised_0;

assign largerOperand_Sign = ((!smallerOperand) & in_Sign_1_1) | ((smallerOperand) & in_Sign_2_1);

Bit5MUX LargerOperandExponentChooser (in_Exponent_1_1, in_Exponent_2_1, smallerOperand, largerOperand_Exponent);

Bit10MUX LargerOperandMantissaChooser (in_Mantissa_1, in_Mantissa_2, smallerOperand, largerOperand_Mantissa[10:1]);
assign largerOperand_Mantissa_0[11] = 1'b1;   // For Implicit 1

assign smallerOperand_Sign_Normalised = ((smallerOperand) & in_Sign_1_1) | ((!smallerOperand) & in_Sign_2_1);

Bit5MUX SmallerOperandExponentChooser (in_Exponent_1_1, in_Exponent_2_1, largerOperand, smallerOperand_Exponent);

Bit10MUX SmallerOperandMantissaChooser (in_Mantissa_1, in_Mantissa_2, largerOperand, smallerOperand_Mantissa[10:1]);
assign smallerOperand_Mantissa[11] = 1'b1;   // For Implicit 1

// Now Check if Smaller Operand is 0 - mantissa (10 bits) and exponent all zeros
assign SC_Operand_Zero = !(|smallerOperand_Exponent | |smallerOperand_Mantissa[10:1]);
// Now Check if Larger Operand is all 1s - mantissa (10 bits) all 0s and exponent all ones
assign SC_Operand_Infinity = (&smallerOperand_Exponent & !(|smallerOperand_Mantissa[10:1]));

// Match the exponent of smaller operand with larger operand - i.e. right shift it by exp_diff times
BarrelShifterRight SmallerExponentMatch (smallerOperand_Mantissa, Exponent_Diff, smallerOperand_Mantissa_Normalised_0);

// Check if larger and smaller operands have different signs - if so, subtract, else add
wire diff_signs_0 = ((!largerOperand_Sign) & smallerOperand_Sign_Normalised) | (largerOperand_Sign & (!smallerOperand_Sign_Normalised));
wire diff_signs;

// Layer 2
wire SC_Operand_Zero_1, SC_Operand_Zero_2;
wire SC_Operand_Infinity_1, SC_Operand_Infinity_2;
wire SC_Mantissa_Zero_1, SC_Mantissa_Zero_2;
DFF_11Bit ff_somn(clk, smallerOperand_Mantissa_Normalised_0, smallerOperand_Mantissa_Normalised, reset);
DFF_11Bit ff_lo(clk, largerOperand_Mantissa_0, largerOperand_Mantissa, reset);
DFF_5Bit ff_le(clk, largerOperand_Exponent, largerOperand_Exponent_1, reset);
DFF ff_ds(clk, diff_signs_0, diff_signs, reset);
DFF ff_los(clk, largerOperand_Sign, largerOperand_Sign_1, reset);
DFF ff_opzero(clk, SC_Operand_Zero, SC_Operand_Zero_1, reset);
DFF ff_opinf(clk, SC_Operand_Infinity, SC_Operand_Infinity_1, reset);
DFF ff_opman(clk, SC_Mantissa_Zero, SC_Mantissa_Zero_1, reset);


wire [11:1] smallerOperand_Mantissa_Normalised_2scomp;
Complement2s_11Bit SmallerMantissaComplementer (smallerOperand_Mantissa_Normalised, smallerOperand_Mantissa_Normalised_2scomp);

wire [11:1] smallerOperand_Mantissa_Normalised_Signed;
Bit10MUX SmallerOperandAddOrSubtractChooser (smallerOperand_Mantissa_Normalised[10:1], smallerOperand_Mantissa_Normalised_2scomp[10:1], diff_signs, smallerOperand_Mantissa_Normalised_Signed[10:1]);
assign smallerOperand_Mantissa_Normalised_Signed[11] = ((!diff_signs) & smallerOperand_Mantissa_Normalised[11]) | ((diff_signs) & smallerOperand_Mantissa_Normalised_2scomp[11]);

// Now Add the larger operand mantissa with exponent matched smaller operand mantissa
wire [12:1] addedValue_extended;
wire [11:1] addedValue, addedValue_1;
wire DontIgnoreCarry;

Bit11Adder MantissaAdder (largerOperand_Mantissa, smallerOperand_Mantissa_Normalised_Signed, addedValue_extended[11:1], addedValue_extended[12]);

assign DontIgnoreCarry = addedValue_extended[12] & (!diff_signs); // Ignore the carry if subraction - i.e. diffsigns = 1

// If carry is 0, addedValue is addedValue_extended[11:1] else if carry is 1, addedValue is addedValue_extended[12:2] and increase largerExponent by 1
wire [5:1] largerOperand_Exponent_CarryAdjusted, largerOperand_Exponent_CarryAdjusted_0;
wire CarryAdd_Exponent_Overflow;
wire [5:1] carrytoadd;

Bit5MUX CarryChooser (5'b00000, 5'b00001, DontIgnoreCarry, carrytoadd);
Bit5Adder CarryAdder (largerOperand_Exponent_1, carrytoadd, largerOperand_Exponent_CarryAdjusted_0, CarryAdd_Exponent_Overflow);

Bit10MUX MantissaOverflowChooser (addedValue_extended[10:1], addedValue_extended[11:2], DontIgnoreCarry, addedValue[10:1]);
assign addedValue[11] = ((!DontIgnoreCarry) & addedValue_extended[11]) | (DontIgnoreCarry & DontIgnoreCarry);

assign SC_Mantissa_Zero_1 = !(|addedValue);   // If all zeros |addedValue returns 0, even if one 1 present returns 1

// Layer 3
DFF_11Bit ff_lo_1(clk, largerOperand_Mantissa, largerOperand_Mantissa_1, reset);
DFF_5Bit lo_ca(clk, largerOperand_Exponent_CarryAdjusted_0, largerOperand_Exponent_CarryAdjusted, reset);
DFF_5Bit ff_le_2(clk, largerOperand_Exponent_1, largerOperand_Exponent_2, reset);
DFF_11Bit av(clk, addedValue, addedValue_1, reset);
DFF ff_opzero_1(clk, SC_Operand_Zero_1, SC_Operand_Zero_2, reset);
DFF ff_opinf_1(clk, SC_Operand_Infinity_1, SC_Operand_Infinity_2, reset);
DFF ff_opman_1(clk, SC_Mantissa_Zero_1, SC_Mantissa_Zero_2, reset);

// normalise the output - i.e. if output is 0010 make it to 1000 by shifting left and decreasing exponent of larger operand
wire [5:1] norm_shift;
wire [11:1] addedValue_Normalised;
NormaliseShift ns (addedValue_1, norm_shift);
BarrelShifterLeft RenormaliseOutputMantissa (addedValue_1, norm_shift, addedValue_Normalised);
wire [5:1] norm_shift_2scomp;
wire [5:1] finalexp_norm;
wire Normalise_Exponent_Overflow;

ExpSubtractor RenormaliseExp (largerOperand_Exponent_CarryAdjusted, norm_shift, finalexp_norm, SC_Exponent_UnderFlow);

assign out_Sign = largerOperand_Sign_1;

// Check Special Conditions and Assign Output Exponent
wire [5:1] out_Exponent_Intermediate_1, out_Exponent_Intermediate_2;
// If smaller operand was 0 directly assign output as the larger operand
Bit5MUX outExponentChooser1 (finalexp_norm, largerOperand_Exponent_2, SC_Operand_Zero_2, out_Exponent_Intermediate_1);
// If larger operand was Infinity directly assign output as all ones
Bit5MUX outExponentChooser2 (out_Exponent_Intermediate_1, 5'b11111, SC_Operand_Infinity_2, out_Exponent_Intermediate_2);
// If mantissa is all 0, then exponents should be set to 0
Bit5MUX outExponentChooser3 (out_Exponent_Intermediate_2, 5'b00000, SC_Mantissa_Zero_2, out_Exponent);

// Check Special Conditions and Assign Output Mantissa
wire [10:1] out_Mantissa_Intermediate_1, out_Mantissa_Intermediate_2;
// If smaller operand was 0 directly assign output as the larger operand
Bit10MUX outMantissachooser1 (addedValue_Normalised[10:1], largerOperand_Mantissa_1[10:1], SC_Operand_Zero_2, out_Mantissa_Intermediate_1);
// If larger operand was Infinity directly assign output as all ones
Bit10MUX outMantissachooser2 (out_Mantissa_Intermediate_1, 10'b0000000000, SC_Operand_Infinity_2, out_Mantissa_Intermediate_2);
assign out_Mantissa = out_Mantissa_Intermediate_2;

// Check if Output Overflows
assign SC_Output_OverFlow = &out_Exponent;

// always @(*) begin
//     $display("INP: %b = %b - %b", Exponent_Diff, in_Exponent_1, in_Exponent_2);
//     $display("LOL: %b = %b - %b", SC_Exponent_UnderFlow, largerOperand_Exponent_CarryAdjusted, norm_shift);
// end
endmodule


// DENORM NOS LEFT OUT