`default_nettype none

module fulladder
(  
    input   wire    a_i,
    input   wire    b_i,
    input   wire    c_i,
    
    output  wire    s_o,
    output  wire    c_o
);

    assign s_o = a_i ^ b_i ^ c_i;
    assign c_o = (a_i & b_i) | ((a_i ^ b_i) & c_i);
endmodule