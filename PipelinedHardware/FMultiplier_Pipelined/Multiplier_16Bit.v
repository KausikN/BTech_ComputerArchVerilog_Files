`include "WallaceMultiplier_8Bit.v"
`include "8BitAdder.v"

module Multiplier_16Bit(A, B, out);
    
    input [16:1] A, B;
    output [36:1] out;

    reg zero = 1'b0;
    // initial 
    //     zero = 1'b0;

    wire[16:1] wll, wlh, whl, whh;

    WallaceMultiplier wm_ll(A[8:1], B[8:1], wll);
    WallaceMultiplier wm_lh(A[8:1], B[16:9], wlh);
    WallaceMultiplier wm_hl(A[16:9], B[8:1], whl);
    WallaceMultiplier wm_hh(A[16:9], B[16:9], whh);

    assign out[8:1] = wll[8:1];
    assign out[36:33] = 4'b0000;

    wire w1, w2, w3, w4, w5, w6;
    wire [8:1] tempout1, tempout2, tempout3;
    Bit8Adder B8A1 (wll[16:9], wlh[8:1], zero, tempout1, w1);
    Bit8Adder B8A2 (tempout1, whl[8:1], zero, out[16:9], w2);

    Bit8Adder B8A3 (wlh[16:9], whl[16:9], w1, tempout2, w3);
    Bit8Adder B8A4 (tempout2, whh[8:1], w2, out[24:17], w4);

    Bit8Adder B8A5 (whh[16:9], 8'b00000000, w3, tempout3, w5);
    Bit8Adder B8A6 (tempout3, 8'b00000000, w4, out[32:25], w6);

/*
always@(*)
begin
    $display(": Intermediate: A: %b (%d), B: %b (%d), out: %b (%d)", A, A, B, B, out, out);
    $display(": Intermediate Binary: (w1:%b | w2:%b) wll = %b (%d), wlh = %b (%d), whl = %b (%d), whh = %b (%d)", w1, w2, wll, wll, wlh, wlh, whl, whl, whh, whh);
end
*/
endmodule