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
    add, 
    in_Sign_1, in_Exponent_1, in_Mantissa_1, 
    in_Sign_2_BeforeSignAdjust, in_Exponent_2, in_Mantissa_2, 
    out_Sign, out_Exponent, out_Mantissa, 
    SC_Output_OverFlow, SC_Exponent_UnderFlow
);

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

wire in_Sign_2;
assign in_Sign_2 = ((!add) & (!in_Sign_2_BeforeSignAdjust)) | (add & in_Sign_2_BeforeSignAdjust);

// Get the Smaller Operand and Normalize it to the larger operand using ExpSubtractor module
wire smallerOperand;
wire [5:1] Exponent_Diff;
wire [5:1] Max_Exponent;

ExpSubtractor expsub (in_Exponent_1, in_Exponent_2, Exponent_Diff, smallerOperand); // if smallerOperand = 1, in_Exponent_1 is smaller Operand

wire largerOperand;
assign largerOperand = !smallerOperand;
// Based on smallerOperand decide which operand is larger or smaller
wire largerOperand_Sign;
wire [5:1] largerOperand_Exponent;
wire [11:1] largerOperand_Mantissa;

wire smallerOperand_Sign_Normalised;
wire [5:1] smallerOperand_Exponent;
wire [11:1] smallerOperand_Mantissa;
wire [11:1] smallerOperand_Mantissa_Normalised;

assign largerOperand_Sign = ((!smallerOperand) & in_Sign_1) | ((smallerOperand) & in_Sign_2);

Bit5MUX LargerOperandExponentChooser (in_Exponent_1, in_Exponent_2, smallerOperand, largerOperand_Exponent);

Bit10MUX LargerOperandMantissaChooser (in_Mantissa_1, in_Mantissa_2, smallerOperand, largerOperand_Mantissa[10:1]);
assign largerOperand_Mantissa[11] = 1'b1;   // For Implicit 1

assign smallerOperand_Sign_Normalised = ((smallerOperand) & in_Sign_1) | ((!smallerOperand) & in_Sign_2);

Bit5MUX SmallerOperandExponentChooser (in_Exponent_1, in_Exponent_2, largerOperand, smallerOperand_Exponent);

Bit10MUX SmallerOperandMantissaChooser (in_Mantissa_1, in_Mantissa_2, largerOperand, smallerOperand_Mantissa[10:1]);
assign smallerOperand_Mantissa[11] = 1'b1;   // For Implicit 1

// Now Check if Smaller Operand is 0 - mantissa (10 bits) and exponent all zeros
assign SC_Operand_Zero = !(|smallerOperand_Exponent | |smallerOperand_Mantissa[10:1]);
// Now Check if Larger Operand is all 1s - mantissa (10 bits) all 0s and exponent all ones
assign SC_Operand_Infinity = (&smallerOperand_Exponent & !(|smallerOperand_Mantissa[10:1]));

// Match the exponent of smaller operand with larger operand - i.e. right shift it by exp_diff times
BarrelShifterRight SmallerExponentMatch (smallerOperand_Mantissa, Exponent_Diff, smallerOperand_Mantissa_Normalised);

// Check if larger and smaller operands have different signs - if so, subtract, else add
wire diff_signs = ((!largerOperand_Sign) & smallerOperand_Sign_Normalised) | (largerOperand_Sign & (!smallerOperand_Sign_Normalised));

wire [11:1] smallerOperand_Mantissa_Normalised_2scomp;
Complement2s_11Bit SmallerMantissaComplementer (smallerOperand_Mantissa_Normalised, smallerOperand_Mantissa_Normalised_2scomp);

wire [11:1] smallerOperand_Mantissa_Normalised_Signed;
Bit10MUX SmallerOperandAddOrSubtractChooser (smallerOperand_Mantissa_Normalised[10:1], smallerOperand_Mantissa_Normalised_2scomp[10:1], diff_signs, smallerOperand_Mantissa_Normalised_Signed[10:1]);
assign smallerOperand_Mantissa_Normalised_Signed[11] = ((!diff_signs) & smallerOperand_Mantissa_Normalised[11]) | ((diff_signs) & smallerOperand_Mantissa_Normalised_2scomp[11]);

// Now Add the larger operand mantissa with exponent matched smaller operand mantissa
wire [12:1] addedValue_extended;
wire [11:1] addedValue;
wire DontIgnoreCarry;

Bit11Adder MantissaAdder (largerOperand_Mantissa, smallerOperand_Mantissa_Normalised_Signed, addedValue_extended[11:1], addedValue_extended[12]);

assign DontIgnoreCarry = addedValue_extended[12] & (!diff_signs); // Ignore the carry if subraction - i.e. diffsigns = 1

// If carry is 0, addedValue is addedValue_extended[11:1] else if carry is 1, addedValue is addedValue_extended[12:2] and increase largerExponent by 1
wire [5:1] largerOperand_Exponent_CarryAdjusted;
wire CarryAdd_Exponent_Overflow;
wire [5:1] carrytoadd;

Bit5MUX CarryChooser (5'b00000, 5'b00001, DontIgnoreCarry, carrytoadd);
Bit5Adder CarryAdder (largerOperand_Exponent, carrytoadd, largerOperand_Exponent_CarryAdjusted, CarryAdd_Exponent_Overflow);

Bit10MUX MantissaOverflowChooser (addedValue_extended[10:1], addedValue_extended[11:2], DontIgnoreCarry, addedValue[10:1]);
assign addedValue[11] = ((!DontIgnoreCarry) & addedValue_extended[11]) | (DontIgnoreCarry & DontIgnoreCarry);

assign SC_Mantissa_Zero = !(|addedValue);   // If all zeros |addedValue returns 0, even if one 1 present returns 1

// normalise the output - i.e. if output is 0010 make it to 1000 by shifting left and decreasing exponent of larger operand
wire [5:1] norm_shift;
wire [11:1] addedValue_Normalised;
NormaliseShift ns (addedValue, norm_shift);
BarrelShifterLeft RenormaliseOutputMantissa (addedValue, norm_shift, addedValue_Normalised);
wire [5:1] norm_shift_2scomp;
wire [5:1] finalexp_norm;
wire Normalise_Exponent_Overflow;

ExpSubtractor RenormaliseExp (largerOperand_Exponent_CarryAdjusted, norm_shift, finalexp_norm, SC_Exponent_UnderFlow);

assign out_Sign = largerOperand_Sign;

// Check Special Conditions and Assign Output Exponent
wire [5:1] out_Exponent_Intermediate_1, out_Exponent_Intermediate_2;
// If smaller operand was 0 directly assign output as the larger operand
Bit5MUX outExponentChooser1 (finalexp_norm, largerOperand_Exponent, SC_Operand_Zero, out_Exponent_Intermediate_1);
// If larger operand was Infinity directly assign output as all ones
Bit5MUX outExponentChooser2 (out_Exponent_Intermediate_1, 5'b11111, SC_Operand_Infinity, out_Exponent_Intermediate_2);
// If mantissa is all 0, then exponents should be set to 0
Bit5MUX outExponentChooser3 (out_Exponent_Intermediate_2, 5'b00000, SC_Mantissa_Zero, out_Exponent);

// Check Special Conditions and Assign Output Mantissa
wire [10:1] out_Mantissa_Intermediate_1, out_Mantissa_Intermediate_2;
// If smaller operand was 0 directly assign output as the larger operand
Bit10MUX outMantissachooser1 (addedValue_Normalised[10:1], largerOperand_Mantissa[10:1], SC_Operand_Zero, out_Mantissa_Intermediate_1);
// If larger operand was Infinity directly assign output as all ones
Bit10MUX outMantissachooser2 (out_Mantissa_Intermediate_1, 10'b0000000000, SC_Operand_Infinity, out_Mantissa_Intermediate_2);
assign out_Mantissa = out_Mantissa_Intermediate_2;

// Check if Output Overflows
assign SC_Output_OverFlow = &out_Exponent;

// always @(*) begin
//     $display("INP: %b = %b - %b", Exponent_Diff, in_Exponent_1, in_Exponent_2);
//     $display("LOL: %b = %b - %b", SC_Exponent_UnderFlow, largerOperand_Exponent_CarryAdjusted, norm_shift);
// end
endmodule


// DENORM NOS LEFT OUT