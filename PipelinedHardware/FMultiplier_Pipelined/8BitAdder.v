`include "4BitAdder.v"

module Bit8Adder (a, b, cin, sum, cout);
input[8:1] a, b;
input cin;
output[8:1] sum;
output cout;

	wire w1;

	Bit4Adder B4A1 (a[4:1], b[4:1], cin, sum[4:1], w1);
	Bit4Adder B4A2 (a[8:5], b[8:5], w1, sum[8:5], cout);

endmodule
