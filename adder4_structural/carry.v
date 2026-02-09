module carry( cy_out, a, b, cy_in);
    input a, b, cy_in;
    output cy_out;
    wire t1, t2, t3;

    and g1(t1, a, b);
    and g2(t2, a, cy_in);
    and g3(t3, b, cy_in);
    or  g4(cy_out, t1, t2, t3);
    
endmodule