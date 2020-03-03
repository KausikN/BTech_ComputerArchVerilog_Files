`include "TagCompare.v"

module Data_L1 (
    mode, 
    WriteAddress_Full, WriteValue, 
    ReadAddress_Full, ReadValue, 
    reset
);

input reset;
input mode; // mode = 0 - Read Mode | mode = 1 - Write Mode

reg [15:0] MainMemory [65535:0];

reg [127:0] DataCache [2047:0];
reg [2:0] BlockTags [2047:1];

input [16:1] WriteAddress_Full;
input [16:1] WriteValue;

input [16:1] ReadAddress_Full;
output [16:1] ReadValue;

wire [14:1] WriteAddress;
wire [14:1] ReadAddress;

wire [11:1] WriteBlockIndex;
wire [11:1] ReadBlockIndex;

wire [3:1] WriteWordIndex;
wire [3:1] ReadWordIndex;

wire [2:1] WriteTag;
wire [2:1] ReadTag;

reg [2047:0] ValidityBit;
reg [2047:0] DirtyBit;

wire ReadHit;
wire WriteHit;

// Assign Tag and Indices
assign WriteTag = WriteAddress_Full[16:15];
assign ReadTag = ReadAddress_Full[16:15];

assign WriteBlockIndex = WriteAddress_Full[14:4];
assign ReadBlockIndex = ReadAddress_Full[14:4];

assign WriteWordIndex = WriteAddress_Full[3:1];
assign ReadWordIndex = ReadAddress_Full[3:1];

assign WriteAddress = WriteAddress_Full[14:1];
assign ReadAddress = ReadAddress_Full[14:1];

// Initially Validity and Dirty is 0 for all
initial begin
    // integer i = 0;
    // while (i < 2048) begin
    //     ValidityBit[i] = 1'b0;
    //     DirtyBit[i] = 1'b0;
    //     i = i + 1;
    // end
    ValidityBit = 2048'b0;
    DirtyBit = 2048'b0;
end

// Write
reg [16:1] TempWriteAddress;
integer i;
// Compare Tag
wire WriteTagCheck;
TagCompare tcw (WriteTag, BlockTags[WriteBlockIndex], WriteTagCheck);
assign WriteHit = (WriteTagCheck & ValidityBit[WriteBlockIndex]);
always @(*) begin 
    if (WriteHit) begin
        DataCache[WriteBlockIndex] <= WriteValue;
        DirtyBit[WriteBlockIndex] <= 1'b1;
    end
    else if (!WriteHit) begin
        TempWriteAddress[14:4] <= WriteBlockIndex;
        TempWriteAddress[3:1] <= 3'b000;
        if (DirtyBit[WriteBlockIndex]) begin
            TempWriteAddress[16:15] <= BlockTags[WriteBlockIndex];
            i = 0;
            while (i < 8) begin
                MainMemory[TempWriteAddress + i][15:0] <= DataCache[WriteBlockIndex][16*i + 15 : 16*i];
                i = i + 1;
            end
            DirtyBit[WriteBlockIndex] = 1'b0;
        end
        TempWriteAddress[16:15] <= WriteTag;
        i = 0;
        while (i < 8) begin
            DataCache[WriteBlockIndex][16*i + 15 : 16*i] <= MainMemory[TempWriteAddress + i][15:0];
            i = i + 1;
        end
        DataCache[WriteBlockIndex] <= WriteValue;
        DirtyBit[WriteBlockIndex] <= 1'b1;
    end
end

// Read
// Compare Tag
wire ReadTagCheck;
TagCompare tcr (ReadTag, BlockTags[ReadBlockIndex], ReadTagCheck);
assign ReadHit = (ReadTagCheck & ValidityBit[ReadBlockIndex]);
assign ReadValue = (ReadTagCheck & ValidityBit[ReadBlockIndex]) ? (mode ? ReadValue : (DataCache[ReadBlockIndex])) :  // Hit
                                                            (MainMemory[ReadAddress_Full]);                 // Miss

always @(*) begin   // Block Replacement
    if (!ReadHit) begin
        DataCache[ReadBlockIndex] <= (MainMemory[ReadAddress_Full]);
        BlockTags[ReadBlockIndex] <= ReadTag;
    end
end

endmodule