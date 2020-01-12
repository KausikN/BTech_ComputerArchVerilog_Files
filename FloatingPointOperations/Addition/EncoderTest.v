`include "Encoder11Bit_to_5Bit.v"

module test;

reg [11:1] a;
wire [5:1] b;

Encoder11Bit_to_5Bit enc (a, b);

initial begin
    $monitor($time, ": a = %b (%d), b = %b (%d)", a, a, b, b);
end

initial begin
    a = 11'b00000010000;
end

endmodule