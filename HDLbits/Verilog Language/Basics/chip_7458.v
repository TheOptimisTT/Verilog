module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    wire f1, f2, f3, f4;
    
    assign f1 = p1a & p1c & p1b;
    assign f2 = p1f & p1e & p1d;
    assign f3 = p2a & p2b;
    assign f4 = p2c & p2d;
    
    assign p2y = f3 | f4;    
    assign p1y = f1 | f2;

endmodule