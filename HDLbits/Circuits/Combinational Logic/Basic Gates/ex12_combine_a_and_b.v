module top_module (input x, input y, output z);
// A -> z = (x^y) & x;
// B -> z = ~ (x ^ y);
wire t1,t2,t3,t4,t5,t6;
    assign t1 = (x^y) & x;
    assign t2 = ~(x ^ y);
    assign t3 = (x^y) & x;
    assign t4 = ~ (x ^ y);
    assign t5 = t1 | t2;
    assign t6 = t3 & t4;  
    assign z = t5 ^ t6;

endmodule