//`include "MUX_2_1.v"
module RightBarrelShifter(a, shift, out);

input [16:1]  a;
input [4:1] shift;

output [16:1] out;

wire [16:1] l1, l2, l3;

// Bit 1
MUX_2_1 rm1_1 (a[1], a[2], shift[1], l1[1]);
MUX_2_1 rm1_2 (a[2], a[3], shift[1], l1[2]);
MUX_2_1 rm1_3 (a[3], a[4], shift[1], l1[3]);
MUX_2_1 rm1_4 (a[4], a[5], shift[1], l1[4]);
MUX_2_1 rm1_5 (a[5], a[6], shift[1], l1[5]);
MUX_2_1 rm1_6 (a[6], a[7], shift[1], l1[6]);
MUX_2_1 rm1_7 (a[7], a[8], shift[1], l1[7]);
MUX_2_1 rm1_8 (a[8], a[9], shift[1], l1[8]);
MUX_2_1 rm1_9 (a[9], a[10], shift[1], l1[9]);
MUX_2_1 rm1_10 (a[10], a[11], shift[1], l1[10]);
MUX_2_1 rm1_11 (a[11], a[12], shift[1], l1[11]);
MUX_2_1 rm1_12 (a[12], a[13], shift[1], l1[12]);
MUX_2_1 rm1_13 (a[13], a[14], shift[1], l1[13]);
MUX_2_1 rm1_14 (a[14], a[15], shift[1], l1[14]);
MUX_2_1 rm1_15 (a[15], a[16], shift[1], l1[15]);
MUX_2_1 rm1_16 (a[16], 1'b0, shift[1], l1[16]);

// Bit 2
MUX_2_1 rm2_1 (l1[1], l1[3], shift[2], l2[1]);
MUX_2_1 rm2_2 (l1[2], l1[4], shift[2], l2[2]);
MUX_2_1 rm2_3 (l1[3], l1[5], shift[2], l2[3]);
MUX_2_1 rm2_4 (l1[4], l1[6], shift[2], l2[4]);
MUX_2_1 rm2_5 (l1[5], l1[7], shift[2], l2[5]);
MUX_2_1 rm2_6 (l1[6], l1[8], shift[2], l2[6]);
MUX_2_1 rm2_7 (l1[7], l1[9], shift[2], l2[7]);
MUX_2_1 rm2_8 (l1[8], l1[10], shift[2], l2[8]);
MUX_2_1 rm2_9 (l1[9], l1[11], shift[2], l2[9]);
MUX_2_1 rm2_10 (l1[10], l1[12], shift[2], l2[10]);
MUX_2_1 rm2_11 (l1[11], l1[13], shift[2], l2[11]);
MUX_2_1 rm2_12 (l1[12], l1[14], shift[2], l2[12]);
MUX_2_1 rm2_13 (l1[13], l1[15], shift[2], l2[13]);
MUX_2_1 rm2_14 (l1[14], l1[16], shift[2], l2[14]);
MUX_2_1 rm2_15 (l1[15], 1'b0, shift[2], l2[15]);
MUX_2_1 rm2_16 (l1[16], 1'b0, shift[2], l2[16]);

// Bit 3
MUX_2_1 rm3_1 (l2[1], l2[5], shift[3], l3[1]);
MUX_2_1 rm3_2 (l2[2], l2[6], shift[3], l3[2]);
MUX_2_1 rm3_3 (l2[3], l2[7], shift[3], l3[3]);
MUX_2_1 rm3_4 (l2[4], l2[8], shift[3], l3[4]);
MUX_2_1 rm3_5 (l2[5], l2[9], shift[3], l3[5]);
MUX_2_1 rm3_6 (l2[6], l2[10], shift[3], l3[6]);
MUX_2_1 rm3_7 (l2[7], l2[11], shift[3], l3[7]);
MUX_2_1 rm3_8 (l2[8], l2[12], shift[3], l3[8]);
MUX_2_1 rm3_9 (l2[9], l2[13], shift[3], l3[9]);
MUX_2_1 rm3_10 (l2[10], l2[14], shift[3], l3[10]);
MUX_2_1 rm3_11 (l2[11], l2[15], shift[3], l3[11]);
MUX_2_1 rm3_12 (l2[12], l2[16], shift[3], l3[12]);
MUX_2_1 rm3_13 (l2[13], 1'b0, shift[3], l3[13]);
MUX_2_1 rm3_14 (l2[14], 1'b0, shift[3], l3[14]);
MUX_2_1 rm3_15 (l2[15], 1'b0, shift[3], l3[15]);
MUX_2_1 rm3_16 (l2[16], 1'b0, shift[3], l3[16]);

// Bit 4
MUX_2_1 rm4_1 (l3[1], l3[9], shift[4], out[1]);
MUX_2_1 rm4_2 (l3[2], l3[10], shift[4], out[2]);
MUX_2_1 rm4_3 (l3[3], l3[11], shift[4], out[3]);
MUX_2_1 rm4_4 (l3[4], l3[12], shift[4], out[4]);
MUX_2_1 rm4_5 (l3[5], l3[13], shift[4], out[5]);
MUX_2_1 rm4_6 (l3[6], l3[14], shift[4], out[6]);
MUX_2_1 rm4_7 (l3[7], l3[15], shift[4], out[7]);
MUX_2_1 rm4_8 (l3[8], l3[16], shift[4], out[8]);
MUX_2_1 rm4_9 (l3[9], 1'b0, shift[4], out[9]);
MUX_2_1 rm4_10 (l3[10], 1'b0, shift[4], out[10]);
MUX_2_1 rm4_11 (l3[11], 1'b0, shift[4], out[11]);
MUX_2_1 rm4_12 (l3[12], 1'b0, shift[4], out[12]);
MUX_2_1 rm4_13 (l3[13], 1'b0, shift[4], out[13]);
MUX_2_1 rm4_14 (l3[14], 1'b0, shift[4], out[14]);
MUX_2_1 rm4_15 (l3[15], 1'b0, shift[4], out[15]);
MUX_2_1 rm4_16 (l3[16], 1'b0, shift[4], out[16]);

endmodule