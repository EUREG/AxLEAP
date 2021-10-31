`timescale 1ns/10ps
`include "rap32_4.v"

`default_nettype none

module testbench;
    reg [31:0]  a,b;
    reg cin;
    wire [31:0] sum;
    wire cout;

    rap32_4 adder(a,b,{cout, sum});

    integer i=1;
    parameter n=`CASES;

    reg [31:0]  areg [1:n];
    reg [31:0]  breg [1:n];
    reg [32:0]    ans [1:n];

    initial begin 
        $readmemh(`FILEA, areg);
        $readmemh(`FILEB, breg);
        $readmemh(`FILEC, ans);
    end


    initial begin
        `ifdef TRACEFILE
            $dumpfile(`TRACEFILE);
            $dumpvars(0,adder);
        `endif

        #10;
        cin = 1'd0;
        for(i=1; i<=n; i++)begin
            a= areg[i]; b=breg[i]; #1;        
            if({cout,sum} != ans[i])
                $display("!ERROR:%d ; %d + %d = {Expected: %b;  Got: %b};",i,areg[i], breg[i], ans[i], {cout,sum}); 
        
        end
        $display("%d cases checked",n);       
        $finish;
    end
endmodule