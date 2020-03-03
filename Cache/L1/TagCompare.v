
module TagCompare (
    Tag1, Tag2, 
    CompVal
);

input [2:1] Tag1;
input [2:1] Tag2;

output CompVal;

assign CompVal = !(Tag1[1] ^ Tag2[1]) & !(Tag1[2] ^ Tag2[2]);



endmodule