`timescale 1ns / 1ps
/*
NOTA. ASI COMO ESTAN ACOMODADOS LOS DELAYS ES NECESARIO QUE EL PROGRAMA CORRA POR LO MENOS POR
160 MS PARA QUE SE VISUALICE COMODAMENTE TODOS LOS ESCENARIOS, SOBRE TODO EN VIVADO, EN QUARTUS
QUIERO PENSAR QUE LO MUESTRA COMPLETO.
*/

module pwm_tb;

    reg clk = 0;            // Reloj fake
    reg [7:0] duty_in = 0;  // Ciclo de trabajo
    wire pwm_out;           // Salida del PWM
    reg reset;              // Reset
    reg enable = 0;         // Enable
    reg clk_monitor;        // Monitor del clk lento
    reg en_monitor;         // monitor del enable enclavado
    
    // Instancia del módulo
pwm_base uut (
        .clk(clk),
        .duty_in(duty_in),
        .pwm_out(pwm_out),
        .enable(enable),
        .reset(reset),
        .clk_monitor(clk_monitor),
        .en_monitor(en_monitor)
);
    
 // Reloj simulado
 always #10 clk = ~clk;

initial begin
// Pulso de reset y pulso de enable

        reset = 1'b0;
        #50_000;
        reset = 1'b1;
        #50_000;
        enable = 1'b0;
        #50_000;
        enable = 1'b1;
        #50_000;
// Señales de duty in
        duty_in = 8'd64;   // 25%
        #30_000_000;
        duty_in = 8'd128;  // 50%}
        #30_000_000;
// Pulso de reset y pulso de enable 
        reset = 1'b0;
        #500_000;
        reset = 1'b1;
        #10_000_000;
        enable = 1'b0;
        #50_000;
        enable = 1'b1;
        #50_000;
// Señales de duty in
        duty_in = 8'd192;  // 75%
        #30_000_000;
        duty_in = 8'd255;  // 100%
        #30_000_000; 
        ///////////////////////////////////////////////////////
        $finish;
    end
    
endmodule