
/*************** Testbech ****************/

`timescale 1us/1us
module tb_clock;
    
reg clk = 0; always #5 clk = ~clk; // 100 kHz
reg rst = 1;

localparam integer SIM_DIVIDE_1HZ = 100; // "1 Hz" simulado = 1 kHz real


// Divisor de frecuencia con frecuencia simulada
 wire tick_1hz_sim;
 freq_div #(.DIVIDE(SIM_DIVIDE_1HZ)) u_div (.clk(clk), .rst(rst), .tick(tick_1hz_sim));

// Tomamos valores en binario desde el core
wire [3:0] h_t, h_o, m_t, m_o, s_t, s_o;
clock_core u_core (	.clk(clk), 
							.rst(rst), 
							.tick_1hz(tick_1hz_sim),
							.h_tens(h_t), 
							.h_ones(h_o), 
							.m_tens(m_t), 
							.m_ones(m_o), 
							.s_tens(s_t), 
							.s_ones(s_o));

// Segundos a simular

localparam integer Segundos = 200;

 integer i;
    initial begin
        #50 rst = 0;
        $display("t(us)\tHH:MM:SS");
        for (i=0; i< Segundos; i=i+1) begin // Cantidad de segundos a simular
            @(posedge tick_1hz_sim);
            $display("%0t\t%0d%0d:%0d%0d:%0d%0d",
                $time, h_t, h_o, m_t, m_o, s_t, s_o);
        end
        $stop;
    end
endmodule


