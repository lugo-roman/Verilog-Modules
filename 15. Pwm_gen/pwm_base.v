module pwm_base (
    input wire clk,             // Reloj de entrada
    input wire [7:0] duty_in,   // Ciclo de trabajo (0-255)
    input wire reset,           // Reset
    input wire enable,          // Enable
    output reg  pwm_out,        // salida PWM
    output wire clk_monitor,    // Monitor reloj lento (monitor en tb)
    output wire en_monitor      // Monitor en_l(enable enclavado) para tb
);

reg [7:0] counter = 0;  // Registro del contador
reg en_l;               // Registro de enable para enclavar
wire clk_div;           // Cable para reloj lento

// Señales de monitores
assign clk_monitor = clk_div;
assign en_monitor = en_l;

// Instancia del divisor de frecuencia
freq_divider divider(
    .clk_in(clk),
    .reset(reset), 
    .clk_out(clk_div)
);

// Enclavamiento del enable
always @(posedge clk) begin
    if (!reset) begin
        en_l <= 1'b0;
    end else if (!enable)begin
        en_l <= 1'b1;
    end 
end

// PWM sencillo
always @(posedge clk_div) begin
    if (!reset) begin        
        counter <= 8'd0;
        pwm_out <= 1'b0;
    end else if (en_l) begin
        counter <= counter + 8'd1;          // Contador 
        // Casos especiales
        if (duty_in == 8'd0)
            pwm_out <= 1'b0;                // Cuando duty_in es 0 entrega 0 en pwm_out
        else if (duty_in == 8'd255)             
            pwm_out <= 1'b1;                // Cuando duty_in es 255 entrega 1 en pwm_out
        else                                // para evitar un huevo de 1 ciclo de reloj al reinciar en 0 el contador
            pwm_out <= (counter < duty_in); // Entrega 1 mientras contador no llegue al valor del duty_in
    end else begin
        pwm_out <= 1'b0;                    // Valor predeterminado
    end
end

endmodule