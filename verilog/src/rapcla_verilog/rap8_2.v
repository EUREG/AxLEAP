module rap8_2(a,b,sum);
input [7:0] a,b;
output [8:0] sum;
wire [7:0] p,g;
wire [7:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0] = g[0];
assign appc[1] = g[1] | p[1]&g[0];
assign appc[7:2] = g[7:2] | p[7:2]&g[6:1] | p[7:2]&p[6:1]&g[5:0];

assign c[1:0] = appc[1:0];
MUX cin[7:2](appc[7:2],1'b0,1'b0,c[7:2]);

assign sum[0] = p[0];
assign sum[7:1] = p[7:1]^appc[6:0];
assign sum[8] = c[7];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule