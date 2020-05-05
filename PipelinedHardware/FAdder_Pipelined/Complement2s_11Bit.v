`include "Bit11Adder_RD.v"

module Complement2s_11Bit (a, b);
input [11:1] a;
output [11:1] b;
	
wire [11:1] comp1s;
assign comp1s[1] = !a[1];
assign comp1s[2] = !a[2];
assign comp1s[3] = !a[3];
assign comp1s[4] = !a[4];
assign comp1s[5] = !a[5];
assign comp1s[6] = !a[6];
assign comp1s[7] = !a[7];
assign comp1s[8] = !a[8];
assign comp1s[9] = !a[9];
assign comp1s[10] = !a[10];
assign comp1s[11] = !a[11];

wire c;

Bit11Adder addr (comp1s, 11'b00000000001, b, c);

endmodule
