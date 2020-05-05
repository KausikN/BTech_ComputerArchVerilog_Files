//`include "CLA.v"
`include "RDAdder16Bit.v"

module Bit5Adder (a, b, sum, carry);

input [5:1] a;
input [5:1] b;

output [5:1] sum;
output carry;

wire [16:1] A, B, SUM;
wire CARRY;

assign A[5:1] = a;
assign A[16:6] = 11'b00000000000;
assign B[5:1] = b;
assign B[16:6] = 11'b00000000000;

RDAdder addr (A, B, 1'b0, SUM, CARRY);

assign sum = SUM[5:1];
assign carry = SUM[6];

endmodule