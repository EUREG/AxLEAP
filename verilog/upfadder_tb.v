`timescale 1ns/10ps

`include "upfadder.v"


`default_nettype none

module upfadder_tb;
    reg [`ARCHSIZE-1:0]  a,b;
    reg cin;
    wire [`ARCHSIZE-1:0] sum;
    wire cout;

    upfadder#(.N(`ARCHSIZE), .K(`BLOCKSIZE), .C(`CONFIG)) adder(a,b,cin,sum,cout);

    integer i=1;
    parameter n=`CASES;

    reg [`ARCHSIZE-1:0]  areg [1:n];
    reg [`ARCHSIZE-1:0]  breg [1:n];
    reg [`ARCHSIZE:0]    ans [1:n];

    initial begin 
        $readmemh(`FILEA, areg);
        $readmemh(`FILEB, breg);
        $readmemh(`FILEC, ans);
    end


    initial begin
        `ifdef VCDFILE
            $dumpfile(`VCDFILE);
            $dumpvars(1,upfadder_tb);
        `endif

        #10;
        cin = 1'd0;
        for(i=1; i<=n; i++)begin
            a= areg[i]; b=breg[i]; #1;        
            if({cout,sum} != ans[i])
                $display("!ERROR:%d ; %d*%d = {Expected: %d;  Got: %d};",i,areg[i], breg[i], ans[i], {cout,sum}); 
            //$display("%d", i);    
        end
        $display("%d cases checked; all good..",n);       
        $finish;
    end
endmodule