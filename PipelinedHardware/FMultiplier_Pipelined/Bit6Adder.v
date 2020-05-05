//`include "FullAdder.v"

module Bit6Adder (a, b, sum, carry);

input [6:1] a;
input [6:1] b;

output [6:1] sum;
output carry;

wire [5:1] w;

FullAdder fa_1 (a[1], b[1], 1'b0, sum[1], w[1]);
FullAdder fa_2 (a[2], b[2], w[1], sum[2], w[2]);
FullAdder fa_3 (a[3], b[3], w[2], sum[3], w[3]);
FullAdder fa_4 (a[4], b[4], w[3], sum[4], w[4]);
FullAdder fa_5 (a[5], b[5], w[4], sum[5], w[5]);
FullAdder fa_6 (a[6], b[6], w[5], sum[6], carry);

endmodule