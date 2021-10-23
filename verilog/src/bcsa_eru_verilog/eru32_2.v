module eru32_2(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [14:0] cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd[0] = g[1] | p[1]&g[0] ;
assign cadd[1] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] ;
assign cadd[2] = g[5] | p[5]&g[4] | p[5]&p[4]&g[3] ;
assign cadd[3] = g[7] | p[7]&g[6] | p[7]&p[6]&g[5] ;
assign cadd[4] = g[9] | p[9]&g[8] | p[9]&p[8]&g[7] ;
assign cadd[5] = g[11] | p[11]&g[10] | p[11]&p[10]&g[9] ;
assign cadd[6] = g[13] | p[13]&g[12] | p[13]&p[12]&g[11] ;
assign cadd[7] = g[15] | p[15]&g[14] | p[15]&p[14]&g[13] ;
assign cadd[8] = g[17] | p[17]&g[16] | p[17]&p[16]&g[15] ;
assign cadd[9] = g[19] | p[19]&g[18] | p[19]&p[18]&g[17] ;
assign cadd[10] = g[21] | p[21]&g[20] | p[21]&p[20]&g[19] ;
assign cadd[11] = g[23] | p[23]&g[22] | p[23]&p[22]&g[21] ;
assign cadd[12] = g[25] | p[25]&g[24] | p[25]&p[24]&g[23] ;
assign cadd[13] = g[27] | p[27]&g[26] | p[27]&p[26]&g[25] ;
assign cadd[14] = g[29] | p[29]&g[28] | p[29]&p[28]&g[27] ;
assign sel[0] = g[1] | (~a[2])&(~b[2]);
assign sel[1] = g[3] | (~a[4])&(~b[4]);
assign sel[2] = g[5] | (~a[6])&(~b[6]);
assign sel[3] = g[7] | (~a[8])&(~b[8]);
assign sel[4] = g[9] | (~a[10])&(~b[10]);
assign sel[5] = g[11] | (~a[12])&(~b[12]);
assign sel[6] = g[13] | (~a[14])&(~b[14]);
assign sel[7] = g[15] | (~a[16])&(~b[16]);
assign sel[8] = g[17] | (~a[18])&(~b[18]);
assign sel[9] = g[19] | (~a[20])&(~b[20]);
assign sel[10] = g[21] | (~a[22])&(~b[22]);
assign sel[11] = g[23] | (~a[24])&(~b[24]);
assign sel[12] = g[25] | (~a[26])&(~b[26]);
assign sel[13] = g[27] | (~a[28])&(~b[28]);
assign sel[14] = g[29] | (~a[30])&(~b[30]);

MUX cin1(cadd[0],g[1],sel[0],c[0]);
MUX cin2(cadd[1],g[3],sel[1],c[1]);
MUX cin3(cadd[2],g[5],sel[2],c[2]);
MUX cin4(cadd[3],g[7],sel[3],c[3]);
MUX cin5(cadd[4],g[9],sel[4],c[4]);
MUX cin6(cadd[5],g[11],sel[5],c[5]);
MUX cin7(cadd[6],g[13],sel[6],c[6]);
MUX cin8(cadd[7],g[15],sel[7],c[7]);
MUX cin9(cadd[8],g[17],sel[8],c[8]);
MUX cin10(cadd[9],g[19],sel[9],c[9]);
MUX cin11(cadd[10],g[21],sel[10],c[10]);
MUX cin12(cadd[11],g[23],sel[11],c[11]);
MUX cin13(cadd[12],g[25],sel[12],c[12]);
MUX cin14(cadd[13],g[27],sel[13],c[13]);
MUX cin15(cadd[14],g[29],sel[14],c[14]);

carry_look_ahead_2bit cla1(p[1:0], g[1:0], 1'b0 , 1'b0, sum[1:0], cout[0]);
carry_look_ahead_2bit cla2(p[3:2], g[3:2], c[0] , cadd[0], sum[3:2], cout[1]);
carry_look_ahead_2bit cla3(p[5:4], g[5:4], c[1] , cadd[1], sum[5:4], cout[2]);
carry_look_ahead_2bit cla4(p[7:6], g[7:6], c[2] , cadd[2], sum[7:6], cout[3]);
carry_look_ahead_2bit cla5(p[9:8], g[9:8], c[3] , cadd[3], sum[9:8], cout[4]);
carry_look_ahead_2bit cla6(p[11:10], g[11:10], c[4] , cadd[4], sum[11:10], cout[5]);
carry_look_ahead_2bit cla7(p[13:12], g[13:12], c[5] , cadd[5], sum[13:12], cout[6]);
carry_look_ahead_2bit cla8(p[15:14], g[15:14], c[6] , cadd[6], sum[15:14], cout[6]);
carry_look_ahead_2bit cla9(p[17:16], g[17:16], c[7] , cadd[7], sum[17:16], cout[7]);
carry_look_ahead_2bit cla10(p[19:18], g[19:18], c[8] , cadd[8], sum[19:18], cout[8]);
carry_look_ahead_2bit cla11(p[21:20], g[21:20], c[9] , cadd[9], sum[21:20], cout[9]);
carry_look_ahead_2bit cla12(p[23:22], g[23:22], c[10] , cadd[10], sum[23:22], cout[10]);
carry_look_ahead_2bit cla13(p[25:24], g[25:24], c[11] , cadd[11], sum[25:24], cout[11]);
carry_look_ahead_2bit cla14(p[27:26], g[27:26], c[12] , cadd[12], sum[27:26], cout[12]);
carry_look_ahead_2bit cla15(p[29:28], g[29:28], c[13] , cadd[13], sum[29:28], cout[13]);
carry_look_ahead_2bit cla16(p[31:30], g[31:30], c[14] , cadd[14], sum[31:30], sum[32]);
endmodule

module carry_look_ahead_2bit(p,g, cin,cadd, sum,cout);
input [1:0] p,g;
input cin,cadd;
output [1:0] sum;
output cout;
wire [1:0] c;

assign c[0]=cin;
assign c[1]= g[0] | (p[0]&c[0]);
assign cout= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign sum[1]=p[1]^c[1];
assign sum[0]=p[0]^c[0] | (~p[0])&(~g[0])&cadd;  
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule