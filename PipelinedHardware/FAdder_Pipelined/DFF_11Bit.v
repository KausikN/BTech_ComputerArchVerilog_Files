module DFF_11Bit(clk, d, q, reset);
input [11:1] d;
input clk, reset;
output reg [11:1] q;

initial begin
	q <= 11'b00000000000;
end

always@(posedge clk or negedge reset)
	if(reset)
 		q <= 11'b00000000000;
	else
		q <= d;

endmodule
