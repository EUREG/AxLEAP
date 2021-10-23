module rap32_8(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [31:0] appc,c;

assign p = a^b;
assign g = a&b;
assign appc[0]= g[0] ;
assign appc[1]= g[1] | p[1]&g[0] ;
assign appc[2]= g[2] | p[2]&g[1] | p[2]&p[1]&g[0] ;
assign appc[3]= g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] ;
assign appc[4]= g[4] | p[4]&g[3] | p[4]&p[3]&g[2] | p[4]&p[3]&p[2]&g[1] | p[4]&p[3]&p[2]&p[1]&g[0] ;
assign appc[5]= g[5] | p[5]&g[4] | p[5]&p[4]&g[3] | p[5]&p[4]&p[3]&g[2] | p[5]&p[4]&p[3]&p[2]&g[1] | p[5]&p[4]&p[3]&p[2]&p[1]&g[0] ;
assign appc[6]= g[6] | p[6]&g[5] | p[6]&p[5]&g[4] | p[6]&p[5]&p[4]&g[3] | p[6]&p[5]&p[4]&p[3]&g[2] | p[6]&p[5]&p[4]&p[3]&p[2]&g[1] | p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0] ;
assign appc[7]= g[7] | p[7]&g[6] | p[7]&p[6]&g[5] | p[7]&p[6]&p[5]&g[4] | p[7]&p[6]&p[5]&p[4]&g[3] | p[7]&p[6]&p[5]&p[4]&p[3]&g[2] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&g[1] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0];
assign appc[31:8] = g[31:8] | p[31:8]&g[30:7] | p[31:8]&p[30:7]&g[29:6] | p[31:8]&p[30:7]&p[29:6]&g[28:5] | p[31:8]&p[30:7]&p[29:6]&p[28:5]&g[27:4] | p[31:8]&p[30:7]&p[29:6]&p[28:5]&p[27:4]&g[26:3] | p[31:8]&p[30:7]&p[29:6]&p[28:5]&p[27:4]&p[26:3]&g[25:2] | p[31:8]&p[30:7]&p[29:6]&p[28:5]&p[27:4]&p[26:3]&p[25:2]&g[24:1] | p[31:8]&p[30:7]&p[29:6]&p[28:5]&p[27:4]&p[26:3]&p[25:2]&p[24:1]&g[23:0];

assign c[7:0] = appc[7:0];
MUX cin[31:8](appc[31:8],1'b0,1'b0,c[31:8]);

assign sum[0] = p[0];
assign sum[31:1] = p[31:1]^appc[30:0];
assign sum[32] = c[31];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule