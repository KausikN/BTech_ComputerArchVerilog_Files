`include "DFF.v"
`include "DFF_16Bit.v"
`include "4BitAdder.v"

module Bit16Adder_Pipelined (clk, a, b, cin, sum, cout, reset);
input clk, reset;
input[16:1] a, b;
input cin;
output[16:1] sum;
output cout;

    wire w1, w2, w3, w4;
    wire [16:1] sum1, sum2, sum3, sum4;
    wire carry1, carry2, carry3;
    wire [16:1] a1, a2, a3, a4, b1, b2, b3, b4;

    // Layer 1
    DFF_16Bit ff_a_1(clk, a, a1, reset);
    DFF_16Bit ff_b_1(clk, b, b1, reset);

    Bit4Adder B4A_1(a1[4:1], b1[4:1], cin, sum1[4:1], w1);

    DFF_16Bit ff_s_1(clk, sum1, sum2, reset);
    DFF ff_c_1(clk, w1, carry1, reset);

    // Layer 2
    DFF_16Bit ff_a_2(clk, a1, a2, reset);
    DFF_16Bit ff_b_2(clk, b1, b2, reset);

    Bit4Adder B4A_2(a2[8:5], b2[8:5], carry1, sum2[8:5], w2);

    DFF_16Bit ff_s_2(clk, sum2, sum3, reset);
    DFF ff_c_2(clk, w2, carry2, reset);

    // Layer 3
    DFF_16Bit ff_a_3(clk, a2, a3, reset);
    DFF_16Bit ff_b_3(clk, b2, b3, reset);

    Bit4Adder B4A_3(a3[12:9], b3[12:9], carry2, sum3[12:9], w3);

    DFF_16Bit ff_s_3(clk, sum3, sum4, reset);
    DFF ff_c_3(clk, w3, carry3, reset);

    // Layer 4
    DFF_16Bit ff_a_4(clk, a3, a4, reset);
    DFF_16Bit ff_b_4(clk, b3, b4, reset);

    Bit4Adder B4A_4(a4[16:13], b4[16:13], carry3, sum4[16:13], w4);

    DFF_16Bit ff_s_4(clk, sum4, sum, reset);
    DFF ff_c_4(clk, w4, cout, reset);

endmodule
