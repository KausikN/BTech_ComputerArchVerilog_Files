module Decoder(E, D);
input [3:1] E;
output [8:1] D;
assign D[1]=(~E[3]&~E[2]&~E[1]);
assign D[2]=(~E[3]&~E[2]&E[1]);
assign D[3]=(~E[3]&E[2]&~E[1]);
assign D[4]=(~E[3]&E[2]&E[1]);
assign D[5]=(E[3]&~E[2]&~E[1]);
assign D[6]=(E[3]&~E[2]&E[1]);
assign D[7]=(E[3]&E[2]&~E[1]);
assign D[8]=(E[3]&E[2]&E[1]);
endmodule