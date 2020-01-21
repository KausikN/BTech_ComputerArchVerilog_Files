//`include "CLA.v"
//`include "RDAdder16Bit.v"

module Bit11Adder (a, b, sum, carry);

input [11:1] a;
input [11:1] b;

output [11:1] sum;
output carry;

wire [16:1] A, B, SUM;
wire CARRY;

assign A[11:1] = a;
assign A[16:12] = 5'b00000;
assign B[11:1] = b;
assign B[16:12] = 5'b00000;

RDAdder addr (A, B, 1'b0, SUM, CARRY);

assign sum = SUM[11:1];
assign carry = SUM[12];

endmodule