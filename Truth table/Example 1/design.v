
/*
| Row | x3 | x2 | x1 | f |
| --- | -- | -- | -- | - |
| 0   | 0  | 0  | 0  | 0 |
| 1   | 0  | 0  | 1  | 1 |
| 2   | 0  | 1  | 0  | 0 |
| 3   | 0  | 1  | 1  | 1 |
| 4   | 1  | 0  | 0  | 0 |
| 5   | 1  | 0  | 1  | 0 |
| 6   | 1  | 1  | 0  | 1 |
| 7   | 1  | 1  | 1  | 1 |
*/

module my_logic (
    input  wire x3,
    input  wire x2,
    input  wire x1,
    output wire f
);
        // ~x3 & ~x2 &  x1
    // ~x3 &  x2 &  x1
    //  x3 &  x2 & ~x1
    //  x3 &  x2 &  x1
    assign f = (~x3 & x1) | (x3 & x2);
endmodule
