module XOR (A, B, out);

input [16:1] A, B;

output [16:1] out;

assign out[1] = A[1] ^ B[1];
assign out[2] = A[2] ^ B[2];
assign out[3] = A[3] ^ B[3];
assign out[4] = A[4] ^ B[4];
assign out[5] = A[5] ^ B[5];
assign out[6] = A[6] ^ B[6];
assign out[7] = A[7] ^ B[7];
assign out[8] = A[8] ^ B[8];
assign out[9] = A[9] ^ B[9];
assign out[10] = A[10] ^ B[10];
assign out[11] = A[11] ^ B[11];
assign out[12] = A[12] ^ B[12];
assign out[13] = A[13] ^ B[13];
assign out[14] = A[14] ^ B[14];
assign out[15] = A[15] ^ B[15];
assign out[16] = A[16] ^ B[16];

endmodule