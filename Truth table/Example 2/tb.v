module top_module;
reg x3, x2, x1;
wire f;
wire ref0;

my_logic dut (.x3(x3), .x2(x2), .x1(x1), .f(f));
assign ref0 = (~x1 & ~x2) | (~x1 & ~x3) | (x3 & ~x2);
integer i;

initial begin
    for (i=0; i<8; i=i+1) begin
        {x3,x2,x1} = i;
        #5;
        if (f !== ref0)
            $display("Mismatch at %d", i);
        else
            $display("Pass at %d", i);
    end
    
    #100;
    $finish();
end

endmodule