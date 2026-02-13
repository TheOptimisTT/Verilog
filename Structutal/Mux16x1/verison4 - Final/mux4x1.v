module mux4x1(in,sel,out);
    input   [3:0] in;
    input   [1:0] sel;
    output        out;

    wire [1:0] t;
    mux2x1 M0 (in[1:0], sel[0], t[0]);
    mux2x1 M1 (in[3:2], sel[0], t[1]);
    mux2x1 M2 (t      , sel[1], out);

endmodule