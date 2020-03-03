`include "TagCompare.v"

module Data_L1 (
    WriteAddress_Full, WriteValue, 
    ReadAddress_Full, ReadValue, 
    WriteHit, ReadHit, 
    reset
);

input reset;

reg [15:0] MainMemory [65535:0];

reg [127:0] DataCache [2047:0];
reg [2:1] BlockTags [2047:0];

input [16:1] WriteAddress_Full;
input [16:1] WriteValue;

input [16:1] ReadAddress_Full;
output reg [16:1] ReadValue;

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

output ReadHit;
output WriteHit;

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
    // while (i  2048) begin
    //     ValidityBit[i] = 1'b0;
    //     DirtyBit[i] = 1'b0;
    //     i = i + 1;
    // end
    ValidityBit = 2048'b0;
    DirtyBit = 2048'b0;
end

// Write
integer TempWriteAddress;
integer TempReadAddress;
// Compare Tag
wire WriteTagCheck;
TagCompare tcw (WriteTag, BlockTags[WriteBlockIndex], WriteTagCheck);
assign WriteHit = (WriteTagCheck & ValidityBit[WriteBlockIndex]);


// Read
// Compare Tag
wire ReadTagCheck;
TagCompare tcr (ReadTag, BlockTags[ReadBlockIndex], ReadTagCheck);
assign ReadHit = (ReadTagCheck & ValidityBit[ReadBlockIndex]);

always @(*) begin
    $display("Debug: Write - %b -> %b - %b : %b @ %b", WriteValue, WriteAddress_Full, WriteHit, DirtyBit[WriteBlockIndex], DataCache[WriteBlockIndex]);
    $display("Debug: Read - %b -> %b - %b : %b", ReadValue, ReadAddress_Full, ReadHit, DataCache[ReadBlockIndex]);
end

// Write Hit or Miss
always @(WriteHit) begin
    if (WriteHit == 1'b1) begin // Hit
        $display("Write Hit");
        
        if (WriteWordIndex == 3'b000)
            DataCache[WriteBlockIndex][0*16 + 15: 0*16] = WriteValue;
        else if (WriteWordIndex == 3'b001)
            DataCache[WriteBlockIndex][1*16 + 15: 1*16] = WriteValue;
        else if (WriteWordIndex == 3'b010)
            DataCache[WriteBlockIndex][2*16 + 15: 2*16] = WriteValue;
        else if (WriteWordIndex == 3'b011)
            DataCache[WriteBlockIndex][3*16 + 15: 3*16] = WriteValue;
        else if (WriteWordIndex == 3'b10)
            DataCache[WriteBlockIndex][4*16 + 15: 4*16] = WriteValue;
        else if (WriteWordIndex == 3'b101)
            DataCache[WriteBlockIndex][5*16 + 15: 5*16] = WriteValue;
        else if (WriteWordIndex == 3'b110)
            DataCache[WriteBlockIndex][6*16 + 15: 6*16] = WriteValue;
        else if (WriteWordIndex == 3'b111)
            DataCache[WriteBlockIndex][7*16 + 15: 7*16] = WriteValue;
        // Set Dirty Bit
        DirtyBit[WriteBlockIndex] = 1'b1;
    end
    else if (WriteHit == 1'b0) begin // Miss
        $display("Write Miss");
        TempWriteAddress[14:4] = WriteBlockIndex;
        TempWriteAddress[3:1] = 3'b000;
        if (DirtyBit[WriteBlockIndex]) begin
            TempWriteAddress[16:15] = BlockTags[WriteBlockIndex];

            // i = 0;
            // while (i  8) begin
            //     MainMemory[TempWriteAddress + i][15:0] = DataCache[WriteBlockIndex][16*i + 15 : 16*i];
            //     i = i + 1;
            // end

            MainMemory[TempWriteAddress + 0][15:0] = DataCache[WriteBlockIndex][16*0 + 15 : 16*0];
            MainMemory[TempWriteAddress + 1][15:0] = DataCache[WriteBlockIndex][16*1 + 15 : 16*1];
            MainMemory[TempWriteAddress + 2][15:0] = DataCache[WriteBlockIndex][16*2 + 15 : 16*2];
            MainMemory[TempWriteAddress + 3][15:0] = DataCache[WriteBlockIndex][16*3 + 15 : 16*3];
            MainMemory[TempWriteAddress + 4][15:0] = DataCache[WriteBlockIndex][16*4 + 15 : 16*4];
            MainMemory[TempWriteAddress + 5][15:0] = DataCache[WriteBlockIndex][16*5 + 15 : 16*5];
            MainMemory[TempWriteAddress + 6][15:0] = DataCache[WriteBlockIndex][16*6 + 15 : 16*6];
            MainMemory[TempWriteAddress + 7][15:0] = DataCache[WriteBlockIndex][16*7 + 15 : 16*7];


            DirtyBit[WriteBlockIndex] = 1'b0;
        end
        
        TempWriteAddress[16:15] = WriteTag;

        // i = 0;
        // while (i  8) begin
        //     DataCache[WriteBlockIndex][16*i + 15 : 16*i] = MainMemory[TempWriteAddress + i][15:0];
        //     i = i + 1;
        // end

        DataCache[WriteBlockIndex][16*0 + 15 : 16*0] = MainMemory[TempWriteAddress + 0][15:0];
        DataCache[WriteBlockIndex][16*1 + 15 : 16*1] = MainMemory[TempWriteAddress + 1][15:0];
        DataCache[WriteBlockIndex][16*2 + 15 : 16*2] = MainMemory[TempWriteAddress + 2][15:0];
        DataCache[WriteBlockIndex][16*3 + 15 : 16*3] = MainMemory[TempWriteAddress + 3][15:0];
        DataCache[WriteBlockIndex][16*4 + 15 : 16*4] = MainMemory[TempWriteAddress + 4][15:0];
        DataCache[WriteBlockIndex][16*5 + 15 : 16*5] = MainMemory[TempWriteAddress + 5][15:0];
        DataCache[WriteBlockIndex][16*6 + 15 : 16*6] = MainMemory[TempWriteAddress + 6][15:0];
        DataCache[WriteBlockIndex][16*7 + 15 : 16*7] = MainMemory[TempWriteAddress + 7][15:0];

        if (WriteWordIndex == 3'b000)
            DataCache[WriteBlockIndex][0*16 + 15: 0*16] = WriteValue;
        else if (WriteWordIndex == 3'b001)
            DataCache[WriteBlockIndex][1*16 + 15: 1*16] = WriteValue;
        else if (WriteWordIndex == 3'b010)
            DataCache[WriteBlockIndex][2*16 + 15: 2*16] = WriteValue;
        else if (WriteWordIndex == 3'b011)
            DataCache[WriteBlockIndex][3*16 + 15: 3*16] = WriteValue;
        else if (WriteWordIndex == 3'b10)
            DataCache[WriteBlockIndex][4*16 + 15: 4*16] = WriteValue;
        else if (WriteWordIndex == 3'b101)
            DataCache[WriteBlockIndex][5*16 + 15: 5*16] = WriteValue;
        else if (WriteWordIndex == 3'b110)
            DataCache[WriteBlockIndex][6*16 + 15: 6*16] = WriteValue;
        else if (WriteWordIndex == 3'b111)
            DataCache[WriteBlockIndex][7*16 + 15: 7*16] = WriteValue;
        // Set Dirty Bit
        DirtyBit[WriteBlockIndex] = 1'b1;
    end
end

// Read Hit or Miss
always @(ReadHit) begin 
    if (ReadHit == 1'b1) begin // Hit
        $display("Read Hit");
        // Read
        if (ReadWordIndex == 3'b000)
            ReadValue = DataCache[ReadBlockIndex][0*16 + 15: 0*16];
        else if (ReadWordIndex == 3'b001)
            ReadValue = DataCache[ReadBlockIndex][1*16 + 15: 1*16];
        else if (ReadWordIndex == 3'b010)
            ReadValue = DataCache[ReadBlockIndex][2*16 + 15: 2*16];
        else if (ReadWordIndex == 3'b011)
            ReadValue = DataCache[ReadBlockIndex][3*16 + 15: 3*16];
        else if (ReadWordIndex == 3'b100)
            ReadValue = DataCache[ReadBlockIndex][4*16 + 15: 4*16];
        else if (ReadWordIndex == 3'b101)
            ReadValue = DataCache[ReadBlockIndex][5*16 + 15: 5*16];
        else if (ReadWordIndex == 3'b110)
            ReadValue = DataCache[ReadBlockIndex][6*16 + 15: 6*16];
        else if (ReadWordIndex == 3'b111)
            ReadValue = DataCache[ReadBlockIndex][7*16 + 15: 7*16];
    end
    else if (ReadHit == 1'b0) begin // Miss
        $display("Read Miss");

        TempReadAddress[14:4] = ReadBlockIndex;
        TempReadAddress[3:1] = 3'b000;

        // Write Back
        if (DirtyBit[ReadBlockIndex] == 1'b1) begin
            TempReadAddress[16:15] = BlockTags[ReadBlockIndex];

            MainMemory[TempReadAddress + 0][15:0] = DataCache[ReadBlockIndex][16*0 + 15 : 16*0];
            MainMemory[TempReadAddress + 1][15:0] = DataCache[ReadBlockIndex][16*1 + 15 : 16*1];
            MainMemory[TempReadAddress + 2][15:0] = DataCache[ReadBlockIndex][16*2 + 15 : 16*2];
            MainMemory[TempReadAddress + 3][15:0] = DataCache[ReadBlockIndex][16*3 + 15 : 16*3];
            MainMemory[TempReadAddress + 4][15:0] = DataCache[ReadBlockIndex][16*4 + 15 : 16*4];
            MainMemory[TempReadAddress + 5][15:0] = DataCache[ReadBlockIndex][16*5 + 15 : 16*5];
            MainMemory[TempReadAddress + 6][15:0] = DataCache[ReadBlockIndex][16*6 + 15 : 16*6];
            MainMemory[TempReadAddress + 7][15:0] = DataCache[ReadBlockIndex][16*7 + 15 : 16*7];
        end

        // Replace Block 
        TempReadAddress[16:15] = ReadTag;
        DataCache[ReadBlockIndex][16*0 + 15 : 16*0] = MainMemory[TempReadAddress + 0][15:0];
        DataCache[ReadBlockIndex][16*1 + 15 : 16*1] = MainMemory[TempReadAddress + 1][15:0];
        DataCache[ReadBlockIndex][16*2 + 15 : 16*2] = MainMemory[TempReadAddress + 2][15:0];
        DataCache[ReadBlockIndex][16*3 + 15 : 16*3] = MainMemory[TempReadAddress + 3][15:0];
        DataCache[ReadBlockIndex][16*4 + 15 : 16*4] = MainMemory[TempReadAddress + 4][15:0];
        DataCache[ReadBlockIndex][16*5 + 15 : 16*5] = MainMemory[TempReadAddress + 5][15:0];
        DataCache[ReadBlockIndex][16*6 + 15 : 16*6] = MainMemory[TempReadAddress + 6][15:0];
        DataCache[ReadBlockIndex][16*7 + 15 : 16*7] = MainMemory[TempReadAddress + 7][15:0];
        BlockTags[ReadBlockIndex] = ReadTag;
        ValidityBit[ReadBlockIndex] = 1'b1;
        DirtyBit[ReadBlockIndex] = 1'b0;

        // Then Read
        if (ReadWordIndex == 3'b000)
            ReadValue = DataCache[ReadBlockIndex][0*16 + 15: 0*16];
        else if (ReadWordIndex == 3'b001)
            ReadValue = DataCache[ReadBlockIndex][1*16 + 15: 1*16];
        else if (ReadWordIndex == 3'b010)
            ReadValue = DataCache[ReadBlockIndex][2*16 + 15: 2*16];
        else if (ReadWordIndex == 3'b011)
            ReadValue = DataCache[ReadBlockIndex][3*16 + 15: 3*16];
        else if (ReadWordIndex == 3'b100)
            ReadValue = DataCache[ReadBlockIndex][4*16 + 15: 4*16];
        else if (ReadWordIndex == 3'b101)
            ReadValue = DataCache[ReadBlockIndex][5*16 + 15: 5*16];
        else if (ReadWordIndex == 3'b110)
            ReadValue = DataCache[ReadBlockIndex][6*16 + 15: 6*16];
        else if (ReadWordIndex == 3'b111)
            ReadValue = DataCache[ReadBlockIndex][7*16 + 15: 7*16];
    end
end

endmodule