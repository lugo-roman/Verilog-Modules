module n_bit_multiplier #(
    parameter N = 8
)(
    input  wire [N-1:0] a,     // multiplicand
    input  wire [N-1:0] b,     // multiplier
    output wire [2*N-1:0] prod // full product
);
    assign prod = a * b;
endmodule

