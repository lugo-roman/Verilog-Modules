// counter_ud_n.v
module counter_ud_n #(
    parameter N = 8,
    parameter MODULO = (1 << 8)
)(
    input  wire clk,
    input  wire rst,
    input  wire en,
    input  wire up,          // 1 = count up, 0 = count down
    output reg  [N-1:0] q,
    output reg          tc
);
    wire [N-1:0] last_val = MODULO - 1;
    wire at_top  = (q == last_val);
    wire at_zero = (q == {N{1'b0}});

    always @(posedge clk) begin
        if (rst) begin
            q  <= {N{1'b0}};
            tc <= 1'b0;
        end else if (en) begin
            if (up) begin
                if (at_top) begin
                    q  <= {N{1'b0}};
                    tc <= 1'b1;
                end else begin
                    q  <= q + 1'b1;
                    tc <= 1'b0;
                end
            end else begin
                if (at_zero) begin
                    q  <= last_val;
                    tc <= 1'b1;
                end else begin
                    q  <= q - 1'b1;
                    tc <= 1'b0;
                end
            end
        end else begin
            tc <= 1'b0;
        end
    end
endmodule
