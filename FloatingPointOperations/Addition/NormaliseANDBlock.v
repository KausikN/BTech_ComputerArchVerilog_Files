module NormaliseANDBlock (a, b, c, out, check);

input a, b, c;
output out, check;

assign out = !a & !b & c;
assign check = b | out;

endmodule