`include "Data_L1.v"

module test;

reg [16:1] WriteAddress_Full;
reg [16:1] WriteValue;
reg [16:1] ReadAddress_Full;
wire [16:1] ReadValue;
wire WriteHit, ReadHit;
reg reset;

Data_L1 datacache (WriteAddress_Full, WriteValue, 
    ReadAddress_Full, ReadValue, 
    WriteHit, ReadHit, 
    reset);

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
    reset = 1'b0;
    WriteAddress_Full = 16'd0;
    WriteValue = 16'd23;
    ReadAddress_Full = 16'd0;

    #10 WriteAddress_Full = 16'd0; WriteValue = 16'd31;
    #10 WriteAddress_Full = 16'd0; WriteValue = 16'd42;
end

endmodule