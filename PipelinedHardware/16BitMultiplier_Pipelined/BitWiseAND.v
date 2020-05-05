
module BitWiseAND(A, B, p);
    
    input [8:1] A;
    input B;

    output [8:1] p;

    assign p[1] = A[1] & B;
    assign p[2] = A[2] & B;
    assign p[3] = A[3] & B;
    assign p[4] = A[4] & B;
    assign p[5] = A[5] & B;
    assign p[6] = A[6] & B;
    assign p[7] = A[7] & B;
    assign p[8] = A[8] & B;

endmodule