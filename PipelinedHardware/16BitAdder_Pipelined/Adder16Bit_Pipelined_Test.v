`include "Adder16Bit_Pipelined.v"

module test;

reg clk, reset;
reg [16:1] a, b;
reg cin;
wire [16:1] sum;
wire cout;


Bit16Adder_Pipelined addr_pipe (
    clk, a, b, cin, sum, cout, reset
    );

initial begin
    $monitor($time, ":\nInput to pipe: a = %b (%d), b = %b (%d), cin = %b\nOutput from pipe: sum = %b (%d), cout = %b\nRESET: %b", 
    a, a, b, b, cin, sum, sum, cout, reset
    );
end

initial begin
    reset = 1'b0;
    clk = 1'b0;
    a = 16'd1; b = 16'd2; cin = 1'b0;
    #10 a = 16'd2; b = 16'd3; cin = 1'b0;
    #10 a = 16'd3; b = 16'd4; cin = 1'b0;
    #10 a = 16'd4; b = 16'd5; cin = 1'b0;
    #10 a = 16'd5; b = 16'd6; cin = 1'b0;
    #2000 $finish;
end

always #5 clk = !clk;

endmodule