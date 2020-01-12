`include "BarrelShifter5Bit.v"

module test;

reg [11:1] a;
reg [5:1] shift;
wire [11:1] b;

BarrelShifterRight sh (a, shift, b);

initial begin
    $monitor($time, ": a = %b (%d), shift = %b (%d), b = %b (%d)", a, a, shift, shift, b, b);
end

initial begin
    a = 11'b01010110001; shift = 5'b00101;
end

endmodule