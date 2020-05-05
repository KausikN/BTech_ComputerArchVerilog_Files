`include "WallaceMultiplier_8Bit.v"
`include "8BitAdder.v"
`include "DFF_16Bit.v"
`include "DFF_36Bit.v"
`include "DFF.v"

module Bit16Multiplier_Pipelined(clk, A, B, out, reset);
    
    input clk, reset;
    input [16:1] A,B;
    output [36:1] out;

    wire [16:1] wll, wlh, whl, whh;
    wire [16:1] ll_1, lh_1, hl_1, hh_1;
    wire [16:1] ll_2,  lh_2, hl_2, hh_2;
    wire [16:1] ll_3, lh_3, hl_3, hh_3;

    wire w1, w2, w3, w4, w5, w6;
    wire c1_1, c1_2, c2_1, c2_2;
    wire [8:1] tempout1, tempout2, tempout3;
    wire [36:1] out_0, out_1, out_2;

    WallaceMultiplier wm_ll(A[8:1], B[8:1], wll);
    WallaceMultiplier wm_lh(A[8:1], B[16:9], wlh);
    WallaceMultiplier wm_hl(A[16:9], B[8:1], whl);
    WallaceMultiplier wm_hh(A[16:9], B[16:9], whh);

    assign out_0[8:1] = ll_1[8:1];
    assign out_0[36:33] = 4'b0000;

    // Layer 1
    DFF_16Bit ff_ll_1(clk, wll, ll_1, reset);
    DFF_16Bit ff_lh_1(clk, wlh, lh_1, reset);
    DFF_16Bit ff_hl_1(clk, whl, hl_1, reset);
    DFF_16Bit ff_hh_1(clk, whh, hh_1, reset);
    DFF_36Bit ff_out_1(clk, out_0, out_1, reset);

    Bit8Adder B8A1 (wll[16:9], wlh[8:1], 1'b0, tempout1, w1);
    Bit8Adder B8A2 (tempout1, whl[8:1], 1'b0, out_1[16:9], w2);

    DFF ff_c1_1(clk, w1, c1_1, reset);
    DFF ff_c2_1(clk, w2, c2_1, reset);

    // Layer 2
    DFF_16Bit ff_ll_2(clk, ll_1, ll_2, reset);
    DFF_16Bit ff_lh_2(clk, lh_1, lh_2, reset);
    DFF_16Bit ff_hl_2(clk, hl_1, hl_2, reset);
    DFF_16Bit ff_hh_2(clk, hh_1, hh_2, reset);
    DFF_36Bit ff_out_2(clk, out_1, out_2, reset);

    Bit8Adder B8A3 (lh_2[16:9], hl_2[16:9], c1_1, tempout2, w3);
    Bit8Adder B8A4 (tempout2, hh_2[8:1], c2_1, out_2[24:17], w4);

    DFF ff_c1_2(clk, w3, c1_2, reset);
    DFF ff_c2_2(clk, w4, c2_2, reset);

    // Layer 3
    DFF_16Bit ff_ll_3(clk, ll_2, ll_3, reset);
    DFF_16Bit ff_lh_3(clk, lh_2, lh_3, reset);
    DFF_16Bit ff_hl_3(clk, hl_2, hl_3, reset);
    DFF_16Bit ff_hh_3(clk, hh_2, hh_3, reset);
    DFF_36Bit ff_out_3(clk, out_2, out, reset);

    Bit8Adder B8A5 (hh_3[16:9], 8'b00000000, c1_2, tempout3, w5);
    Bit8Adder B8A6 (tempout3, 8'b00000000, c2_2, out[32:25], w6);

    // assign out_0[8:1] = ll_1[8:1];
    // assign out[16:9]
    // assign out[24:17]
    // assign out[32:25]
    // assign out_0[36:33] = 4'b0000;


/*
always@(*)
begin
    $display(": Intermediate: A: %b (%d), B: %b (%d), out: %b (%d)", A, A, B, B, out, out);
    $display(": Intermediate Binary: (w1:%b | w2:%b) wll = %b (%d), wlh = %b (%d), whl = %b (%d), whh = %b (%d)", w1, w2, wll, wll, wlh, wlh, whl, whl, whh, whh);
end
*/
endmodule