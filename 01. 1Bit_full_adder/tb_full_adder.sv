`timescale 1ns/1ps

module tb_full_adder;

    logic a, b, cin;
    logic sum, cout;
    logic exp_sum, exp_cout;
    string result;

    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );


    
endmodule
