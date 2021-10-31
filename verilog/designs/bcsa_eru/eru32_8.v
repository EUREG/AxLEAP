module eru32_8(a,b,sum);
input [31:0] a,b;
output [32:0] sum;
wire [31:0] p,g;
wire [2:0] cadd,cout,c,sel;

assign p = a^b;
assign g = a&b;
assign cadd[0] = g[7] | p[7]&g[6] | p[7]&p[6]&g[5] | p[7]&p[6]&p[5]&g[4] | p[7]&p[6]&p[5]&p[4]&g[3] | p[7]&p[6]&p[5]&p[4]&p[3]&g[2] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&g[1] | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0];
assign cadd[1] = g[15] | p[15]&g[14] | p[15]&p[14]&g[13] | p[15]&p[14]&p[13]&g[12] | p[15]&p[14]&p[13]&p[12]&g[11] | p[15]&p[14]&p[13]&p[12]&p[11]&g[10] | p[15]&p[14]&p[13]&p[12]&p[11]&p[10]&g[9] | p[15]&p[14]&p[13]&p[12]&p[11]&p[10]&p[9]&g[8] | p[15]&p[14]&p[13]&p[12]&p[11]&p[10]&p[9]&p[8]&g[7];
assign cadd[2] = g[23] | p[23]&g[22] | p[23]&p[22]&g[21] | p[23]&p[22]&p[21]&g[20] | p[23]&p[22]&p[21]&p[20]&g[19] | p[23]&p[22]&p[21]&p[20]&p[19]&g[18] | p[23]&p[22]&p[21]&p[20]&p[19]&p[18]&g[17] | p[23]&p[22]&p[21]&p[20]&p[19]&p[18]&p[17]&g[16] | p[23]&p[22]&p[21]&p[20]&p[19]&p[18]&p[17]&g[16]&g[15];
assign sel[0] = g[7] | (~a[8])&(~b[8]);
assign sel[1] = g[15] | (~a[16])&(~b[16]);
assign sel[2] = g[23] | (~a[24])&(~b[24]);


MUX cin1(cadd[0],g[7],sel[0],c[0]);
MUX cin2(cadd[1],g[15],sel[1],c[1]);
MUX cin3(cadd[2],g[23],sel[2],c[2]);

carry_look_ahead_8bit cla1(p[7:0], g[7:0], 1'b0 , 1'b0, sum[7:0], cout[0]);
carry_look_ahead_8bit cla2(p[15:8], g[15:8], c[0], cadd[0], sum[15:8], cout[1]);
carry_look_ahead_8bit cla3(p[23:16], g[23:16], c[1], cadd[1], sum[23:16], cout[2]);
carry_look_ahead_8bit cla4(p[31:24], g[31:24], c[2], cadd[2], sum[31:24], sum[32]);
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