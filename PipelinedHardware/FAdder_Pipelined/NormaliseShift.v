`include "Encoder11Bit_to_5Bit.v"
`include "NormaliseANDBlock.v"

module NormaliseShift (a, normshift);

input [11:1] a;
output [5:1] normshift;

// Convert binary no to position with first '1'
// Eg. convert 01101 to 00001 as 1 shift
wire [11:1] first1form;
wire [10:1] first1came;
NormaliseANDBlock a_1 (a[11], 1'b0, a[10], first1form[1], first1came[1]);
NormaliseANDBlock a_2 (a[11], first1came[1], a[9], first1form[2], first1came[2]);
NormaliseANDBlock a_3 (a[11], first1came[2], a[8], first1form[3], first1came[3]);
NormaliseANDBlock a_4 (a[11], first1came[3], a[7], first1form[4], first1came[4]);
NormaliseANDBlock a_5 (a[11], first1came[4], a[6], first1form[5], first1came[5]);
NormaliseANDBlock a_6 (a[11], first1came[5], a[5], first1form[6], first1came[6]);
NormaliseANDBlock a_7 (a[11], first1came[6], a[4], first1form[7], first1came[7]);
NormaliseANDBlock a_8 (a[11], first1came[7], a[3], first1form[8], first1came[8]);
NormaliseANDBlock a_9 (a[11], first1came[8], a[2], first1form[9], first1came[9]);
NormaliseANDBlock a_10 (a[11], first1came[9], a[1], first1form[10], first1came[10]);
// assign first1form[1] = !a[11] & a[10];
// assign first1form[2] = !a[11] & !first1form[1] & a[9];
// assign first1form[3] = !a[11] & !first1form[2] & a[8];
// assign first1form[4] = !a[11] & !first1form[3] & a[7];
// assign first1form[5] = !a[11] & !first1form[4] & a[6];
// assign first1form[6] = !a[11] & !first1form[5] & a[5];
// assign first1form[7] = !a[11] & !first1form[6] & a[4];
// assign first1form[8] = !a[11] & !first1form[7] & a[3];
// assign first1form[9] = !a[11] & !first1form[8] & a[2];
// assign first1form[10] = !a[11] & !first1form[9] & a[1];
assign first1form[11] = 1'b0;

// Now encode the no - i.e. 00000000100 - 3rd pos becomes 00011 - 3
Encoder11Bit_to_5Bit enc (first1form, normshift);

endmodule