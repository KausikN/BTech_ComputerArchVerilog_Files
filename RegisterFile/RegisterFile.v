`include "Decoder.v"
`include "ReplaceWord.v"
`include "ReadWord.v"

module RegisterFile_16Bit_32Size (RegisterFile, mode, 
WriteAddress, WriteValue, outRegisterFile, 
ReadAddress1, ReadAddress2, 
ReadValue1, ReadValue2
);

input mode; // mode = 0 - Read Mode | mode = 1 - Write Mode

input [16:1] RegisterFile [32:1];
output reg [16:1] outRegisterFile [32:1];

input [5:1] WriteAddress;
input [16:1] WriteValue;

input [5:1] ReadAddress1, ReadAddress2;
output [16:1] ReadValue1, ReadValue2;

// Write
wire [32:1] WriteAddressDecoded;
wire [16:1] outRegisterFileTemp [32:1];
Decoder_5Bit writedecoder (WriteAddress, WriteAddressDecoded);
ReplaceWord writereplace (RegisterFile, WriteValue, WriteAddressDecoded, outRegisterFileTemp);

// Read 1
wire [32:1] ReadAddressDecoded1;
wire [16:1] ReadValueTemp1;
Decoder_5Bit readdecoder1 (ReadAddress1, ReadAddressDecoded1);
ReadWord read1 (RegisterFile, ReadAddressDecoded1, ReadValueTemp1);

// Read 2
wire [32:1] ReadAddressDecoded2;
wire [16:1] ReadValueTemp2;
Decoder_5Bit readdecoder2 (ReadAddress2, ReadAddressDecoded2);
ReadWord read2 (RegisterFile, ReadAddressDecoded2, ReadValueTemp2);

// Final Output based on mode
always @(*) begin
    outRegisterFile <= mode ? (outRegisterFileTemp) : (RegisterFile);
end
assign ReadValue1 = mode ? ReadValue1 : (ReadValueTemp1);
assign ReadValue2 = mode ? ReadValue2 : (ReadValueTemp2);

endmodule