module DFF_10Bit(clk, d, q, reset);
input [10:1] d;
input clk, reset;
output reg [10:1] q;

initial begin
	q <= 10'b0000000000;
end

always@(posedge clk or negedge reset)
	if(reset)
 		q <= 10'b0000000000;
	else
		q <= d;

endmodule
