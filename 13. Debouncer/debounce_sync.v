// Simple synchronous debouncer for FPGA buttons
module debounce_sync #(
    parameter WIDTH = 20  // filter strength: higher = more debounce time
)(
    input  wire clk,      // system clock
    input  wire rst,      // synchronous reset
    input  wire din,      // noisy input
    output reg  dout      // clean output
);
    reg din_sync0, din_sync1;     // input synchronizers
    reg [WIDTH-1:0] cnt;

    // Synchronize input (avoid metastability)
    always @(posedge clk) begin
        if (rst) begin
            din_sync0 <= 0;
            din_sync1 <= 0;
        end else begin
            din_sync0 <= din;
            din_sync1 <= din_sync0;
        end
    end

    // Debounce counter
    always @(posedge clk) begin
        if (rst) begin
            cnt  <= 0;
            dout <= 0;
        end else begin
            if (din_sync1 == dout) begin
                cnt <= 0; // no change detected, reset counter
            end else begin
                cnt <= cnt + 1'b1;
                if (&cnt) begin  // counter overflow = input stable long enough
                    dout <= din_sync1;
                    cnt  <= 0;
                end
            end
        end
    end
endmodule
