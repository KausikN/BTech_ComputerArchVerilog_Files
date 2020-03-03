`include "Data_L1.v"

module test;

reg [16:1] WriteAddress_Full;
reg [16:1] WriteValue;
reg [16:1] ReadAddress_Full;
wire [16:1] ReadValue;
wire WriteHit, ReadHit;
reg write;
reg read;
reg clk;

Data_L1 datacache (WriteAddress_Full, WriteValue, 
    ReadAddress_Full, ReadValue, 
    WriteHit, ReadHit, 
    clk, write, read);

initial begin
    $monitor($time, ": WriteAdd = %b (%d), WriteVal = %b (%d) : WHit -  %b \n\t\t\t\t\tReadAdd = %b (%d), ReadVal = %b (%d) : RHit -  %b", 
    WriteAddress_Full, WriteAddress_Full,
    WriteValue, WriteValue,
    WriteHit,  
    ReadAddress_Full, ReadAddress_Full, 
    ReadValue, ReadValue, 
    ReadHit);
end

initial begin
    clk = 1'b0;
    write = 1'b1;
    read = 1'b1;
    WriteAddress_Full = 16'd0;
    WriteValue = 16'd23;
    ReadAddress_Full = 16'd0;

    #100 WriteAddress_Full = 16'd0; WriteValue = 16'd31; ReadAddress_Full = 16'd0;
    #100 WriteAddress_Full = 16'd1; WriteValue = 16'd42; ReadAddress_Full = 16'd0;
    #100 WriteAddress_Full = 16'd2; WriteValue = 16'd51; ReadAddress_Full = 16'd1;
    #100 WriteAddress_Full = 16'd3; WriteValue = 16'd62; ReadAddress_Full = 16'd2;
    #1000 $finish;
end

always #100 clk = !clk; 

endmodule