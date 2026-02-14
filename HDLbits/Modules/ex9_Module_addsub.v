module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] t1;
    wire t2;
    assign t1 = b ^ {32{sub}};
    add16 m1(.a(a[15:0]), .b(t1[15:0]), .cin(sub), .sum(sum[15:0]), .cout(t2) );
    add16 m2(.a(a[31:16]), .b(t1[31:16]), .cin(t2), .sum(sum[31:16]), .cout() );
endmodule