//`include "Bit5Adder.v"
`include "Complement2s_5Bit.v"
`include "Bit5MUX.v"

module ExpSubtractor (in_Exponent_1, in_Exponent_2, Exponent_Diff, smallerOperand);

input [5:1] in_Exponent_1;
input [5:1] in_Exponent_2;

output [5:1] Exponent_Diff;
output smallerOperand;

// Subtract the 2 exponents
wire [5:1] tscomp;
wire [5:1] diff;
wire carry;
Complement2s_5Bit comp2s (in_Exponent_2, tscomp);
Bit5Adder addr (in_Exponent_1, tscomp, diff, carry);
// If carry is 1 - diff is +ve, else it is -ve
// i.e. if carry is 1, smallerOperand is in_exponent_1 - 0
// Else if caary is 0, smallerOperand is in_exponent_2 - 1
assign smallerOperand = !carry;
// If diff is +ve return, else if diff is -ve, take ulta 2scomplement and return
wire [5:1] reverse2scomp;
// subtract 1 and take 1s complement
wire [5:1] onescomp;
wire c;
Bit5Adder addr_to1s (diff, 5'b11111, onescomp, c);
assign reverse2scomp[1] = !onescomp[1];
assign reverse2scomp[2] = !onescomp[2];
assign reverse2scomp[3] = !onescomp[3];
assign reverse2scomp[4] = !onescomp[4];
assign reverse2scomp[5] = !onescomp[5];

// Return correct diff value based on sign of it
Bit5MUX mux (reverse2scomp, diff, carry, Exponent_Diff);
// assign Exponent_Diff[1] = ((!carry) & reverse2scomp[1]) | ((carry) & diff[1]);
// assign Exponent_Diff[2] = ((!carry) & reverse2scomp[2]) | ((carry) & diff[2]);
// assign Exponent_Diff[3] = ((!carry) & reverse2scomp[3]) | ((carry) & diff[3]);
// assign Exponent_Diff[4] = ((!carry) & reverse2scomp[4]) | ((carry) & diff[4]);
// assign Exponent_Diff[5] = ((!carry) & reverse2scomp[5]) | ((carry) & diff[5]);

endmodule