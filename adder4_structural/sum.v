module sum(sum, a, b, cy_in);
    input a,b,cy_in;
    output sum;
    wire t;

    xor x1 (t, a, b);
    xor x2 (sum, t, cy_in);
endmodule