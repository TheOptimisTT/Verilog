module mux2x1(in,sel,out);
    input   [1:0] in;
    input         sel;
    output        out;

    wire t1, t2, t3;

    not G1 (t1, sel);
    and G2 (t2, in[0], t1);
    and G3 (t3, in[1], sel);
    or  G4 (out, t2, t3);
endmodule


/*
module mux8x4(in,sel,out);
    input   [3:0] A;
    input   [3:0] B;
    input         sel;
    output  [3:0] out;

	mux2x1 m1 (.in({A[0],B[0]}),.sel(sel),.out(out[0]));
	mux2x1 m2 (.in({A[1],B[1]}),.sel(sel),.out(out[1]));
	mux2x1 m3 (.in({A[2],B[2]}),.sel(sel),.out(out[2]));
	mux2x1 m4 (.in({A[3],B[3]}),.sel(sel),.out(out[3]));
endmodule

*/

