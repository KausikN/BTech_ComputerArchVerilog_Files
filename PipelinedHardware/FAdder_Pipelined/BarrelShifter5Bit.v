`include "ShiftLeftOnce_11Bit.v"
`include "ShiftRightOnce_11Bit.v"

module BarrelShifterLeft (a, shift, b);

input [11:1] a;
input [5:1] shift;
output [11:1] b;

wire [11:1] o1, o2, o3, o4;
wire [11:1] w1, w21, w22, w31, w32, w33, w34, w41, w42, w43, w44, w45, w46, w47, w48;

// Bit 1
ShiftLeftOnce_11Bit s_1 (a, w1);
assign o1 = (shift[1]) ? w1 : a;

// Bit 2
ShiftLeftOnce_11Bit s_21 (o1, w21);
ShiftLeftOnce_11Bit s_22 (w21, w22);
assign o2 = (shift[2]) ? w22 : o1;

// Bit 3
ShiftLeftOnce_11Bit s_31 (o2, w31);
ShiftLeftOnce_11Bit s_32 (w31, w32);
ShiftLeftOnce_11Bit s_33 (w32, w33);
ShiftLeftOnce_11Bit s_34 (w33, w34);
assign o3 = (shift[3]) ? w34 : o2;

// Bit 4
ShiftLeftOnce_11Bit s_41 (o3, w41);
ShiftLeftOnce_11Bit s_42 (w41, w42);
ShiftLeftOnce_11Bit s_43 (w42, w43);
ShiftLeftOnce_11Bit s_44 (w43, w44);
ShiftLeftOnce_11Bit s_45 (w44, w45);
ShiftLeftOnce_11Bit s_46 (w45, w46);
ShiftLeftOnce_11Bit s_47 (w46, w47);
ShiftLeftOnce_11Bit s_48 (w47, w48);
assign o4 = (shift[4]) ? w48 : o3;

// If Bit 5 is 1, as a is only 11 bits, output is 0 - all right shifted
assign b = (shift[5]) ? 11'b00000000000 : o4;

endmodule

module BarrelShifterRight (a, shift, b);

input [11:1] a;
input [5:1] shift;
output [11:1] b;

wire [11:1] o1, o2, o3, o4;
wire [11:1] w1, w21, w22, w31, w32, w33, w34, w41, w42, w43, w44, w45, w46, w47, w48;

// Bit 1
ShiftRightOnce_11Bit s_1 (a, w1);
assign o1 = (shift[1]) ? w1 : a;

// Bit 2
ShiftRightOnce_11Bit s_21 (o1, w21);
ShiftRightOnce_11Bit s_22 (w21, w22);
assign o2 = (shift[2]) ? w22 : o1;

// Bit 3
ShiftRightOnce_11Bit s_31 (o2, w31);
ShiftRightOnce_11Bit s_32 (w31, w32);
ShiftRightOnce_11Bit s_33 (w32, w33);
ShiftRightOnce_11Bit s_34 (w33, w34);
assign o3 = (shift[3]) ? w34 : o2;

// Bit 4
ShiftRightOnce_11Bit s_41 (o3, w41);
ShiftRightOnce_11Bit s_42 (w41, w42);
ShiftRightOnce_11Bit s_43 (w42, w43);
ShiftRightOnce_11Bit s_44 (w43, w44);
ShiftRightOnce_11Bit s_45 (w44, w45);
ShiftRightOnce_11Bit s_46 (w45, w46);
ShiftRightOnce_11Bit s_47 (w46, w47);
ShiftRightOnce_11Bit s_48 (w47, w48);
assign o4 = (shift[4]) ? w48 : o3;

// If Bit 5 is 1, as a is only 11 bits, output is 0 - all right shifted
assign b = (shift[5]) ? 11'b00000000000 : o4;

endmodule