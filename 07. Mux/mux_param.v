// mux_n.v
// Parametric N:1 multiplexer
// Works for any input width and any number of inputs (power of two recommended)

module mux_param #(
    parameter WIDTH = 8,      // bits per input
    parameter N     = 4       // number of inputs
)(
    input  wire [WIDTH-1:0] data [0:N-1], // array of inputs
    input  wire [$clog2(N)-1:0] sel,      // select line
    output reg  [WIDTH-1:0] y             // output
);
    integer i;
    always @(*) begin
        y = {WIDTH{1'b0}};    // default output
        for (i = 0; i < N; i = i + 1) begin
            if (sel == i)
                y = data[i];
        end
    end
endmodule
