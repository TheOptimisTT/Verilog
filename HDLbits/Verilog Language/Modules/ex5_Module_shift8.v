module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] t1,t2, t3;
    my_dff8 m1( .clk, .d(d), .q(t1) );
    my_dff8 m2( .clk, .d(t1), .q(t2) );
    my_dff8 m3( .clk, .d(t2), .q(t3) );
    
    always@(*)begin
        if(sel == 0)
            q = d;
        else if (sel == 1)
            q = t1;
        else if (sel == 2)
            q = t2;
        else if (sel == 3)
            q = t3;
    end
    
endmodule