`timescale 1ns/1ps

module testbench;
    // Testbench signals
    reg [15:0]  in;
    reg [3:0]   sel;
    wire        out;
    integer     i, j;
    integer     error_count = 0;
    reg [15:0]  test_patterns [3:0];
    
    // Instantiate the mux16x1 module
    mux16x1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        // Define test patterns
        test_patterns[0] = 16'h5555;      // Alternating: 0101010101010101
        test_patterns[1] = 16'hAAAA;      // Alternating: 1010101010101010
        test_patterns[2] = 16'h0001;      // Only bit 0 set
        test_patterns[3] = 16'h8000;      // Only bit 15 set
        
        $display("========================================");
        $display("  16x1 Multiplexer Testbench");
        $display("========================================");
        $display("");
        
        // Test all combinations
        for (j = 0; j < 4; j = j + 1) begin
            in = test_patterns[j];
            $display("Testing with input pattern: 0x%h", in);
            $display("  Sel | Expected | Got | Status");
            $display("  ----|----------|-----|--------");
            
            for (i = 0; i < 16; i = i + 1) begin
                sel = i;
                #1;  // Allow time for combinatorial logic to settle
                
                // Check if selected bit matches output
                if (in[i] == out) begin
                    $display("  %2d | %b        | %b   | PASS", i, in[i], out);
                end else begin
                    $display("  %2d | %b        | %b   | FAIL <-- ERROR!", i, in[i], out);
                    error_count = error_count + 1;
                end
            end
            $display("");
        end
        
        // Summary
        $display("========================================");
        if (error_count == 0) begin
            $display("  ALL TESTS PASSED!");
            $display("  Data is correctly selected from the right lane");
        end else begin
            $display("  TESTS FAILED!");
            $display("  Total errors: %d", error_count);
        end
        $display("========================================");
        
        $finish;
    end
    
endmodule
