`include "Decoder_3_8.v"

module MUX (Chooser, A1, A2, A3, A4, A5, A6, A7, A8, out);

input [3:1] Chooser;
input [16:1] A1, A2, A3, A4, A5, A6, A7, A8;

output [16:1] out;

wire [8:1] D;
Decoder decoder (Chooser, D);

assign out =    (D[1]) ? A1 : 
                (D[2]) ? A2 : 
                (D[3]) ? A3 : 
                (D[4]) ? A4 : 
                (D[5]) ? A5 : 
                (D[6]) ? A6 : 
                (D[7]) ? A7 : 
                A8;

endmodule