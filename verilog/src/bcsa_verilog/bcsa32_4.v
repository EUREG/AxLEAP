module bcsa32_4(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [6:0] cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd[0] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign cadd[1] = g[7] | p[7]&g[6] | p[7]&p[6]&g[5] | p[7]&p[6]&p[5]&g[4] | p[7]&p[6]&p[5]&p[4]&g[3];
assign cadd[2] = g[11] | p[11]&g[10] | p[11]&p[10]&g[9] | p[11]&p[10]&p[9]&g[8] | p[11]&p[10]&p[9]&p[8]&g[7];
assign cadd[3] = g[15] | p[15]&g[14] | p[15]&p[14]&g[13] | p[15]&p[14]&p[13]&g[12] | p[15]&p[14]&p[13]&p[12]&g[11];
assign cadd[4] = g[19] | p[19]&g[18] | p[19]&p[18]&g[17] | p[19]&p[18]&p[17]&g[16] | p[19]&p[18]&p[17]&p[16]&g[15];
assign cadd[5] = g[23] | p[23]&g[22] | p[23]&p[22]&g[21] | p[23]&p[22]&p[21]&g[20] | p[23]&p[22]&p[21]&p[20]&g[19];
assign cadd[6] = g[27] | p[27]&g[26] | p[27]&p[26]&g[25] | p[27]&p[26]&p[25]&g[24] | p[27]&p[26]&p[25]&p[24]&g[23];
assign sel[0] = g[3] | (~a[4])&(~b[4]);
assign sel[1] = g[7] | (~a[8])&(~b[8]);
assign sel[2] = g[11] | (~a[12])&(~b[12]);
assign sel[3] = g[15] | (~a[16])&(~b[16]);
assign sel[4] = g[19] | (~a[20])&(~b[20]);
assign sel[5] = g[23] | (~a[24])&(~b[24]);
assign sel[6] = g[27] | (~a[28])&(~b[28]);


MUX cin1(cadd[0],g[3],sel[0],c[0]);
MUX cin2(cadd[1],g[7],sel[1],c[1]);
MUX cin3(cadd[2],g[11],sel[2],c[2]);
MUX cin4(cadd[3],g[15],sel[3],c[3]);
MUX cin5(cadd[4],g[19],sel[4],c[4]);
MUX cin6(cadd[5],g[23],sel[5],c[5]);
MUX cin7(cadd[6],g[27],sel[6],c[6]);

carry_look_ahead_4bit cla1(p[3:0], g[3:0], 1'b0 , sum[3:0], cout[0]);
carry_look_ahead_4bit cla2 (p[7:4], g[7:4], c[0], sum[7:4], cout[1]);
carry_look_ahead_4bit cla3(p[11:8], g[11:8], c[1], sum[11:8], cout[2]);
carry_look_ahead_4bit cla4(p[15:12], g[15:12], c[2], sum[15:12], cout[3]);
carry_look_ahead_4bit cla5(p[19:16],g[19:16], c[3], sum[19:16], cout[4]);
carry_look_ahead_4bit cla6(p[23:20],g[23:20], c[4], sum[23:20], cout[5]);
carry_look_ahead_4bit cla7(p[27:24],g[27:24], c[5], sum[27:24], cout[6]);
carry_look_ahead_4bit cla8(p[31:28],g[31:28], c[6], sum[31:28],sum[32]);
endmodule

module carry_look_ahead_4bit(p,g, cin, sum,cout);
input [3:0] p,g;
input cin;
output [3:0] sum;
output cout;
wire [3:0] c;

assign c[0]=cin;
assign c[1]= g[0] | (p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c; 
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule