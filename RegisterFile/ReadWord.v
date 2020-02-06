module ReadWord (RegisterFile, ReadAddressDecoded, ReadValue);

input [16:1] RegisterFile [32:1];
input [32:1] ReadAddressDecoded;

output [16:1] ReadValue;

assign ReadValue =  (ReadAddressDecoded[1] ? (RegisterFile[1]) :
                    (ReadAddressDecoded[2] ? (RegisterFile[2]) :
                    (ReadAddressDecoded[3] ? (RegisterFile[3]) :
                    (ReadAddressDecoded[4] ? (RegisterFile[4]) :
                    (ReadAddressDecoded[5] ? (RegisterFile[5]) :
                    (ReadAddressDecoded[6] ? (RegisterFile[6]) :
                    (ReadAddressDecoded[7] ? (RegisterFile[7]) :
                    (ReadAddressDecoded[8] ? (RegisterFile[8]) :
                    (ReadAddressDecoded[9] ? (RegisterFile[9]) :
                    (ReadAddressDecoded[10] ? (RegisterFile[10]) :
                    (ReadAddressDecoded[11] ? (RegisterFile[11]) :
                    (ReadAddressDecoded[12] ? (RegisterFile[12]) :
                    (ReadAddressDecoded[13] ? (RegisterFile[13]) :
                    (ReadAddressDecoded[14] ? (RegisterFile[14]) :
                    (ReadAddressDecoded[15] ? (RegisterFile[15]) :
                    (ReadAddressDecoded[16] ? (RegisterFile[16]) :
                    (ReadAddressDecoded[17] ? (RegisterFile[17]) :
                    (ReadAddressDecoded[18] ? (RegisterFile[18]) :
                    (ReadAddressDecoded[19] ? (RegisterFile[19]) :
                    (ReadAddressDecoded[20] ? (RegisterFile[20]) :
                    (ReadAddressDecoded[21] ? (RegisterFile[21]) :
                    (ReadAddressDecoded[22] ? (RegisterFile[22]) :
                    (ReadAddressDecoded[23] ? (RegisterFile[23]) :
                    (ReadAddressDecoded[24] ? (RegisterFile[24]) :
                    (ReadAddressDecoded[25] ? (RegisterFile[25]) :
                    (ReadAddressDecoded[26] ? (RegisterFile[26]) :
                    (ReadAddressDecoded[27] ? (RegisterFile[27]) :
                    (ReadAddressDecoded[28] ? (RegisterFile[28]) :
                    (ReadAddressDecoded[29] ? (RegisterFile[29]) :
                    (ReadAddressDecoded[30] ? (RegisterFile[30]) :
                    (ReadAddressDecoded[31] ? (RegisterFile[31]) :
                    (ReadAddressDecoded[32] ? (RegisterFile[32]) : (16'b0000000000000000)
                    ))))))))))))))))))))))))))))))));

endmodule