`include "32BitAdder.v"

module Bit36Adder (a, b, cin, sum, cout);
input[36:1] a, b;
input cin;
output[36:1] sum;
output cout;

	wire w1, w2;

	Bit16Adder B16A_0(a[16:1], b[16:1], cin, sum[16:1], w1);
	Bit16Adder B16A_1(a[32:17], b[32:17], w1, sum[32:17], w2);
	Bit4Adder  B4A_2 (a[36:33], b[36:33], w2, sum[36:33], cout);

endmodule
