/*
Operations
000 - AND
001 - OR
010 - NOT
011 - XOR
100 - NAND
101 - NOR
110 - XNOR
111 - 2s Complement
*/

`include "LogicalOps.v"

module test;

reg [3:1] Operation;
reg [16:1] A, B;

wire [16:1] out;

LogicalOps log (A, B, Operation, out);

initial begin
    $monitor($time, ": A: %b (%d), B: %b (%d), Operation: %b (%d), out: %b (%d)", 
    A, A, B, B, Operation, Operation, out, out
    );
end

initial begin
    Operation = 3'b111;
    A = 16'b1111111111111111; 
    B = 16'b0010010010010101;
end

endmodule