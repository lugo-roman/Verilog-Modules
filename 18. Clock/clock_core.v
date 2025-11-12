
/*************** Contadores en cascada ****************/

module clock_core(
    input  wire clk,
    input  wire rst,
    input  wire tick_1hz,
    output wire [3:0] h_tens, h_ones,
    output wire [3:0] m_tens, m_ones,
    output wire [3:0] s_tens, s_ones
);
    wire carry_s, carry_m, carry_h;

 bcd_counter_00_59 u_sec (
	  .clk(clk), .rst(rst), .en(tick_1hz),
	  .tens(s_tens), .ones(s_ones), .carry(carry_s)
 );

 bcd_counter_00_59 u_min (
	  .clk(clk), .rst(rst), .en(carry_s),
	  .tens(m_tens), .ones(m_ones), .carry(carry_m)
 );

 bcd_counter_01_12 u_hour (
	  .clk(clk), .rst(rst), .en(carry_m),
	  .tens(h_tens), .ones(h_ones), .carry(carry_h)
 );
	 
endmodule 



