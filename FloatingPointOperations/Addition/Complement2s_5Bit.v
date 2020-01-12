`include "Bit5Adder.v"

module Complement2s_5Bit (a, b);
input [5:1] a;
output [5:1] b;
	
wire [5:1] comp1s;
wire c;
assign comp1s[1] = !a[1];
assign comp1s[2] = !a[2];
assign comp1s[3] = !a[3];
assign comp1s[4] = !a[4];
assign comp1s[5] = !a[5];

Bit5Adder addr (comp1s, 5'b00001, b, c);

endmodule
