`timescale 1ns/1ps
module tb_alu_simple;

    localparam W = 8;

    logic [W-1:0] a, b;
    logic [1:0]   op;
    logic [W-1:0] y;
    logic z, n, c, bflag;

    alu_simple #(.WIDTH(W)) dut (
        .a(a), .b(b), .op(op),
        .y(y), .z(z), .n(n), .c(c), .bflag(bflag)
    );

    localparam [1:0]
        OP_ADD = 2'b00,
        OP_SUB = 2'b01,
        OP_AND = 2'b10,
        OP_OR  = 2'b11;

    task run(input [W-1:0] ta, tb, input [1:0] top, string name);
        begin
            a=ta; b=tb; op=top; #1;
            $display("%s: a=%0d b=%0d -> y=%0d | Z=%0b N=%0b C=%0b B=%0b",
                     name, a, b, y, z, n, c, bflag);
        end
    endtask

    initial begin
        $display("ALU (4-op) quick test\n");
        run(8'd10, 8'd3,  OP_ADD, "ADD");
        run(8'd3,  8'd10, OP_SUB, "SUB");
        run(8'd12, 8'd5,  OP_AND, "AND");
        run(8'd12, 8'd5,  OP_OR,  "OR");
        $finish;
    end

endmodule
