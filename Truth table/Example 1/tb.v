module top_module;

reg x3, x2, x1;
wire f;
wire ref0;

my_logic dut (
    .x3(x3),
    .x2(x2),
    .x1(x1),
    .f(f)
);

// Reference model
assign ref0 = (~x3 & x1) | (x3 & x2);

integer i;

initial begin
    for (i = 0; i < 8; i = i + 1) begin
        {x3,x2,x1} = i;
        #5;
        if (f !== ref0)
            $display("Mismatch at %b : f=%b ref=%b", i, f, ref0);
        else
            $display("Pass at %0d",i);
    end
    $display("Test finished");
    #100;
    $finish();
end

endmodule