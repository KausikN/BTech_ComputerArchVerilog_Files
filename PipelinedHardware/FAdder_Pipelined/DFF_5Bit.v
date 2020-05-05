module DFF_5Bit(clk, d, q, reset);
input [5:1] d;
input clk, reset;
output reg [5:1] q;

initial begin
	q <= 5'b00000;
end

always@(posedge clk or negedge reset)
	if(reset)
 		q <= 5'b00000;
	else
		q <= d;

endmodule
