module rap16_8(a,b,sum);
input [15:0] a,b;
output [16:0] sum;
wire [15:0] p,g;
wire [15:0] appc,c;

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
assign appc[15:8] = g[15:8] | p[15:8]&g[14:7] | p[15:8]&p[14:7]&g[13:6] | p[15:8]&p[14:7]&p[13:6]&g[12:5] | p[15:8]&p[14:7]&p[13:6]&p[12:5]&g[11:4] | p[15:8]&p[14:7]&p[13:6]&p[12:5]&p[11:4]&g[10:3] | p[15:8]&p[14:7]&p[13:6]&p[12:5]&p[11:4]&p[10:3]&g[9:2] | p[15:8]&p[14:7]&p[13:6]&p[12:5]&p[11:4]&p[10:3]&p[9:2]&g[8:1] | p[15:8]&p[14:7]&p[13:6]&p[12:5]&p[11:4]&p[10:3]&p[9:2]&p[8:1]&g[7:0];
assign c[7:0] = appc[7:0];

MUX cin[15:8](appc[15:8],1'b0,1'b0,c[15:8]);

assign sum[0] = p[0];
assign sum[15:1] = p[15:1]^appc[14:0];
assign sum[16] = c[15];
endmodule

module MUX(i1,i0,s,q);
output q;
input i1,i0,s;

assign q = i1&(~s) | i0&s;
endmodule