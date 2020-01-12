`include "BitwiseAND_5Bit.v"

module Encoder11Bit_to_5Bit (a, b);

input [11:1] a;
output [5:1] b;

reg [5:1] n_0 = 5'b00000;
reg [5:1] n_1 = 5'b00001;
reg [5:1] n_2 = 5'b00010;
reg [5:1] n_3 = 5'b00011;
reg [5:1] n_4 = 5'b00100;
reg [5:1] n_5 = 5'b00101;
reg [5:1] n_6 = 5'b00110;
reg [5:1] n_7 = 5'b00111;
reg [5:1] n_8 = 5'b01000;
reg [5:1] n_9 = 5'b01001;
reg [5:1] n_10 = 5'b01010;
reg [5:1] n_11 = 5'b01011;

wire [5:1] a_1, a_2, a_3, a_4, a_5, a_6, a_7, a_8, a_9, a_10, a_11;
BitwiseAND_5Bit b_1 (n_1, a[1], a_1);
BitwiseAND_5Bit b_2 (n_2, a[2], a_2);
BitwiseAND_5Bit b_3 (n_3, a[3], a_3);
BitwiseAND_5Bit b_4 (n_4, a[4], a_4);
BitwiseAND_5Bit b_5 (n_5, a[5], a_5);
BitwiseAND_5Bit b_6 (n_6, a[6], a_6);
BitwiseAND_5Bit b_7 (n_7, a[7], a_7);
BitwiseAND_5Bit b_8 (n_8, a[8], a_8);
BitwiseAND_5Bit b_9 (n_9, a[9], a_9);
BitwiseAND_5Bit b_10 (n_10, a[10], a_10);
BitwiseAND_5Bit b_11 (n_11, a[11], a_11);

assign b[1] = a_1[1] | a_2[1] | a_3[1] | a_4[1] | a_5[1] | a_6[1] | a_7[1] | a_8[1] | a_9[1] | a_10[1] | a_11[1];
assign b[2] = a_1[2] | a_2[2] | a_3[2] | a_4[2] | a_5[2] | a_6[2] | a_7[2] | a_8[2] | a_9[2] | a_10[2] | a_11[2];
assign b[3] = a_1[3] | a_2[3] | a_3[3] | a_4[3] | a_5[3] | a_6[3] | a_7[3] | a_8[3] | a_9[3] | a_10[3] | a_11[3];
assign b[4] = a_1[4] | a_2[4] | a_3[4] | a_4[4] | a_5[4] | a_6[4] | a_7[4] | a_8[4] | a_9[4] | a_10[4] | a_11[4];
assign b[5] = a_1[5] | a_2[5] | a_3[5] | a_4[5] | a_5[5] | a_6[5] | a_7[5] | a_8[5] | a_9[5] | a_10[5] | a_11[5];

endmodule