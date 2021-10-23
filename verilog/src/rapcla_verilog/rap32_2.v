module rap32_2(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [31:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[0];
assign appc[1] = g[1] | p[1]&g[0];
assign appc[31:2] = g[31:2] | p[31:2]&g[30:1] | p[31:2]&p[30:1]&g[29:0];

assign c[2:0] = appc[2:0];
MUX cin[31:2](appc[31:2],1'b0,1'b0,c[31:2]);

assign sum[0] = p[0];
assign sum[31:1] = p[31:1]^appc[30:0];
assign sum[32] = c[31];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule
