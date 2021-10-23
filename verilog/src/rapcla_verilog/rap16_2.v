module rap16_2(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [15:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[0];
assign appc[1] = g[1] | p[1]&g[0];
assign appc[15:2] = g[15:2] | p[15:2]&g[14:1] | p[15:2]&p[14:1]&g[13:0];

assign c[2:0] = appc[2:0];
MUX cin[15:2](appc[15:2],1'b0,1'b0,c[15:2]);

assign sum[0] = p[0];
assign sum[15:1] = p[15:1]^appc[14:0];
assign sum[16] = c[15];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule