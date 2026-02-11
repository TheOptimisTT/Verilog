`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
	
    wire f1,f2,f3;
    
    assign f1 = a & b;
    assign f2 = c & d;
    assign f3 = f1 | f2;
    
    assign out = f3;
    assign out_n = ~f3;
    
endmodule