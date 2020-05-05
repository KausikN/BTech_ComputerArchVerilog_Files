module DFF_36Bit(clk, d, q, reset);
input [36:1] d;
input clk, reset;
output reg [36:1] q;

initial begin
	q <= 36'b000000000000000000000000000000000000;
end

always@(posedge clk or negedge reset)
	if(reset)
 		q <= 36'b000000000000000000000000000000000000;
	else
		q <= d;

endmodule
