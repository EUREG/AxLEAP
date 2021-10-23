module rap16_4(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [15:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[0];
assign appc[1] = g[1] | p[1]&g[0];
assign appc[2] = g[2] | p[2]&g[1] | p[2]&p[1]&g[0];
assign appc[3] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign appc[15:4] = g[15:4] | p[15:4]&g[14:3] | p[15:4]&p[14:3]&g[13:2] | p[15:4]&p[14:3]&p[13:2]&g[12:1] | p[15:4]&p[14:3]&p[13:2]&p[12:1]&g[11:0];

assign c[3:0] = appc[3:0];
MUX cin[15:4](appc[15:4],1'b0,1'b0,c[15:4]);

assign sum[0] = p[0];
assign sum[15:1] = p[15:1]^appc[14:0];
assign sum[16] = c[15];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule