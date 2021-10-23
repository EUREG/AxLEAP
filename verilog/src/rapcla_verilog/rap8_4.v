module rap8_4(a,b,sum);
input [7:0] a,b;
output [8:0] sum;
wire [7:0] p,g;
wire [7:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[0];
assign appc[1] = g[1] | p[1]&g[0];
assign appc[2] = g[2] | p[2]&g[1] | p[2]&p[1]&g[0];
assign appc[3] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign appc[7:4] = g[7:4] | p[7:4]&g[6:3] | p[7:4]&p[6:3]&g[5:2] | p[7:4]&p[6:3]&p[5:2]&g[4:1] | p[7:4]&p[6:3]&p[5:2]&p[4:1]&g[3:0];

assign c[3:0] = appc[3:0];
MUX cin[7:4](appc[7:4],1'b0,1'b0,c[7:4]);

assign sum[0] = p[0];
assign sum[7:1] = p[7:1]^appc[6:0];
assign sum[8] = c[7];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule