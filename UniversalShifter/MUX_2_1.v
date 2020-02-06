module MUX_2_1(A, B, S, out);

input A, B, S;

output out;

assign out = ((!S) & A) | (S & B);

endmodule