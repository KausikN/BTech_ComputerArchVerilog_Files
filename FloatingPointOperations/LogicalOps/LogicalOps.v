`include "AND.v"
`include "OR.v"
`include "NOT.v"
`include "XOR.v"
`include "NAND.v"
`include "NOR.v"
`include "XNOR.v"
`include "Comp2s.v"

`include "MUX_8_1.v"


module LogicalOps (A, B, Operation, out);

input [16:1] A, B;
input [3:1] Operation;

output [16:1] out;

wire [16:1] w_and, w_or, w_not, w_xor, w_nand, w_nor, w_xnor, w_comp2s;

AND andop (A, B, w_and);
OR orop (A, B, w_or);
NOT notop (A, w_not);
XOR xorop (A, B, w_xor);
NAND nandop (A, B, w_nand);
NOR norop (A, B, w_nor);
XNOR xnorop (A, B, w_xnor);
Comp2s comp2sop (A, w_comp2s);

MUX mux (Operation, w_and, w_or, w_not, w_xor, w_nand, w_nor, w_xnor, w_comp2s, out);

endmodule