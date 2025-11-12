module freq_div_tb;

reg clk = 0;
reg clk_div = 0;
reg reset;
reg clk_out;

always #10 clk = ~clk;
 
freq_divider divider(
    .clk_in(clk),
    .reset(reset), 
    .clk_out(clk_div)
);

assign clk_out = clk_div;

endmodule