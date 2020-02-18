`include "Decoder.v"

module RegisterFile_16Bit_32Size (
    ReadAddress1,
    ReadValue1
);

reg [16:1] RegisterFile [32:1];

input [5:1] ReadAddress1;
output [16:1] ReadValue1;

// Initial Write
initial begin
    RegisterFile[1] <= 16'b0000000000000001;
    RegisterFile[2] <= 16'b0000000000000010;
    RegisterFile[3] <= 16'b0000000000000011;
    RegisterFile[4] <= 16'b0000000000000100;
    RegisterFile[5] <= 16'b0000000000000101;
    RegisterFile[6] <= 16'b0000000000000000;
    RegisterFile[7] <= 16'b0000000000000000;
    RegisterFile[8] <= 16'b0000000000000000;
    RegisterFile[9] <= 16'b0000000000000000;
    RegisterFile[10] <= 16'b0000000000000000;
    RegisterFile[11] <= 16'b0000000000000000;
    RegisterFile[12] <= 16'b0000000000000000;
    RegisterFile[13] <= 16'b0000000000000000;
    RegisterFile[14] <= 16'b0000000000000000;
    RegisterFile[15] <= 16'b0000000000000000;
    RegisterFile[16] <= 16'b0000000000000000;
    RegisterFile[17] <= 16'b0000000000000000;
    RegisterFile[18] <= 16'b0000000000000000;
    RegisterFile[19] <= 16'b0000000000000000;
    RegisterFile[20] <= 16'b0000000000000000;
    RegisterFile[21] <= 16'b0000000000000000;
    RegisterFile[22] <= 16'b0000000000000000;
    RegisterFile[23] <= 16'b0000000000000000;
    RegisterFile[24] <= 16'b0000000000000000;
    RegisterFile[25] <= 16'b0000000000000000;
    RegisterFile[26] <= 16'b0000000000000000;
    RegisterFile[27] <= 16'b0000000000000000;
    RegisterFile[28] <= 16'b0000000000000000;
    RegisterFile[29] <= 16'b0000000000000000;
    RegisterFile[30] <= 16'b0000000000000000;
    RegisterFile[31] <= 16'b0000000000000000;
    RegisterFile[32] <= 16'b0000000000000000;
end


// Read 1
wire [32:1] ReadAddressDecoded1;
wire [16:1] ReadValueTemp1;
Decoder_5Bit readdecoder1 (ReadAddress1, ReadAddressDecoded1);
assign ReadValueTemp1 =  (ReadAddressDecoded1[1] ? (RegisterFile[1]) :
                    (ReadAddressDecoded1[2] ? (RegisterFile[2]) :
                    (ReadAddressDecoded1[3] ? (RegisterFile[3]) :
                    (ReadAddressDecoded1[4] ? (RegisterFile[4]) :
                    (ReadAddressDecoded1[5] ? (RegisterFile[5]) :
                    (ReadAddressDecoded1[6] ? (RegisterFile[6]) :
                    (ReadAddressDecoded1[7] ? (RegisterFile[7]) :
                    (ReadAddressDecoded1[8] ? (RegisterFile[8]) :
                    (ReadAddressDecoded1[9] ? (RegisterFile[9]) :
                    (ReadAddressDecoded1[10] ? (RegisterFile[10]) :
                    (ReadAddressDecoded1[11] ? (RegisterFile[11]) :
                    (ReadAddressDecoded1[12] ? (RegisterFile[12]) :
                    (ReadAddressDecoded1[13] ? (RegisterFile[13]) :
                    (ReadAddressDecoded1[14] ? (RegisterFile[14]) :
                    (ReadAddressDecoded1[15] ? (RegisterFile[15]) :
                    (ReadAddressDecoded1[16] ? (RegisterFile[16]) :
                    (ReadAddressDecoded1[17] ? (RegisterFile[17]) :
                    (ReadAddressDecoded1[18] ? (RegisterFile[18]) :
                    (ReadAddressDecoded1[19] ? (RegisterFile[19]) :
                    (ReadAddressDecoded1[20] ? (RegisterFile[20]) :
                    (ReadAddressDecoded1[21] ? (RegisterFile[21]) :
                    (ReadAddressDecoded1[22] ? (RegisterFile[22]) :
                    (ReadAddressDecoded1[23] ? (RegisterFile[23]) :
                    (ReadAddressDecoded1[24] ? (RegisterFile[24]) :
                    (ReadAddressDecoded1[25] ? (RegisterFile[25]) :
                    (ReadAddressDecoded1[26] ? (RegisterFile[26]) :
                    (ReadAddressDecoded1[27] ? (RegisterFile[27]) :
                    (ReadAddressDecoded1[28] ? (RegisterFile[28]) :
                    (ReadAddressDecoded1[29] ? (RegisterFile[29]) :
                    (ReadAddressDecoded1[30] ? (RegisterFile[30]) :
                    (ReadAddressDecoded1[31] ? (RegisterFile[31]) :
                    (ReadAddressDecoded1[32] ? (RegisterFile[32]) : (16'b0000000000000000)
                    ))))))))))))))))))))))))))))))));

// always @(*) begin
//     $display("%b : %b : %b, %b, %b - %b", mode, WriteValue, RegisterFile[1], RegisterFile[2], RegisterFile[3], WriteAddressDecoded);
// end

assign ReadValue1 = ReadValueTemp1;

endmodule