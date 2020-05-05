//`include "8BitAdder.v"

module Bit16Adder (a, b, cin, sum, cout);
input[16:1] a, b;
input cin;
output[16:1] sum;
output cout;

	wire w1, w2, w3;

	Bit4Adder B4A_0(a[4:1], b[4:1], cin, sum[4:1], w1);
	Bit4Adder B4A_1(a[8:5], b[8:5], w1, sum[8:5], w2);
	Bit4Adder B4A_2(a[12:9], b[12:9], w2, sum[12:9], w3);
	Bit4Adder B4A_3(a[16:13], b[16:13], w3, sum[16:13], cout);

endmodule
