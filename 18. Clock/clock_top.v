
/*************** TOP DEL RELOJ ****************/

module clock_top
#(
    parameter integer INPUT_HZ      = 50_000_000, // Frecuencia del reloj utilizado
    parameter        SEG_ACTIVE_LOW = 1 // 1-> Anodo comun, 0-> Catodo comun
)
(
    input  wire clk,  
    input  wire rst,  // Reset sincrono
    output wire [6:0] seg_h_tens,
    output wire [6:0] seg_h_ones,
    output wire [6:0] seg_m_tens,
    output wire [6:0] seg_m_ones,
    output wire [6:0] seg_s_tens,
    output wire [6:0] seg_s_ones
);	
	
// Instancia del divisor de frecuencia

wire tick_1hz; 
freq_div #(.DIVIDE(INPUT_HZ)) u_div1hz (.clk(clk), .rst(rst), .tick(tick_1hz));

// Instancia del core (Aqui hace la conexion en castada de segundos, minutos, horas)
	 
 wire [3:0] h_t, h_o, m_t, m_o, s_t, s_o;
 clock_core u_core (
	  .clk(clk), .rst(rst), .tick_1hz(tick_1hz),
	  .h_tens(h_t), .h_ones(h_o), // horas en binario
	  .m_tens(m_t), .m_ones(m_o), // minutos en binario
	  .s_tens(s_t), .s_ones(s_o)	// segundos en binario
 );

// Instancia del decoder para visualizar los numeros en los displays

seg7_decoder #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW)) d5 (.bcd(h_t), .seg(seg_h_tens));
seg7_decoder #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW)) d4 (.bcd(h_o), .seg(seg_h_ones));
seg7_decoder #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW)) d3 (.bcd(m_t), .seg(seg_m_tens));
seg7_decoder #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW)) d2 (.bcd(m_o), .seg(seg_m_ones));
seg7_decoder #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW)) d1 (.bcd(s_t), .seg(seg_s_tens));
seg7_decoder #(.SEG_ACTIVE_LOW(SEG_ACTIVE_LOW)) d0 (.bcd(s_o), .seg(seg_s_ones));
 
endmodule



