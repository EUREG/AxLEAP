module eru16_8(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd = g[7] | p[7]&g[6] | p[7]&p[6]&g[5] | p[7]&p[6]&p[5]&g[4] | p[7]&p[6]&p[5]&p[4]&g[3] | p[7]&p[6]&p[5]&p[4]&p[3]&g[2] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&g[1] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0];
assign sel = g[7] | (~a[8])&(~b[8]);


MUX cin1(cadd,g[7],sel,c);

carry_look_ahead_8bit cla1(p[7:0], g[7:0], 1'b0 , 1'b0, sum[7:0], cout);
carry_look_ahead_8bit cla2(p[15:8], g[15:8], c, cadd, sum[15:8], sum[16]);
endmodule

module carry_look_ahead_8bit(p,g, cin, cadd, sum,cout);
input [7:0] p,g;
input cin,cadd;
output [7:0] sum;
output cout;
wire [7:0] c;

assign c[0]=cin;
assign c[1]= g[0] | p[0]&c[0];
assign c[2]= g[1] | p[1]&g[0] | p[1]&p[0]&c[0];
assign c[3]= g[2] | p[2]&g[1] | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign c[4]= g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign c[5]= g[4] | p[4]&g[3] | p[4]&p[3]&g[2] | p[4]&p[3]&p[2]&g[1] | p[4]&p[3]&p[2]&p[1]&g[0] | p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
assign c[6]= g[5] | p[5]&g[4] | p[5]&p[4]&g[3] | p[5]&p[4]&p[3]&g[2] | p[5]&p[4]&p[3]&p[2]&g[1] | p[5]&p[4]&p[3]&p[2]&p[1]&g[0] | p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
assign c[7]= g[6] | p[6]&g[5] | p[6]&p[5]&g[4] | p[6]&p[5]&p[4]&g[3] | p[6]&p[5]&p[4]&p[3]&g[2] | p[6]&p[5]&p[4]&p[3]&p[2]&g[1] | p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0] | p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
assign cout= g[7] | p[7]&g[6] | p[7]&p[6]&g[5] | p[7]&p[6]&p[5]&g[4] | p[7]&p[6]&p[5]&p[4]&g[3] | p[7]&p[6]&p[5]&p[4]&p[3]&g[2] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&g[1] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
assign sum[7:1]=p[7:1]^c[7:1]; 
assign sum[0]=p[0]^c[0] | (~p[0])&(~g[0])&cadd; 
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule