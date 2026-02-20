/*
| x3 | x2 | x1 | f |
| -- | -- | -- | - |
| 0  | 0  | 0  | 1 |  // ~x3 & ~x2 & ~x1
| 0  | 0  | 1  | 0 |
| 0  | 1  | 0  | 1 |  // ~x3 &  x2 & ~x1
| 0  | 1  | 1  | 0 |
| 1  | 0  | 0  | 1 |  //  x3 & ~x2 & ~x1
| 1  | 0  | 1  | 1 |  //  x3 & ~x2 &  x1
| 1  | 1  | 0  | 0 |
| 1  | 1  | 1  | 0 |
*/
module my_logic (
    input  wire x3,
    input  wire x2,
    input  wire x1,
    output wire f
);
    assign f = (x3 & ~x2) | (~x3 & ~x1);
endmodule