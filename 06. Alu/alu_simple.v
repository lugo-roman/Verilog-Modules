// alu_simple.v
// Parametric ALU with 4 basic operations: ADD, SUB, AND, OR
// Pure Verilog-2001, fully combinational, FPGA-ready.

module alu_simple #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] a,    // Operand A
    input  wire [WIDTH-1:0] b,    // Operand B
    input  wire [1:0]       op,   // Operation selector
    output reg  [WIDTH-1:0] y,    // Result
    output reg              z,    // Zero flag
    output reg              n,    // Negative flag (MSB)
    output reg              c,    // Carry flag (for ADD/SUB)
    output reg              bflag // Borrow flag (for SUB)
);

    // Opcodes
    localparam [1:0]
        OP_ADD = 2'b00,
        OP_SUB = 2'b01,
        OP_AND = 2'b10,
        OP_OR  = 2'b11;

    // Intermediate values for ADD/SUB
    reg [WIDTH:0] addx, subx;

    always @* begin
        // Default outputs
        y     = {WIDTH{1'b0}};
        z     = 1'b0;
        n     = 1'b0;
        c     = 1'b0;
        bflag = 1'b0;

        // Perform operations
        case (op)
            OP_ADD: begin
                addx = {1'b0, a} + {1'b0, b};
                y    = addx[WIDTH-1:0];
                c    = addx[WIDTH];       // carry out
            end

            OP_SUB: begin
                subx = {1'b0, a} + {1'b0, ~b} + 1'b1;
                y    = subx[WIDTH-1:0];
                c    = subx[WIDTH];
                bflag = ~subx[WIDTH];     // borrow = ~carry
            end

            OP_AND: y = a & b;
            OP_OR : y = a | b;

            default: y = {WIDTH{1'b0}};
        endcase

        // Common flags
        z = (y == {WIDTH{1'b0}});
        n = y[WIDTH-1];
    end

endmodule
