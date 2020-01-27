`include "RDAdder16Bit.v"

module Comp2s (A, out);

input [16:1] A;

output [16:1] out;

wire [16:1] nA;
wire carry;

NOT notop (A, nA);
RDAdder addr (nA, 16'b0000000000000001, 1'b0, out, carry);

endmodule