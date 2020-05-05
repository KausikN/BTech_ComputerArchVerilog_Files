`include "Multiplier16Bit_Pipelined.v"

module test;

reg clk, reset;
reg [16:1] a, b;
wire [36:1] out;


Bit16Multiplier_Pipelined mul_pipe (
    clk, a, b, out, reset
    );

initial begin
    $monitor($time, ":\nInput to pipe: a = %b (%d), b = %b (%d)\nOutput from pipe: prod = %b (%d)\nRESET: %b", 
    a, a, b, b, out, out, reset
    );
end

initial begin
    reset = 1'b0;
    clk = 1'b0;
    a = 16'd1; b = 16'd2;
    #10 a = 16'd2; b = 16'd3;
    #10 a = 16'd3; b = 16'd4;
    #10 a = 16'd4; b = 16'd5;
    #10 a = 16'd5; b = 16'd6;
    #2000 $finish;
end

always #5 clk = !clk;

endmodule