//`include "Bit5Adder.v"
`include "Complement2s_5Bit.v"
`include "Bit5MUX.v"

module ExpSubtractor (in_Exponent_1, in_Exponent_2, Exponent_Diff, smallerOperand);

input [5:1] in_Exponent_1;
input [5:1] in_Exponent_2;

output [5:1] Exponent_Diff;
output smallerOperand;

// Check if operand 1/2 is 0
wire in_Exponent_1_Zero;
assign in_Exponent_1_Zero = !(|in_Exponent_1);
wire in_Exponent_2_Zero;
assign in_Exponent_2_Zero = !(|in_Exponent_2);

// Subtract the 2 exponents
wire [5:1] tscomp;
wire [5:1] diff;
wire carry;
Complement2s_5Bit comp2s (in_Exponent_2, tscomp);
Bit5Adder addr (in_Exponent_1, tscomp, diff, carry);
// If carry is 1 - diff is +ve, else it is -ve
// i.e. if carry is 1, smallerOperand is in_exponent_2 - 0
// Else if caary is 0, smallerOperand is in_exponent_1 - 1
wire smallerOperand_ZeroChecked;
assign smallerOperand_ZeroChecked = ((!in_Exponent_1_Zero) & (!in_Exponent_2_Zero) & !carry) | ((!in_Exponent_1_Zero) &  in_Exponent_2_Zero & 0) | 
                        (in_Exponent_1_Zero & (!in_Exponent_2_Zero) & 1) | (in_Exponent_1_Zero & in_Exponent_2_Zero & 0);
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
Bit5MUX mux (reverse2scomp, diff, !smallerOperand_ZeroChecked, Exponent_Diff);

// Assign smallerOperand
assign smallerOperand = smallerOperand_ZeroChecked;

endmodule