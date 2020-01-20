`include "ExpSubtractor.v"

module test;

reg [5:1] a, b;
wire sm;
wire [5:1] diff;

ExpSubtractor exp (a, b, diff, sm);

initial begin
    $monitor($time, ": a = %b (%d), b = %b (%d), diff = %b (%d), sm = %b", a, a, b, b, diff, diff, sm);
end

initial begin
    a = 5'b00011; b = 5'b01001;
end

endmodule