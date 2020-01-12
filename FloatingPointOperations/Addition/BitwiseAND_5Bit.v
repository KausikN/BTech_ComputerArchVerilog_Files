
module BitwiseAND_5Bit (a, select, b);

input [5:1] a;
input select;
output [5:1] b;

assign b[1] = select & a[1];
assign b[2] = select & a[2];
assign b[3] = select & a[3];
assign b[4] = select & a[4];
assign b[5] = select & a[5];

endmodule