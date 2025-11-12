module n_bit_subtractor #(
    parameter N = 8
)(
    input  wire [N-1:0] a,     // minuend
    input  wire [N-1:0] b,     // subtrahend
    input  wire         bin,   // borrow in
    output wire [N-1:0] diff,  // difference output
    output wire         bout   // borrow out
);
    // Perform subtraction with borrow propagation
    assign {bout, diff} = {1'b0, a} - {1'b0, b} - bin;
endmodule
