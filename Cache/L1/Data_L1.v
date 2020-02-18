
module Data_L1 (
    mode, 
    WriteAddress, WriteValue, 
    ReadAddress1, ReadAddress2, 
    ReadValue1, ReadValue2, 
    reset
);

input reset;
input mode; // mode = 0 - Read Mode | mode = 1 - Write Mode

wire [16:1] RegisterFile [4095:0];

input [5:1] WriteAddress;
input [16:1] WriteValue;

input [5:1] ReadAddress1, ReadAddress2;
output [16:1] ReadValue1, ReadValue2;

// Write
always @(*) begin 
    RegisterFile[WriteAddress] <= mode ? WriteValue : RegisterFile[WriteAddress];
end

// Read 1
assign ReadValue1 = mode ? ReadValue1 : (RegisterFile[ReadAddress1]);

// Read 2
assign ReadValue2 = mode ? ReadValue2 : (RegisterFile[ReadAddress2]);

// always @(*) begin
//     $display("%b : %b : %b, %b, %b - %b", mode, WriteValue, RegisterFile[1], RegisterFile[2], RegisterFile[3], WriteAddressDecoded);
// end

endmodule