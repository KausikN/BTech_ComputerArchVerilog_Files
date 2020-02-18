`include "Decoder.v"

module RegisterFile_16Bit_1024Size (
    ReadAddress1,
    ReadValue1, 
    RegisterFile_0, RegisterFile_1,  RegisterFile_2,  RegisterFile_3,  RegisterFile_4,  
    RegisterFile_5,  RegisterFile_6,  RegisterFile_7,  RegisterFile_8,  
    RegisterFile_9,  RegisterFile_10, RegisterFile_11, RegisterFile_12, 
    RegisterFile_13, RegisterFile_14, RegisterFile_15, RegisterFile_16, 
    RegisterFile_17, RegisterFile_18, RegisterFile_19, RegisterFile_20, 
    RegisterFile_21, RegisterFile_22, RegisterFile_23, RegisterFile_24, 
    RegisterFile_25, RegisterFile_26, RegisterFile_27, RegisterFile_28, 
    RegisterFile_29, RegisterFile_30, RegisterFile_31
);

input [16:1] RegisterFile_0, RegisterFile_1,  RegisterFile_2,  RegisterFile_3,  RegisterFile_4,  
    RegisterFile_5,  RegisterFile_6,  RegisterFile_7,  RegisterFile_8,  
    RegisterFile_9,  RegisterFile_10, RegisterFile_11, RegisterFile_12, 
    RegisterFile_13, RegisterFile_14, RegisterFile_15, RegisterFile_16, 
    RegisterFile_17, RegisterFile_18, RegisterFile_19, RegisterFile_20, 
    RegisterFile_21, RegisterFile_22, RegisterFile_23, RegisterFile_24, 
    RegisterFile_25, RegisterFile_26, RegisterFile_27, RegisterFile_28, 
    RegisterFile_29, RegisterFile_30, RegisterFile_31;

reg [16:1] RegisterFile [1023:0];

input [10:1] ReadAddress1;
output [16:1] ReadValue1;

// Initial Write
always @(*) begin
    RegisterFile[0] <= RegisterFile_0;
    RegisterFile[1] <= RegisterFile_1;
    RegisterFile[2] <= RegisterFile_2;
    RegisterFile[3] <= RegisterFile_3;
    RegisterFile[4] <= RegisterFile_4;
    RegisterFile[5] <= RegisterFile_5;
    RegisterFile[6] <= RegisterFile_6;
    RegisterFile[7] <= RegisterFile_7;
    RegisterFile[8] <= RegisterFile_8;
    RegisterFile[9] <= RegisterFile_9;
    RegisterFile[10] <= RegisterFile_10;
    RegisterFile[11] <= RegisterFile_11;
    RegisterFile[12] <= RegisterFile_12;
    RegisterFile[13] <= RegisterFile_13;
    RegisterFile[14] <= RegisterFile_14;
    RegisterFile[15] <= RegisterFile_15;
    RegisterFile[16] <= RegisterFile_16;
    RegisterFile[17] <= RegisterFile_17;
    RegisterFile[18] <= RegisterFile_18;
    RegisterFile[19] <= RegisterFile_19;
    RegisterFile[20] <= RegisterFile_20;
    RegisterFile[21] <= RegisterFile_21;
    RegisterFile[22] <= RegisterFile_22;
    RegisterFile[23] <= RegisterFile_23;
    RegisterFile[24] <= RegisterFile_24;
    RegisterFile[25] <= RegisterFile_25;
    RegisterFile[26] <= RegisterFile_26;
    RegisterFile[27] <= RegisterFile_27;
    RegisterFile[28] <= RegisterFile_28;
    RegisterFile[29] <= RegisterFile_29;
    RegisterFile[30] <= RegisterFile_30;
    RegisterFile[31] <= RegisterFile_31;
end

// Read
assign ReadValue1 = RegisterFile[ReadAddress1]; // Uses Inbuilt Decoder

// always @(*) begin
//     $display("%b : %b : %b, %b, %b - %b", mode, WriteValue, RegisterFile[1], RegisterFile[2], RegisterFile[3], WriteAddressDecoded);
// end

endmodule