module bcsa16_4(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [2:0] cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd[0] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign cadd[1] = g[7] | p[7]&g[6] | p[7]&p[6]&g[5] | p[7]&p[6]&p[5]&g[4] | p[7]&p[6]&p[5]&p[4]&g[3];
assign cadd[2] = g[11] | p[11]&g[10] | p[11]&p[10]&g[9] | p[11]&p[10]&p[9]&g[8] | p[11]&p[10]&p[9]&p[8]&g[7];
assign sel[0] = g[3] | (~a[4])&(~b[4]);
assign sel[1] = g[7] | (~a[8])&(~b[8]);
assign sel[2] = g[11] | (~a[12])&(~b[12]);


MUX cin1(cadd[0],g[3],sel[0],c[0]);
MUX cin2(cadd[1],g[7],sel[1],c[1]);
MUX cin3(cadd[2],g[11],sel[2],c[2]);

carry_look_ahead_4bit cla1(p[3:0], g[3:0], 1'b0 , sum[3:0], cout[0]);
carry_look_ahead_4bit cla2 (p[7:4], g[7:4], c[0], sum[7:4], cout[1]);
carry_look_ahead_4bit cla3(p[11:8], g[11:8], c[1], sum[11:8], cout[2]);
carry_look_ahead_4bit cla4(p[15:12], g[15:12], c[2], sum[15:12], sum[16]);
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