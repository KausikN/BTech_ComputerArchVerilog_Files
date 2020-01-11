`include "Bit5Adder.v"

module Complemet2s_5Bit (a, b);
input [5:1] a;
output [5:1] b;
	
wire [5:1] comp1s;
comp1s[1] = !a[1];
comp1s[2] = !a[2];
comp1s[3] = !a[3];
comp1s[4] = !a[4];
comp1s[5] = !a[5];

Bit5Adder addr (comp1s, 5'b00001, b);

endmodule
