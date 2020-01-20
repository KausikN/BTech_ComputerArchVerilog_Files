`include "16BitAdder.v"

module Bit32Adder (a, b, cin, sum, cout);
input[32:1] a, b;
input cin;
output[32:1] sum;
output cout;

	wire w1;

	Bit16Adder B16A_0(a[16:1], b[16:1], cin, sum[16:1], w1);
	Bit16Adder B16A_1(a[32:17], b[32:17], w1, sum[32:17], cout);

endmodule
