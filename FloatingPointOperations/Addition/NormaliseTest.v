`include "NormaliseShift.v"

module test;

reg [11:1] a;
wire [5:1] b;

NormaliseShift ns (a, b);

initial begin
    $monitor($time, ": a = %b (%d), b = %b (%d)", a, a, b, b);
end

initial begin
    a = 11'b00000000001;
end

endmodule