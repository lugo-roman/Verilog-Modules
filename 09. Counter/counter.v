// counter_n.v
// Generic up-counter with enable, synchronous reset, and wrap (modulo)
// Works on any FPGA (pure combinational + sequential logic)

module counter #(
    parameter N       = 8,           // number of bits
    parameter MODULO  = (1 << 8)     // wrap value (count range 0..MODULO-1)
)(
    input  wire         clk,         // clock input
    input  wire         rst,         // synchronous reset (active high)
    input  wire         en,          // enable counting
    output reg  [N-1:0] q,           // current count
    output reg          tc           // terminal count (1 when wrapping)
);
    // Detect last count before wrapping
    wire at_last = (q == (MODULO - 1));

    always @(posedge clk) begin
        if (rst) begin
            q  <= {N{1'b0}};        // reset counter to 0
            tc <= 1'b0;
        end else if (en) begin
            if (at_last) begin
                q  <= {N{1'b0}};    // wrap around to 0
                tc <= 1'b1;         // pulse high for 1 clock
            end else begin
                q  <= q + 1'b1;     // normal increment
                tc <= 1'b0;
            end
        end else begin
            tc <= 1'b0;             // disabled, hold value
        end
    end
endmodule
