module rap32_4(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [31:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[0];
assign appc[1] = g[1] | p[1]&g[0];
assign appc[2] = g[2] | p[2]&g[1] | p[2]&p[1]&g[0];
assign appc[3] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign appc[31:4] = g[31:4] | p[31:4]&g[30:3] | p[31:4]&p[30:3]&g[29:2] | p[31:4]&p[30:3]&p[29:2]&g[28:1] | p[31:4]&p[30:3]&p[29:2]&p[28:1]&g[27:0];

assign c[3:0] = appc[3:0];
MUX cin[31:4](appc[31:4],1'b0,1'b0,c[31:4]);

assign sum[0] = p[0];
assign sum[31:1] = p[31:1]^appc[30:0];
assign sum[32] = c[31];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule