module ShiftRightOnce_11Bit (a, b);

input [11:1] a;
output [11:1] b;

assign b[11] = 1'b0;
assign b[10] = a[11];
assign b[9] = a[10];
assign b[8] = a[9];
assign b[7] = a[8];
assign b[6] = a[7];
assign b[5] = a[6];
assign b[4] = a[5];
assign b[3] = a[4];
assign b[2] = a[3];
assign b[1] = a[2];

endmodule