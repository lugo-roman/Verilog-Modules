// Simple asynchronous debouncer (not clocked)
module debounce_async (
    input  wire din,       // noisy button input
    output reg  dout       // debounced output
);
    reg prev;

    always @(*) begin
        // Output changes only if input stays stable for some time
        if (din == prev)
            dout = din;
        prev = din;
    end
endmodule
