`include "RegisterFile.v"
//`include "Adder16Bit.v"

module test;

reg reset;
reg mode; // mode = 0 - Read Mode | mode = 1 - Write Mode

reg [5:1] WriteAddress;
reg [16:1] WriteValue;

reg [5:1] ReadAddress1, ReadAddress2;
wire [16:1] ReadValue1, ReadValue2;
RegisterFile_16Bit_32Size rf (mode, WriteAddress, WriteValue, ReadAddress1, ReadAddress2, ReadValue1, ReadValue2, reset);

wire [16:1] Sum;
wire Carry;
// Adder16Bit addr (ReadValue1, ReadValue2, Sum, Carry);

initial begin
    $monitor($time, ": Read1: %b = %b (%d), Read2: %b = %b (%d)", 
        ReadAddress1, ReadValue1, ReadValue1, 
        ReadAddress2, ReadValue2, ReadValue2
    );
end

initial begin
    reset = 1'b1;
    WriteAddress = 5'b00000;
    WriteValue = 16'b001001000110010;
    mode = 1'b1;
    #10
    reset = 1'b0;
    mode = 1'b0; ReadAddress1 = 5'b00000; ReadAddress2 = 5'b00001;
    #10
    WriteAddress = 5'b00001; WriteValue = 16'b0001001001100011; #1 mode = 1'b1;
    #10
    mode = 1'b0; ReadAddress1 = 5'b00000; ReadAddress2 = 5'b00001;
    #10
    WriteAddress = 5'b00010; WriteValue = 16'b1010000001101011; #1 mode = 1'b1;
    #10
    mode = 1'b0; ReadAddress1 = 5'b00001; ReadAddress2 = 5'b00010;
    #100 $finish;
end

endmodule