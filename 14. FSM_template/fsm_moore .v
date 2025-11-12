// fsm_moore.v
// Moore-type FSM: outputs depend only on current state.
// Synchronous reset, single-process state reg + separate next-state/output logic.

module fsm_moore #(
    parameter integer W = 2  // state width (adjust to fit your states)
)(
    input  wire clk,
    input  wire rst,      // synchronous, active-high
    // Inputs
    input  wire in_a,
    input  wire in_b,
    // Outputs (Moore → registered or combinational from state)
    output reg  out_x,
    output reg  out_y
);

    // 1) State encoding (binary example). Add/remove states as needed.
    localparam [W-1:0]
        S_IDLE = 0,
        S_A    = 1,
        S_B    = 2,
        S_ERR  = 3;   // optional safe state

    // 2) State registers
    reg [W-1:0] state, state_n;

    // 3) State register update
    always @(posedge clk) begin
        if (rst)
            state <= S_IDLE;
        else
            state <= state_n;
    end

    // 4) Next-state combinational logic
    always @* begin
        // default: hold state
        state_n = state;

        case (state)
            S_IDLE: begin
                if (in_a) state_n = S_A;
                else if (in_b) state_n = S_B;
                // else stay in S_IDLE
            end

            S_A: begin
                if (in_b) state_n = S_B;
                else if (!in_a) state_n = S_IDLE;
            end

            S_B: begin
                if (in_a) state_n = S_A;
                else if (!in_b) state_n = S_IDLE;
            end

            default: begin
                state_n = S_ERR; // go to a safe/known state
            end
        endcase
    end

    // 5) Moore outputs (depend only on *state*)
    always @* begin
        // defaults
        out_x = 1'b0;
        out_y = 1'b0;

        case (state)
            S_IDLE: begin
                // out_x = 0; out_y = 0;
            end
            S_A: begin
                out_x = 1'b1;
            end
            S_B: begin
                out_y = 1'b1;
            end
            S_ERR: begin
                // keep outputs safe
            end
            default: begin
                // safe defaults already set
            end
        endcase
    end

endmodule
