module eru8_2(a,b,sum);
input [7:0] a,b;
output [8:0] sum;
wire [7:0] p,g;
wire [2:0] cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd[0] = g[1] | p[1]&g[0] ;
assign cadd[1] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] ;
assign cadd[2] = g[5] | p[5]&g[4] | p[5]&p[4]&g[3] ;
assign sel[0] = g[1] | (~a[2])&(~b[2]);
assign sel[1] = g[3] | (~a[4])&(~b[4]);
assign sel[2] = g[5] | (~a[6])&(~b[6]);

MUX cin1(cadd[0],g[1],sel[0],c[0]);
MUX cin2(cadd[1],g[3],sel[1],c[1]);
MUX cin3(cadd[2],g[5],sel[2],c[2]);

carry_look_ahead_2bit cla1(p[1:0], g[1:0], 1'b0 , 1'b0, sum[1:0], cout[0]);
carry_look_ahead_2bit cla2(p[3:2], g[3:2], c[0] , cadd[0], sum[3:2], cout[1]);
carry_look_ahead_2bit cla3(p[5:4], g[5:4], c[1] , cadd[1], sum[5:4], cout[2]);
carry_look_ahead_2bit cla4(p[7:6], g[7:6], c[2] , cadd[2],sum[7:6], sum[8]);
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