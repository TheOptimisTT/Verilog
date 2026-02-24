module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire t1;
    wire [15:0] t2, t3;
	add16 m1(.a(a[15:0]), .b(b[15:0]), .cin(0), .sum(sum[15:0]), .cout(t1) );
    
    add16 m2(.a(a[31:16]), .b(b[31:16]), .cin(0), .sum(t2), .cout() );
    add16 m3(.a(a[31:16]), .b(b[31:16]), .cin(1), .sum(t3), .cout() );
    
    assign sum[31:16] = t1 ? t3 : t2;
endmodule