//`include "CLA.v"

module Bit11Adder (a, b, sum, carry);

input [11:1] a;
input [11:1] b;

output [11:1] sum;
output carry;

wire [15:0] A, B, SUM;
wire CARRY;

assign A[10:0] = a;
assign A[15:11] = 5'b00000;
assign B[10:0] = b;
assign B[15:11] = 5'b00000;

carry_look_ahead_16bit cla (A, B, 1'b0, SUM, CARRY);

assign sum = SUM[10:0];
assign carry = sum[11];

endmodule