`timescale 1ns / 1ps

module add4_tb();
    reg [3:0] x, y;
    reg cy_in;
    wire [3:0] s;
    wire cy4;
    
    add4 dut (
        .s(s),
        .cy4(cy4),
        .cy_in(cy_in),
        .x(x),
        .y(y)
    );
    
    initial begin
        $display("4-Bit Adder Testbench");
        $display("====================");
        $display("X    Y    Cy_In | Sum  Cy_Out | Expected");
        $display("----- ----- ----- | ---- ------- | ----------");
        
        // Test case 1: 0 + 0 + 0
        x = 4'b0000; y = 4'b0000; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 0000  0", x, y, cy_in, s, cy4);
        
        // Test case 2: 5 + 3 + 0 (0101 + 0011 + 0)
        x = 4'b0101; y = 4'b0011; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 1000  0", x, y, cy_in, s, cy4);
        
        // Test case 3: 7 + 7 + 0 (0111 + 0111 + 0) = 14
        x = 4'b0111; y = 4'b0111; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 1110  0", x, y, cy_in, s, cy4);
        
        // Test case 4: 15 + 0 + 0 (overflow, result should be 15 with no carry)
        x = 4'b1111; y = 4'b0000; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 1111  0", x, y, cy_in, s, cy4);
        
        // Test case 5: 15 + 1 + 0 (overflow, should wrap to 0 with carry out)
        x = 4'b1111; y = 4'b0001; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 0000  1", x, y, cy_in, s, cy4);
        
        // Test case 6: 8 + 8 + 0 (overflow, should be 0 with carry)
        x = 4'b1000; y = 4'b1000; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 0000  1", x, y, cy_in, s, cy4);
        
        // Test case 7: 3 + 4 + 1 (with carry in)
        x = 4'b0011; y = 4'b0100; cy_in = 1'b1;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 1000  0", x, y, cy_in, s, cy4);
        
        // Test case 8: 15 + 15 + 1 (maximum + maximum + carry)
        x = 4'b1111; y = 4'b1111; cy_in = 1'b1;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 1111  1", x, y, cy_in, s, cy4);
        
        // Test case 9: 10 + 5 + 0
        x = 4'b1010; y = 4'b0101; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 1111  0", x, y, cy_in, s, cy4);
        
        // Test case 10: 12 + 5 + 0 (overflow test)
        x = 4'b1100; y = 4'b0101; cy_in = 1'b0;
        #10;
        $display("%04b  %04b  %1b    | %04b  %1b     | 0001  1", x, y, cy_in, s, cy4);
        
        #10;
        $display("====================");
        $display("Test Complete");
        $finish;
    end

endmodule
