module bcsa8_4(a,b,sum);
input [7:0] a,b;
output [8:0] sum;
wire [7:0] p,g;
wire cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign sel = g[3] | (~a[4])&(~b[4]);



MUX cin1(cadd,g[3],sel,c);


carry_look_ahead_4bit cla1(p[3:0], g[3:0], 1'b0 , sum[3:0], cout);
carry_look_ahead_4bit cla2 (p[7:4], g[7:4], c, sum[7:4], sum[8]);
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