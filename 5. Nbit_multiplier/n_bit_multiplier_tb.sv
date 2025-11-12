`timescale 1ns/1ps

module n_bit_multplier_tb;

    localparam N = 8;

    logic [N-1:0] a, b;
    logic [2*N-1:0] prod;

    n_bit_multiplier #(.N(N)) dut (
        .a(a),
        .b(b),
        .prod(prod)
    );

    initial begin
        $display("   a     b  |  prod (decimal)  | expected | result");
        $display("----------------------------------------------------");

        test_case(8'd5,   8'd3);
        test_case(8'd10,  8'd10);
        test_case(8'd15,  8'd2);
        test_case(8'd25,  8'd4);
        test_case(8'd255, 8'd2);
        test_case(8'd12,  8'd13);

        $display("\nSimulation finished.");
        $finish;
    end

    task test_case(input [N-1:0] ta, tb);
        logic [2*N-1:0] exp_prod;
        string result;
        begin
            a = ta; b = tb;
            #1;
            exp_prod = a * b;
            result = (prod === exp_prod) ? "PASS" : "FAIL";
            $display(" %4d  %4d |      %6d       |  %6d  | %s",
                     a, b, prod, exp_prod, result);
        end
    endtask

endmodule

