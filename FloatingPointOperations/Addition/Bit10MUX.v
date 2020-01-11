
module Bit10MUX (a, b, select, out);

input [10:1] a;
input [10:1] b;
input select;

output [10:1] out;

assign out[1] = ((!select) & a[1]) | ((select) & b[1]);
assign out[2] = ((!select) & a[2]) | ((select) & b[2]);
assign out[3] = ((!select) & a[3]) | ((select) & b[3]);
assign out[4] = ((!select) & a[4]) | ((select) & b[4]);
assign out[5] = ((!select) & a[5]) | ((select) & b[5]);
assign out[6] = ((!select) & a[6]) | ((select) & b[6]);
assign out[7] = ((!select) & a[7]) | ((select) & b[7]);
assign out[8] = ((!select) & a[8]) | ((select) & b[8]);
assign out[9] = ((!select) & a[9]) | ((select) & b[9]);
assign out[10] = ((!select) & a[10]) | ((select) & b[10]);

endmodule