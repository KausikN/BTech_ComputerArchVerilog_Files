module ReplaceWord (RegisterFile, WriteValue, WriteAddressDecoded, outRegisterFile);

input [16:1] RegisterFile [32:1];

input [32:1] WriteAddressDecoded;
input [16:1] WriteValue;

output [16:1] outRegisterFile [32:1];

assign outRegisterFile[1] = WriteAddressDecoded[1] ? (WriteValue) : (RegisterFile[1]);
assign outRegisterFile[2] = WriteAddressDecoded[2] ? (WriteValue) : (RegisterFile[2]);
assign outRegisterFile[3] = WriteAddressDecoded[3] ? (WriteValue) : (RegisterFile[3]);
assign outRegisterFile[4] = WriteAddressDecoded[4] ? (WriteValue) : (RegisterFile[4]);
assign outRegisterFile[5] = WriteAddressDecoded[5] ? (WriteValue) : (RegisterFile[5]);
assign outRegisterFile[6] = WriteAddressDecoded[6] ? (WriteValue) : (RegisterFile[6]);
assign outRegisterFile[7] = WriteAddressDecoded[7] ? (WriteValue) : (RegisterFile[7]);
assign outRegisterFile[8] = WriteAddressDecoded[8] ? (WriteValue) : (RegisterFile[8]);
assign outRegisterFile[9] = WriteAddressDecoded[9] ? (WriteValue) : (RegisterFile[9]);
assign outRegisterFile[10] = WriteAddressDecoded[10] ? (WriteValue) : (RegisterFile[10]);
assign outRegisterFile[11] = WriteAddressDecoded[11] ? (WriteValue) : (RegisterFile[11]);
assign outRegisterFile[12] = WriteAddressDecoded[12] ? (WriteValue) : (RegisterFile[12]);
assign outRegisterFile[13] = WriteAddressDecoded[13] ? (WriteValue) : (RegisterFile[13]);
assign outRegisterFile[14] = WriteAddressDecoded[14] ? (WriteValue) : (RegisterFile[14]);
assign outRegisterFile[15] = WriteAddressDecoded[15] ? (WriteValue) : (RegisterFile[15]);
assign outRegisterFile[16] = WriteAddressDecoded[16] ? (WriteValue) : (RegisterFile[16]);
assign outRegisterFile[17] = WriteAddressDecoded[17] ? (WriteValue) : (RegisterFile[17]);
assign outRegisterFile[18] = WriteAddressDecoded[18] ? (WriteValue) : (RegisterFile[18]);
assign outRegisterFile[19] = WriteAddressDecoded[19] ? (WriteValue) : (RegisterFile[19]);
assign outRegisterFile[20] = WriteAddressDecoded[20] ? (WriteValue) : (RegisterFile[20]);
assign outRegisterFile[21] = WriteAddressDecoded[21] ? (WriteValue) : (RegisterFile[21]);
assign outRegisterFile[22] = WriteAddressDecoded[22] ? (WriteValue) : (RegisterFile[22]);
assign outRegisterFile[23] = WriteAddressDecoded[23] ? (WriteValue) : (RegisterFile[23]);
assign outRegisterFile[24] = WriteAddressDecoded[24] ? (WriteValue) : (RegisterFile[24]);
assign outRegisterFile[25] = WriteAddressDecoded[25] ? (WriteValue) : (RegisterFile[25]);
assign outRegisterFile[26] = WriteAddressDecoded[26] ? (WriteValue) : (RegisterFile[26]);
assign outRegisterFile[27] = WriteAddressDecoded[27] ? (WriteValue) : (RegisterFile[27]);
assign outRegisterFile[28] = WriteAddressDecoded[28] ? (WriteValue) : (RegisterFile[28]);
assign outRegisterFile[29] = WriteAddressDecoded[29] ? (WriteValue) : (RegisterFile[29]);
assign outRegisterFile[30] = WriteAddressDecoded[30] ? (WriteValue) : (RegisterFile[30]);
assign outRegisterFile[31] = WriteAddressDecoded[31] ? (WriteValue) : (RegisterFile[31]);
assign outRegisterFile[32] = WriteAddressDecoded[32] ? (WriteValue) : (RegisterFile[32]);

endmodule