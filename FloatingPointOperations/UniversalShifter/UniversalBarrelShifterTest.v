`include "UniversalBarrelShifter.v"

module test;

reg ShiftChoice;
reg [4:1] Shift;
reg [16:1] A;

wire [16:1] out;

UniversalBarrelShifter ubs (A, Shift, ShiftChoice, out);

initial begin
    $monitor($time, ": A: %b (%d), Shift: %b (%d), out: %b (%d)", 
    A, A, Shift, Shift, out, out
    );
end

initial begin
    ShiftChoice = 1'b0;
    Shift = 4'b0011;
    A = 16'b1011001001010010; 
end

endmodule