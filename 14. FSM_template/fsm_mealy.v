// fsm_mealy.v
// Mealy-type FSM: outputs may depend on state *and* inputs.
// Synchronous reset, separate next-state and output logic.

module fsm_mealy #(
    parameter integer W = 2
)(
    input  wire clk,
    input  wire rst,     // synchronous, active-high
    // Inputs
    input  wire in_a,
    input  wire in_b,
    // Outputs (Mealy → typically combinational from state & inputs)
    output reg  out_x,
    output reg  out_y
);

    localparam [W-1:0]
        S_IDLE = 0,
        S_RUN  = 1,
        S_ERR  = 2;

    reg [W-1:0] state, state_n;

    // State register
    always @(posedge clk) begin
        if (rst)
            state <= S_IDLE;
        else
            state <= state_n;
    end

    // Next-state logic
    always @* begin
        state_n = state;
        case (state)
            S_IDLE: begin
                if (in_a) state_n = S_RUN;
            end
            S_RUN: begin
                if (!in_a && !in_b) state_n = S_IDLE;
                else if (in_b)      state_n = S_ERR;
            end
            default: begin
                // S_ERR or unknown
                if (!in_b) state_n = S_IDLE;
            end
        endcase
    end

    // Mealy outputs (depend on state and/or inputs)
    always @* begin
        // defaults
        out_x = 1'b0;
        out_y = 1'b0;

        case (state)
            S_IDLE: begin
                // Example: assert out_x immediately when in_a is seen (Mealy behavior)
                if (in_a) out_x = 1'b1;
            end
            S_RUN: begin
                out_x = 1'b1;
                if (in_b) out_y = 1'b1; // output reacts in same cycle as input
            end
            S_ERR: begin
                out_y = 1'b1;
            end
            default: begin
                // safe defaults
            end
        endcase
    end

endmodule
