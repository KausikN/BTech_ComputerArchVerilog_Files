`include "Complement2s_5Bit.v"

module test;

reg [5:1] a;
wire [5:1] b;

Complement2s_5Bit comp (a, b);

initial begin
    $monitor($time, ": a = %b (%d), b = %b (%d)", a, a, b, b,);
end

initial begin
    a = 5'b00010;
end

endmodule