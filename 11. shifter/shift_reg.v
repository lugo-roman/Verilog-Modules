// shift_reg.v
// Parametric shift register with enable, sync reset, and optional parallel load.
// DIR = 0: shift right  (MSB <= serial_in, LSB -> serial_out)
// DIR = 1: shift left   (LSB <= serial_in, MSB -> serial_out)

module shift_reg #(
    parameter WIDTH = 8,
    parameter DIR   = 0   // 0=right, 1=left
)(
    input  wire                 clk,
    input  wire                 rst,        // synchronous, active-high
    input  wire                 en,         // shift enable
    input  wire                 load,       // parallel load
    input  wire [WIDTH-1:0]     par_in,     // parallel data in (used when load=1)
    input  wire                 serial_in,  // serial data input
    output reg  [WIDTH-1:0]     q,          // parallel data out (register contents)
    output wire                 serial_out  // serial data output (shifted-out bit)
);

    assign serial_out = (DIR==0) ? q[0] : q[WIDTH-1];

    always @(posedge clk) begin
        if (rst) begin
            q <= {WIDTH{1'b0}};
        end else if (load) begin
            q <= par_in;
        end else if (en) begin
            if (DIR==0) begin
                // Shift right
                q <= {serial_in, q[WIDTH-1:1]};
            end else begin
                // Shift left
                q <= {q[WIDTH-2:0], serial_in};
            end
        end
    end
endmodule
