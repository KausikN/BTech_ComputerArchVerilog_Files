`include "Decoder.v"
`include "DFF_16Bit.v"

module InstructionRegister_L1 (
    mode, 
    ReadAddress1, ReadValue1, 
    reset
);

input reset;
input mode; // mode = 0 - Read Mode | mode = 1 - Write Mode

reg [16:1] RegisterFile [1023:0];

input [5:1] ReadAddress1;
output [16:1] ReadValue1;

// Read 1
assign ReadValue1 = mode ? ReadValue1 : (RegisterFile[ReadAddress1]);

// always @(*) begin
//     $display("%b : %b : %b, %b, %b - %b", mode, WriteValue, RegisterFile[1], RegisterFile[2], RegisterFile[3], WriteAddressDecoded);
// end

endmodule