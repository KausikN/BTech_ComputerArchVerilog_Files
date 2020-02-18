module PCAdder (
		a, b, 
		sum
	);

	input [16:1] a,b;
	
	output wire [16:1] sum;
	wire cout;

	wire [1:0] pgk [16:1];
	
	wire [1:0] temp_1 [16:1];
	wire [1:0] temp_2 [16:1];
	wire [1:0] temp_3 [16:1];
	wire [1:0] temp_4 [16:1];

	wire [16:1] gk;
	

//pgk -- 00-kill && 11-generate && 10-propagate

	
//PGK Generating
assign pgk[1][0]=(a[1]&b[1]) | (b[1]&1'b0) | (1'b0&a[1]);
assign pgk[1][1]=(a[1]&b[1]) | (b[1]&1'b0) | (1'b0&a[1]);

assign pgk[2][0]=a[2]&b[2]; 
assign pgk[2][1]=a[2]|b[2];

assign pgk[3][0]=a[3]&b[3]; 
assign pgk[3][1]=a[3]|b[3];

assign pgk[4][0]=a[4]&b[4]; 
assign pgk[4][1]=a[4]|b[4];

assign pgk[5][0]=a[5]&b[5]; 
assign pgk[5][1]=a[5]|b[5];

assign pgk[6][0]=a[6]&b[6]; 
assign pgk[6][1]=a[6]|b[6];

assign pgk[7][0]=a[7]&b[7]; 
assign pgk[7][1]=a[7]|b[7];

assign pgk[8][0]=a[8]&b[8]; 
assign pgk[8][1]=a[8]|b[8];

assign pgk[9][0]=a[9]&b[9]; 
assign pgk[9][1]=a[9]|b[9];

assign pgk[10][0]=a[10]&b[10]; 
assign pgk[10][1]=a[10]|b[10];

assign pgk[11][0]=a[11]&b[11]; 
assign pgk[11][1]=a[11]|b[11];

assign pgk[12][0]=a[12]&b[12]; 
assign pgk[12][1]=a[12]|b[12];

assign pgk[13][0]=a[13]&b[13]; 
assign pgk[13][1]=a[13]|b[13];

assign pgk[14][0]=a[14]&b[14]; 
assign pgk[14][1]=a[14]|b[14];

assign pgk[15][0]=a[15]&b[15]; 
assign pgk[15][1]=a[15]|b[15];

assign pgk[16][0]=a[16]&b[16]; 
assign pgk[16][1]=a[16]|b[16];


//PGK Redu1'b0g
// 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
// 1 - 16.15  15.14  14.13  13.12  12.11  11.10  10.9  9.8  8.7  7.6  6.5  5.4  4.3  3.2  2.1  1
// 2 - 16.14  15.13  14.12  13.11  12.10  11.9  10.8  9.7  8.6  7.5  6.4  5.3  4.2  3.1  2  1
// 4 - 16.12  15.11  14.10  13.9  12.8  11.7  10.6  9.5  8.4  7.3  6.2  5.1  4  3  2  1
// 8 - 16.8  15.7  14.6  13.5  12.4  11.3  10.2  9.1  8  7  6  5  4  3  2  1
// 16- NIL

// 1 - 16.15  15.14  14.13  13.12  12.11  11.10  10.9  9.8  8.7  7.6  6.5  5.4  4.3  3.2  2.1  1
assign temp_1[1][0]=pgk[1][0];
assign temp_1[1][1]=pgk[1][1];

assign temp_1[2][0]=(pgk[2][0])|(pgk[2][1]&pgk[1][0]);
assign temp_1[2][1]=(pgk[2][0])|(pgk[2][1]&pgk[1][1]);

assign temp_1[3][0]=(pgk[3][0])|(pgk[3][1]&pgk[2][0]);
assign temp_1[3][1]=(pgk[3][0])|(pgk[3][1]&pgk[2][1]);

assign temp_1[4][0]=(pgk[4][0])|(pgk[4][1]&pgk[3][0]);
assign temp_1[4][1]=(pgk[4][0])|(pgk[4][1]&pgk[3][1]);

assign temp_1[5][0]=(pgk[5][0])|(pgk[5][1]&pgk[4][0]);
assign temp_1[5][1]=(pgk[5][0])|(pgk[5][1]&pgk[4][1]);

assign temp_1[6][0]=(pgk[6][0])|(pgk[6][1]&pgk[5][0]);
assign temp_1[6][1]=(pgk[6][0])|(pgk[6][1]&pgk[5][1]);

assign temp_1[7][0]=(pgk[7][0])|(pgk[7][1]&pgk[6][0]);
assign temp_1[7][1]=(pgk[7][0])|(pgk[7][1]&pgk[6][1]);

assign temp_1[8][0]=(pgk[8][0])|(pgk[8][1]&pgk[7][0]);
assign temp_1[8][1]=(pgk[8][0])|(pgk[8][1]&pgk[7][1]);

assign temp_1[9][0]=(pgk[9][0])|(pgk[9][1]&pgk[8][0]);
assign temp_1[9][1]=(pgk[9][0])|(pgk[9][1]&pgk[8][1]);

assign temp_1[10][0]=(pgk[10][0])|(pgk[10][1]&pgk[9][0]);
assign temp_1[10][1]=(pgk[10][0])|(pgk[10][1]&pgk[9][1]);

assign temp_1[11][0]=(pgk[11][0])|(pgk[11][1]&pgk[10][0]);
assign temp_1[11][1]=(pgk[11][0])|(pgk[11][1]&pgk[10][1]);

assign temp_1[12][0]=(pgk[12][0])|(pgk[12][1]&pgk[11][0]);
assign temp_1[12][1]=(pgk[12][0])|(pgk[12][1]&pgk[11][1]);

assign temp_1[13][0]=(pgk[13][0])|(pgk[13][1]&pgk[12][0]);
assign temp_1[13][1]=(pgk[13][0])|(pgk[13][1]&pgk[12][1]);

assign temp_1[14][0]=(pgk[14][0])|(pgk[14][1]&pgk[13][0]);
assign temp_1[14][1]=(pgk[14][0])|(pgk[14][1]&pgk[13][1]);

assign temp_1[15][0]=(pgk[15][0])|(pgk[15][1]&pgk[14][0]);
assign temp_1[15][1]=(pgk[15][0])|(pgk[15][1]&pgk[14][1]);

assign temp_1[16][0]=(pgk[16][0])|(pgk[16][1]&pgk[15][0]);
assign temp_1[16][1]=(pgk[16][0])|(pgk[16][1]&pgk[15][1]);




// 2 - 16.14  15.13  14.12  13.11  12.10  11.9  10.8  9.7  8.6  7.5  6.4  5.3  4.2  3.1  2  1
assign temp_2[1][0]=temp_1[1][0];
assign temp_2[1][1]=temp_1[1][1];

assign temp_2[2][0]=temp_1[2][0];
assign temp_2[2][1]=temp_1[2][1];

assign temp_2[3][0]=(temp_1[3][0])|(temp_1[3][1]&temp_1[1][0]);
assign temp_2[3][1]=(temp_1[3][0])|(temp_1[3][1]&temp_1[1][1]);

assign temp_2[4][0]=(temp_1[4][0])|(temp_1[4][1]&temp_1[2][0]);
assign temp_2[4][1]=(temp_1[4][0])|(temp_1[4][1]&temp_1[2][1]);

assign temp_2[5][0]=(temp_1[5][0])|(temp_1[5][1]&temp_1[3][0]);
assign temp_2[5][1]=(temp_1[5][0])|(temp_1[5][1]&temp_1[3][1]);

assign temp_2[6][0]=(temp_1[6][0])|(temp_1[6][1]&temp_1[4][0]);
assign temp_2[6][1]=(temp_1[6][0])|(temp_1[6][1]&temp_1[4][1]);

assign temp_2[7][0]=(temp_1[7][0])|(temp_1[7][1]&temp_1[5][0]);
assign temp_2[7][1]=(temp_1[7][0])|(temp_1[7][1]&temp_1[5][1]);

assign temp_2[8][0]=(temp_1[8][0])|(temp_1[8][1]&temp_1[6][0]);
assign temp_2[8][1]=(temp_1[8][0])|(temp_1[8][1]&temp_1[6][1]);

assign temp_2[9][0]=(temp_1[9][0])|(temp_1[9][1]&temp_1[7][0]);
assign temp_2[9][1]=(temp_1[9][0])|(temp_1[9][1]&temp_1[7][1]);

assign temp_2[10][0]=(temp_1[10][0])|(temp_1[10][1]&temp_1[8][0]);
assign temp_2[10][1]=(temp_1[10][0])|(temp_1[10][1]&temp_1[8][1]);

assign temp_2[11][0]=(temp_1[11][0])|(temp_1[11][1]&temp_1[9][0]);
assign temp_2[11][1]=(temp_1[11][0])|(temp_1[11][1]&temp_1[9][1]);

assign temp_2[12][0]=(temp_1[12][0])|(temp_1[12][1]&temp_1[10][0]);
assign temp_2[12][1]=(temp_1[12][0])|(temp_1[12][1]&temp_1[10][1]);

assign temp_2[13][0]=(temp_1[13][0])|(temp_1[13][1]&temp_1[11][0]);
assign temp_2[13][1]=(temp_1[13][0])|(temp_1[13][1]&temp_1[11][1]);

assign temp_2[14][0]=(temp_1[14][0])|(temp_1[14][1]&temp_1[12][0]);
assign temp_2[14][1]=(temp_1[14][0])|(temp_1[14][1]&temp_1[12][1]);

assign temp_2[15][0]=(temp_1[15][0])|(temp_1[15][1]&temp_1[13][0]);
assign temp_2[15][1]=(temp_1[15][0])|(temp_1[15][1]&temp_1[13][1]);

assign temp_2[16][0]=(temp_1[16][0])|(temp_1[16][1]&temp_1[14][0]);
assign temp_2[16][1]=(temp_1[16][0])|(temp_1[16][1]&temp_1[14][1]);




// 4 - 16.12  15.11  14.10  13.9  12.8  11.7  10.6  9.5  8.4  7.3  6.2  5.1  4  3  2  1
assign temp_3[1][0]=temp_2[1][0];
assign temp_3[1][1]=temp_2[1][1];

assign temp_3[2][0]=temp_2[2][0];
assign temp_3[2][1]=temp_2[2][1];

assign temp_3[3][0]=temp_2[3][0];
assign temp_3[3][1]=temp_2[3][1];

assign temp_3[4][0]=temp_2[4][0];
assign temp_3[4][1]=temp_2[4][1];

assign temp_3[5][0]=(temp_2[5][0])|(temp_2[5][1]&temp_2[1][0]);
assign temp_3[5][1]=(temp_2[5][0])|(temp_2[5][1]&temp_2[1][1]);

assign temp_3[6][0]=(temp_2[6][0])|(temp_2[6][1]&temp_2[2][0]);
assign temp_3[6][1]=(temp_2[6][0])|(temp_2[6][1]&temp_2[2][1]);

assign temp_3[7][0]=(temp_2[7][0])|(temp_2[7][1]&temp_2[3][0]);
assign temp_3[7][1]=(temp_2[7][0])|(temp_2[7][1]&temp_2[3][1]);

assign temp_3[8][0]=(temp_2[8][0])|(temp_2[8][1]&temp_2[4][0]);
assign temp_3[8][1]=(temp_2[8][0])|(temp_2[8][1]&temp_2[4][1]);

assign temp_3[9][0]=(temp_2[9][0])|(temp_2[9][1]&temp_2[5][0]);
assign temp_3[9][1]=(temp_2[9][0])|(temp_2[9][1]&temp_2[5][1]);

assign temp_3[10][0]=(temp_2[10][0])|(temp_2[10][1]&temp_2[6][0]);
assign temp_3[10][1]=(temp_2[10][0])|(temp_2[10][1]&temp_2[6][1]);

assign temp_3[11][0]=(temp_2[11][0])|(temp_2[11][1]&temp_2[7][0]);
assign temp_3[11][1]=(temp_2[11][0])|(temp_2[11][1]&temp_2[7][1]);

assign temp_3[12][0]=(temp_2[12][0])|(temp_2[12][1]&temp_2[8][0]);
assign temp_3[12][1]=(temp_2[12][0])|(temp_2[12][1]&temp_2[8][1]);

assign temp_3[13][0]=(temp_2[13][0])|(temp_2[13][1]&temp_2[9][0]);
assign temp_3[13][1]=(temp_2[13][0])|(temp_2[13][1]&temp_2[9][1]);

assign temp_3[14][0]=(temp_2[14][0])|(temp_2[14][1]&temp_2[10][0]);
assign temp_3[14][1]=(temp_2[14][0])|(temp_2[14][1]&temp_2[10][1]);

assign temp_3[15][0]=(temp_2[15][0])|(temp_2[15][1]&temp_2[11][0]);
assign temp_3[15][1]=(temp_2[15][0])|(temp_2[15][1]&temp_2[11][1]);

assign temp_3[16][0]=(temp_2[16][0])|(temp_2[16][1]&temp_2[12][0]);
assign temp_3[16][1]=(temp_2[16][0])|(temp_2[16][1]&temp_2[12][1]);




// 8 - 16.8  15.7  14.6  13.5  12.4  11.3  10.2  9.1  8  7  6  5  4  3  2  1
assign temp_4[1][0]=temp_3[1][0];
assign temp_4[1][1]=temp_3[1][1];

assign temp_4[2][0]=temp_3[2][0];
assign temp_4[2][1]=temp_3[2][1];

assign temp_4[3][0]=temp_3[3][0];
assign temp_4[3][1]=temp_3[3][1];

assign temp_4[4][0]=temp_3[4][0];
assign temp_4[4][1]=temp_3[4][1];

assign temp_4[5][0]=temp_3[5][0];
assign temp_4[5][1]=temp_3[5][1];

assign temp_4[6][0]=temp_3[6][0];
assign temp_4[6][1]=temp_3[6][1];

assign temp_4[7][0]=temp_3[7][0];
assign temp_4[7][1]=temp_3[7][1];

assign temp_4[8][0]=temp_3[8][0];
assign temp_4[8][1]=temp_3[8][1];

assign temp_4[9][0]=(temp_3[9][0])|(temp_3[9][1]&temp_3[1][0]);
assign temp_4[9][1]=(temp_3[9][0])|(temp_3[9][1]&temp_3[1][1]);

assign temp_4[10][0]=(temp_3[10][0])|(temp_3[10][1]&temp_3[2][0]);
assign temp_4[10][1]=(temp_3[10][0])|(temp_3[10][1]&temp_3[2][1]);

assign temp_4[11][0]=(temp_3[11][0])|(temp_3[11][1]&temp_3[3][0]);
assign temp_4[11][1]=(temp_3[11][0])|(temp_3[11][1]&temp_3[3][1]);

assign temp_4[12][0]=(temp_3[12][0])|(temp_3[12][1]&temp_3[4][0]);
assign temp_4[12][1]=(temp_3[12][0])|(temp_3[12][1]&temp_3[4][1]);

assign temp_4[13][0]=(temp_3[13][0])|(temp_3[13][1]&temp_3[5][0]);
assign temp_4[13][1]=(temp_3[13][0])|(temp_3[13][1]&temp_3[5][1]);

assign temp_4[14][0]=(temp_3[14][0])|(temp_3[14][1]&temp_3[6][0]);
assign temp_4[14][1]=(temp_3[14][0])|(temp_3[14][1]&temp_3[6][1]);

assign temp_4[15][0]=(temp_3[15][0])|(temp_3[15][1]&temp_3[7][0]);
assign temp_4[15][1]=(temp_3[15][0])|(temp_3[15][1]&temp_3[7][1]);

assign temp_4[16][0]=(temp_3[16][0])|(temp_3[16][1]&temp_3[8][0]);
assign temp_4[16][1]=(temp_3[16][0])|(temp_3[16][1]&temp_3[8][1]);




//GK Calculating
assign gk[1]=temp_4[1][1];
assign gk[2]=temp_4[2][1];
assign gk[3]=temp_4[3][1];
assign gk[4]=temp_4[4][1];
assign gk[5]=temp_4[5][1];
assign gk[6]=temp_4[6][1];
assign gk[7]=temp_4[7][1];
assign gk[8]=temp_4[8][1];
assign gk[9]=temp_4[9][1];
assign gk[10]=temp_4[10][1];
assign gk[11]=temp_4[11][1];
assign gk[12]=temp_4[12][1];
assign gk[13]=temp_4[13][1];
assign gk[14]=temp_4[14][1];
assign gk[15]=temp_4[15][1];
assign gk[16]=temp_4[16][1];


//calculating sum
assign sum[1]=a[1]^b[1]^1'b0;
assign sum[2]=gk[1]^a[2]^b[2];
assign sum[3]=gk[2]^a[3]^b[3];
assign sum[4]=gk[3]^a[4]^b[4];
assign sum[5]=gk[4]^a[5]^b[5];
assign sum[6]=gk[5]^a[6]^b[6];
assign sum[7]=gk[6]^a[7]^b[7];
assign sum[8]=gk[7]^a[8]^b[8];
assign sum[9]=gk[8]^a[9]^b[9];
assign sum[10]=gk[9]^a[10]^b[10];
assign sum[11]=gk[10]^a[11]^b[11];
assign sum[12]=gk[11]^a[12]^b[12];
assign sum[13]=gk[12]^a[13]^b[13];
assign sum[14]=gk[13]^a[14]^b[14];
assign sum[15]=gk[14]^a[15]^b[15];
assign sum[16]=gk[15]^a[16]^b[16];
assign cout=gk[16];


endmodule



