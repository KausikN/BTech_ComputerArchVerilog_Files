`include "Bit11Adder.v"

module Complemet2s_11Bit (a, b);
input [11:1] a;
output [11:1] b;
	
wire [11:1] comp1s;
comp1s[1] = !a[1];
comp1s[2] = !a[2];
comp1s[3] = !a[3];
comp1s[4] = !a[4];
comp1s[5] = !a[5];
comp1s[6] = !a[6];
comp1s[7] = !a[7];
comp1s[8] = !a[8];
comp1s[9] = !a[9];
comp1s[10] = !a[10];
comp1s[11] = !a[11];

Bit11Adder addr (comp1s, 11'b00000000001, b);

endmodule
