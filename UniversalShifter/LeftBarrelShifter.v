`include "MUX_2_1.v"
module LeftBarrelShifter(a, shift, out);

input [16:1]  a;
input [4:1] shift;

output [16:1] out;

wire [16:1] l1, l2, l3;

// Bit 1
MUX_2_1 lm1_1 (a[1], 1'b0, shift[1], l1[1]);
MUX_2_1 lm1_2 (a[2], a[1], shift[1], l1[2]);
MUX_2_1 lm1_3 (a[3], a[2], shift[1], l1[3]);
MUX_2_1 lm1_4 (a[4], a[3], shift[1], l1[4]);
MUX_2_1 lm1_5 (a[5], a[4], shift[1], l1[5]);
MUX_2_1 lm1_6 (a[6], a[5], shift[1], l1[6]);
MUX_2_1 lm1_7 (a[7], a[6], shift[1], l1[7]);
MUX_2_1 lm1_8 (a[8], a[7], shift[1], l1[8]);
MUX_2_1 lm1_9 (a[9], a[8], shift[1], l1[9]);
MUX_2_1 lm1_10 (a[10], a[9], shift[1], l1[10]);
MUX_2_1 lm1_11 (a[11], a[10], shift[1], l1[11]);
MUX_2_1 lm1_12 (a[12], a[11], shift[1], l1[12]);
MUX_2_1 lm1_13 (a[13], a[12], shift[1], l1[13]);
MUX_2_1 lm1_14 (a[14], a[13], shift[1], l1[14]);
MUX_2_1 lm1_15 (a[15], a[14], shift[1], l1[15]);
MUX_2_1 lm1_16 (a[16], a[15], shift[1], l1[16]);

// Bit 2
MUX_2_1 lm2_1 (l1[1], 1'b0, shift[2], l2[1]);
MUX_2_1 lm2_2 (l1[2], 1'b0, shift[2], l2[2]);
MUX_2_1 lm2_3 (l1[3], l1[1], shift[2], l2[3]);
MUX_2_1 lm2_4 (l1[4], l1[2], shift[2], l2[4]);
MUX_2_1 lm2_5 (l1[5], l1[3], shift[2], l2[5]);
MUX_2_1 lm2_6 (l1[6], l1[4], shift[2], l2[6]);
MUX_2_1 lm2_7 (l1[7], l1[5], shift[2], l2[7]);
MUX_2_1 lm2_8 (l1[8], l1[6], shift[2], l2[8]);
MUX_2_1 lm2_9 (l1[9], l1[7], shift[2], l2[9]);
MUX_2_1 lm2_10 (l1[10], l1[8], shift[2], l2[10]);
MUX_2_1 lm2_11 (l1[11], l1[9], shift[2], l2[11]);
MUX_2_1 lm2_12 (l1[12], l1[10], shift[2], l2[12]);
MUX_2_1 lm2_13 (l1[13], l1[11], shift[2], l2[13]);
MUX_2_1 lm2_14 (l1[14], l1[12], shift[2], l2[14]);
MUX_2_1 lm2_15 (l1[15], l1[13], shift[2], l2[15]);
MUX_2_1 lm2_16 (l1[16], l1[14], shift[2], l2[16]);

// Bit 3
MUX_2_1 lm3_1 (l2[1], 1'b0, shift[3], l3[1]);
MUX_2_1 lm3_2 (l2[2], 1'b0, shift[3], l3[2]);
MUX_2_1 lm3_3 (l2[3], 1'b0, shift[3], l3[3]);
MUX_2_1 lm3_4 (l2[4], 1'b0, shift[3], l3[4]);
MUX_2_1 lm3_5 (l2[5], l2[1], shift[3], l3[5]);
MUX_2_1 lm3_6 (l2[6], l2[2], shift[3], l3[6]);
MUX_2_1 lm3_7 (l2[7], l2[3], shift[3], l3[7]);
MUX_2_1 lm3_8 (l2[8], l2[4], shift[3], l3[8]);
MUX_2_1 lm3_9 (l2[9], l2[5], shift[3], l3[9]);
MUX_2_1 lm3_10 (l2[10], l2[6], shift[3], l3[10]);
MUX_2_1 lm3_11 (l2[11], l2[7], shift[3], l3[11]);
MUX_2_1 lm3_12 (l2[12], l2[8], shift[3], l3[12]);
MUX_2_1 lm3_13 (l2[13], l2[9], shift[3], l3[13]);
MUX_2_1 lm3_14 (l2[14], l2[10], shift[3], l3[14]);
MUX_2_1 lm3_15 (l2[15], l2[11], shift[3], l3[15]);
MUX_2_1 lm3_16 (l2[16], l2[12], shift[3], l3[16]);

// Bit 4
MUX_2_1 lm4_1 (l3[1], 1'b0, shift[4], out[1]);
MUX_2_1 lm4_2 (l3[2], 1'b0, shift[4], out[2]);
MUX_2_1 lm4_3 (l3[3], 1'b0, shift[4], out[3]);
MUX_2_1 lm4_4 (l3[4], 1'b0, shift[4], out[4]);
MUX_2_1 lm4_5 (l3[5], 1'b0, shift[4], out[5]);
MUX_2_1 lm4_6 (l3[6], 1'b0, shift[4], out[6]);
MUX_2_1 lm4_7 (l3[7], 1'b0, shift[4], out[7]);
MUX_2_1 lm4_8 (l3[8], 1'b0, shift[4], out[8]);
MUX_2_1 lm4_9 (l3[9], l3[1], shift[4], out[9]);
MUX_2_1 lm4_10 (l3[10], l3[2], shift[4], out[10]);
MUX_2_1 lm4_11 (l3[11], l3[3], shift[4], out[11]);
MUX_2_1 lm4_12 (l3[12], l3[4], shift[4], out[12]);
MUX_2_1 lm4_13 (l3[13], l3[5], shift[4], out[13]);
MUX_2_1 lm4_14 (l3[14], l3[6], shift[4], out[14]);
MUX_2_1 lm4_15 (l3[15], l3[7], shift[4], out[15]);
MUX_2_1 lm4_16 (l3[16], l3[8], shift[4], out[16]);

endmodule