/*
L1 - Separate Ins Data Cache	 (16 Bit)
	- With Valid and Dirty Bit
	Block Size = 8 Words
	Word Size
	- Data => Dual Port Memory - Read and Write in same cc - 32K or 64K
	- Ins => Single Port Memory - 8K or 16K
*/

`include "InstructionRegister_L1.v"
`include "Data_L1.v"

// Format : L1Cache_(Data Cache Size - 64K)_(Ins Cache Size - 16K)_(Block Size - 8 Words)_(Word Size - 16Bits)
module L1Cache_64K_16K_8_16 (

);

// Instruction Cache - 8 16Bit Words in 1 Block, 16K, 128 Blocks 
InstructionRegister_L1 ins (
    mode,  
    ReadAddress1, ReadValue1,
    reset
    );

// Data Cache - 8 16Bit Words in 1 Block, 64K, 512 Blocks 
Data_L1 data (
    mode, 
    WriteAddress, WriteValue, 
    ReadAddress1, ReadValue1, 
    reset
    );

endmodule