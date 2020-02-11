`include "RegisterFile.v"
//`include "Adder16Bit.v"

module test;

reg mode; // mode = 0 - Read Mode | mode = 1 - Write Mode

reg [5:1] WriteAddress;
reg [16:1] WriteValue;

reg [5:1] ReadAddress1, ReadAddress2;
wire [16:1] ReadValue1, ReadValue2;
RegisterFile_16Bit_32Size rf (mode, WriteAddress, WriteValue, ReadAddress1, ReadAddress2, ReadValue1, ReadValue2);

wire [16:1] Sum;
wire Carry;
// Adder16Bit addr (ReadValue1, ReadValue2, Sum, Carry);

initial begin
    $monitor($time, ": ReadValue1: %b (%d), ReadValue2: %b (%d)", 
        ReadValue1, ReadValue1, 
        ReadValue2, ReadValue2
    );
end

initial begin
    mode = 1'b1;
    WriteAddress = 5'b00000;
    WriteValue = 16'b001001000110010;
    #10
    mode = 1'b0; ReadAddress1 = 5'b00000; ReadAddress2 = 5'b00001;
    #10
    mode = 1'b1; WriteAddress = 5'b00001; WriteValue = 16'b0001001001100011;
    #10
    mode = 1'b0; ReadAddress1 = 5'b00000; ReadAddress2 = 5'b00001;
    #10
    mode = 1'b1; WriteAddress = 5'b00010; WriteValue = 16'b1010000001101011;
    #10
    mode = 1'b0; ReadAddress1 = 5'b00001; ReadAddress2 = 5'b00010;
end

endmodule