`include "rca_block.v"

`default_nettype none

module upfadder#
(
    parameter N = 32,           // Arch Size
    parameter K = 4,            // Block Size
    parameter C = 4'b1110       // Approx. Configuration
)
(
    input   wire    [N-1:0] a_i,
    input   wire    [N-1:0] b_i,
    input   wire            c_i,

    output  wire    [N-1:0] s_o,
    output  wire            c_o
);
    
    localparam M = (N/2)/K;     // M = Number of blocks
    
    wire [M:0] carry;
    assign carry[0] = c_i;

    /////////////////////////////////////////////
    // Lower Half  

    genvar i;

    generate 
        for(i=0; i<M; i=i+1) begin: AxBlocks
            if(C[i] == 1'b1) begin
                rca_block#(.n(M)) ApxBlock
                (
                    .a_i    (a_i[M*(i+1)-1:i*M]),
                    .b_i    (b_i[M*(i+1)-1:i*M]),
                    .c_i    (carry[i]), 
                    .s_o    (s_o[M*(i+1)-1:i*M]),
                    .c_o    (carry[i+1])
                );
            end
            else begin
                assign s_o[i] = 1'b0;
                assign carry[i] = 1'b0;
            end
        end
    endgenerate

    /////////////////////////////////////////////////
    // Upper Half

    rca_block#(.n(N/2)) AccBlock
    (
        .a_i    (a_i[N-1:N/2]),
        .b_i    (b_i[N-1:N/2]),
        .c_i    (carry[M-1]), 
        .s_o    (s_o[N-1:N/2]),
        .c_o    (c_o)
    );

endmodule