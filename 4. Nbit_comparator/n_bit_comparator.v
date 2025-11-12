module n_bit_comparator #(
    parameter N = 8
)(
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    output wire          gt,   // 1 if a > b
    output wire          lt,   // 1 if a < b
    output wire          eq    // 1 if a == b
);
    assign gt = (a >  b);
    assign lt = (a <  b);
    assign eq = (a == b);
endmodule

