// shift_reg_universal.v
// Universal shift register: hold / shift R / shift L / parallel load

module shift_reg_universal #(
    parameter WIDTH = 8
)(
    input  wire                 clk,
    input  wire                 rst,        // synchronous, active-high
    input  wire [1:0]           mode,       // 00=hold, 01=R, 10=L, 11=load
    input  wire [WIDTH-1:0]     par_in,     // parallel data in
    input  wire                 serial_in_L, // serial in for left shift (into LSB)
    input  wire                 serial_in_R, // serial in for right shift (into MSB)
    output reg  [WIDTH-1:0]     q,
    output wire                 serial_out_L, // bit shifted out at MSB when shifting left
    output wire                 serial_out_R  // bit shifted out at LSB when shifting right
);

    assign serial_out_L = q[WIDTH-1]; // MSB out on left shift
    assign serial_out_R = q[0];       // LSB out on right shift

    always @(posedge clk) begin
        if (rst) begin
            q <= {WIDTH{1'b0}};
        end else begin
            case (mode)
                2'b00: q <= q;                                         // hold
                2'b01: q <= {serial_in_R, q[WIDTH-1:1]};               // shift right
                2'b10: q <= {q[WIDTH-2:0], serial_in_L};               // shift left
                2'b11: q <= par_in;                                    // parallel load
                default: q <= q;
            endcase
        end
    end
endmodule
