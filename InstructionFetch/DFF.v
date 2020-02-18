module DFF(clk, d, reset, q);
input d, clk, reset;
output reg q;

initial begin
	q <= 1'b0;
end

always@(posedge clk or negedge reset)
	if(reset)
 		q <= 1'b0;
	else
		q <= d;

endmodule
