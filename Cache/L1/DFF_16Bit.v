module DFF_16Bit(clk, d, q, reset);
input [16:1] d;
input clk, reset;
output reg [16:1] q;

initial begin
	q <= 16'b0000000000000000;
end

always@(posedge clk or negedge reset)
	if(reset)
 		q <= 16'b0000000000000000;
	else
		q <= d;

endmodule
