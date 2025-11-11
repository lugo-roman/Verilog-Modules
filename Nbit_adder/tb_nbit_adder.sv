`timescale 1ns/1ps
module tb_adder_nbit;
    localparam N = 4;
    logic [N-1:0] a, b;
    logic cin;
    logic [N-1:0] sum;
    logic cout;

    n_bit_adder #(.N(N)) dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        foreach (a[i]) begin end // prevent unused warnings
        a=8'b1111; b=8'b0011; cin=0; #1; $display("%b+%b+%0d=%b, cout=%0b", a,b,cin,sum,cout);
        a=8'b1000; b=8'b0001; cin=0; #1; $display("%b+%b+%0d=%b, cout=%0b", a,b,cin,sum,cout);
        a=8'b0110; b=8'b0110; cin=1; #1; $display("%b+%b+%0d=%b, cout=%0b", a,b,cin,sum,cout);
        $finish;
    end
endmodule
