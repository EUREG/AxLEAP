module eru16_2(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [6:0] cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd[0] = g[1] | p[1]&g[0] ;
assign cadd[1] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] ;
assign cadd[2] = g[5] | p[5]&g[4] | p[5]&p[4]&g[3] ;
assign cadd[3] = g[7] | p[7]&g[6] | p[7]&p[6]&g[5] ;
assign cadd[4] = g[9] | p[9]&g[8] | p[9]&p[8]&g[7] ;
assign cadd[5] = g[11] | p[11]&g[10] | p[11]&p[10]&g[9] ;
assign cadd[6] = g[13] | p[13]&g[12] | p[13]&p[12]&g[11] ;
assign sel[0] = g[1] | (~a[2])&(~b[2]);
assign sel[1] = g[3] | (~a[4])&(~b[4]);
assign sel[2] = g[5] | (~a[6])&(~b[6]);
assign sel[3] = g[7] | (~a[8])&(~b[8]);
assign sel[4] = g[9] | (~a[10])&(~b[10]);
assign sel[5] = g[11] | (~a[12])&(~b[12]);
assign sel[6] = g[13] | (~a[14])&(~b[14]);

MUX cin1(cadd[0],g[1],sel[0],c[0]);
MUX cin2(cadd[1],g[3],sel[1],c[1]);
MUX cin3(cadd[2],g[5],sel[2],c[2]);
MUX cin4(cadd[3],g[7],sel[3],c[3]);
MUX cin5(cadd[4],g[9],sel[4],c[4]);
MUX cin6(cadd[5],g[11],sel[5],c[5]);
MUX cin7(cadd[6],g[13],sel[6],c[6]);

carry_look_ahead_2bit cla1(p[1:0], g[1:0], 1'b0 , 1'b0, sum[1:0], cout[0]);
carry_look_ahead_2bit cla2(p[3:2], g[3:2], c[0] , cadd[0], sum[3:2], cout[1]);
carry_look_ahead_2bit cla3(p[5:4], g[5:4], c[1] , cadd[1], sum[5:4], cout[2]);
carry_look_ahead_2bit cla4(p[7:6], g[7:6], c[2] , cadd[2], sum[7:6], cout[3]);
carry_look_ahead_2bit cla5(p[9:8], g[9:8], c[3] , cadd[3], sum[9:8], cout[4]);
carry_look_ahead_2bit cla6(p[11:10], g[11:10], c[4] , cadd[4], sum[11:10], cout[5]);
carry_look_ahead_2bit cla7(p[13:12], g[13:12], c[5] , cadd[5], sum[13:12], cout[6]);
carry_look_ahead_2bit cla8(p[15:14], g[15:14], c[6] , cadd[6], sum[15:14], sum[16]);
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