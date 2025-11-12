`timescale 1ns/1ps

module n_bit_comparator_tb;

    localparam N = 8;

    logic [N-1:0] a, b;
    logic gt, lt, eq;

    n_bit_comparator #(.N(N)) dut (
        .a(a), .b(b),
        .gt(gt), .lt(lt), .eq(eq)
    );

    initial begin
        $display("   a     b  | gt lt eq | expected_gt expected_lt expected_eq | result");
        $display("---------------------------------------------------------------------");

        test_case(8'd5,   8'd3);
        test_case(8'd3,   8'd5);
        test_case(8'd10,  8'd10);
        test_case(8'd255, 8'd0);
        test_case(8'd0,   8'd255);

        $display("\nSimulation finished.");
        $finish;
    end

    task test_case(input [N-1:0] ta, tb);
        logic exp_gt, exp_lt, exp_eq;
        string result;

        begin
            a = ta; b = tb; #1;
            exp_gt = (a > b);
            exp_lt = (a < b);
            exp_eq = (a == b);
            result = ((gt === exp_gt) && (lt === exp_lt) && (eq === exp_eq)) ? "PASS" : "FAIL";

            $display(" %4d  %4d |  %0b  %0b  %0b |     %0b           %0b           %0b      | %s",
                     a, b, gt, lt, eq, exp_gt, exp_lt, exp_eq, result);
        end
    endtask

endmodule
