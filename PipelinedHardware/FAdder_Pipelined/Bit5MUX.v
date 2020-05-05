
module Bit5MUX (a, b, select, out);

input [5:1] a;
input [5:1] b;
input select;

output [5:1] out;

assign out[1] = ((!select) & a[1]) | ((select) & b[1]);
assign out[2] = ((!select) & a[2]) | ((select) & b[2]);
assign out[3] = ((!select) & a[3]) | ((select) & b[3]);
assign out[4] = ((!select) & a[4]) | ((select) & b[4]);
assign out[5] = ((!select) & a[5]) | ((select) & b[5]);

endmodule