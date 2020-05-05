//`include "FullAdder.v"

module Bit11Adder (a, b, sum, carry);

input [11:1] a;
input [11:1] b;

output [11:1] sum;
output carry;

wire [10:1] w;

FullAdder fa_1 (a[1], b[1], 1'b0, sum[1], w[1]);
FullAdder fa_2 (a[2], b[2], w[1], sum[2], w[2]);
FullAdder fa_3 (a[3], b[3], w[2], sum[3], w[3]);
FullAdder fa_4 (a[4], b[4], w[3], sum[4], w[4]);
FullAdder fa_5 (a[5], b[5], w[4], sum[5], w[5]);
FullAdder fa_6 (a[6], b[6], w[5], sum[6], w[6]);
FullAdder fa_7 (a[7], b[7], w[6], sum[7], w[7]);
FullAdder fa_8 (a[8], b[8], w[7], sum[8], w[8]);
FullAdder fa_9 (a[9], b[9], w[8], sum[9], w[9]);
FullAdder fa_10 (a[10], b[10], w[9], sum[10], w[10]);
FullAdder fa_11 (a[11], b[11], w[10], sum[11], carry);

endmodule