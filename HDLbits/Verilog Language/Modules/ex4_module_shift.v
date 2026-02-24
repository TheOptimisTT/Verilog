module top_module ( input clk, input d, output q );
    wire t1,t2;
    my_dff m1( .clk, .d(d), .q(t1) );
    my_dff m2( .clk, .d(t1), .q(t2) );
    my_dff m3( .clk, .d(t2), .q(q) );
endmodule