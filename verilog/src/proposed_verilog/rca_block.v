`include "fulladder.v"
`default_nettype none

module rca_block#(parameter n = 4)
(
    input   wire    [n-1:0] a_i,
    input   wire    [n-1:0] b_i,
    input   wire            c_i,

    output  wire    [n-1:0] s_o,
    output  wire            c_o
);

    wire [n:0] carry;
    
    assign carry[0] = c_i;

    genvar i;
    generate for(i=0; i<n; i=i+1) begin:FA
            fulladder fa
            (
                .a_i    (a_i[i]),
                .b_i    (b_i[i]), 
                .c_i    (carry[i]), 
                .s_o    (s_o[i]), 
                .c_o    (carry[i+1])
            );
        end
    endgenerate

    assign c_o = carry[n];
endmodule