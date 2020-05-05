`include "FullAdder.v"

module Bit4Adder (a, b, cin, sum, cout);
input[4:1] a, b;
input cin;
output[4:1] sum;
output cout;

	wire w1, w2, w3;

	FullAdder FA_0(a[1], b[1], cin, sum[1], w1);
	FullAdder FA_1(a[2], b[2], w1, sum[2], w2);
	FullAdder FA_2(a[3], b[3], w2, sum[3], w3);
	FullAdder FA_3(a[4], b[4], w3, sum[4], cout);

endmodule
