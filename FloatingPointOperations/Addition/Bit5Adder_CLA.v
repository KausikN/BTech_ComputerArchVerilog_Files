`include "CLA.v"

module Bit5Adder (a, b, sum, carry);

input [5:1] a;
input [5:1] b;

output [5:1] sum;
output carry;

wire [7:0] A, B, SUM;
wire CARRY;

assign A[4:0] = a;
assign A[7:5] = 3'b000;
assign B[4:0] = b;
assign B[7:5] = 3'b000;

carry_look_ahead_8bit cla (A, B, 1'b0, SUM, CARRY);

assign sum = SUM[4:0];
assign carry = sum[5];

endmodule