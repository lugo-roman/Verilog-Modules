`timescale 1ns/1ps

module tb_subtractor_nbit;

    // Parameter (you can change this for other widths)
    localparam N = 8;

    // Testbench signals
    logic [N-1:0] a, b;
    logic bin;
    logic [N-1:0] diff;
    logic bout;

    // DUT instantiation
    n_bit_subtractor #(.N(N)) dut (
        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)
    );

    // Test procedure
    initial begin
        $display("   a     b   bin |  diff  bout | expected_diff expected_bout | result");
        $display("---------------------------------------------------------------------");

        // Vector tests
        test_vector(8'd10, 8'd5,  1'b0);  // 10 - 5
        test_vector(8'd10, 8'd10, 1'b0);  // 10 - 10
        test_vector(8'd5,  8'd10, 1'b0);  // 5 - 10
        test_vector(8'd0,  8'd1,  1'b1);  // 0 - 1 - borrow
        test_vector(8'd255,8'd1,  1'b0);  // 255 - 1
        test_vector(8'd128,8'd127,1'b0);  // 128 - 127
        test_vector(8'd85, 8'd170,1'b1);  // 85 - 170 - borrow

        $display("\nSimulation finished.");
        $finish;
    end

    // Task to automate testing
    task test_vector(input [N-1:0] ta, tb, input tbin);
        logic [N:0] expected;
        logic [N-1:0] exp_diff;
        logic exp_bout;
        string result;

        begin
            a = ta; b = tb; bin = tbin;
            #1; // allow propagation

            expected = {1'b0, a} - {1'b0, b} - bin;
            exp_diff = expected[N-1:0];
            exp_bout = expected[N];

            result = ((diff === exp_diff) && (bout === exp_bout)) ? "PASS" : "FAIL";

            $display(" %4d  %4d   %0b  |  %4d    %0b   |     %4d             %0b          | %s",
                     a, b, bin, diff, bout, exp_diff, exp_bout, result);
        end
    endtask

endmodule
