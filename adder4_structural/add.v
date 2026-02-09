module add(cy_out, sum, a, b, cy_in);
    input a, b, cy_in;
    output sum, cy_out;

    sum     s1(sum, a, b, cy_in);
    carry   c1(cy_out, a, b, cy_in);
    
endmodule