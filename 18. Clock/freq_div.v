
/*************** Divisor de frecuencia ****************/

module freq_div
#(parameter integer DIVIDE = 50_000_000) // valor a dividir
(
    input  wire clk,
    input  wire rst,
    output reg  tick
);

// calcula el numeor de bits necesario para representar DIVIDE

function integer CLOG2; input integer v; integer i; begin
  v = v-1; for (i=0; v>0; i=i+1) v = v>>1; CLOG2 = i;
end endfunction

// w es el numeor de bits necesarios

localparam W = (DIVIDE <= 1) ? 1 : CLOG2(DIVIDE);
reg [W-1:0] cnt;

// si cnt llega a DIVIDE-1 se reinicia el contador a 0 y genera nuestro pulso de salid
// si aun no llega sigue incrementado el contador hasta que se cumpla la condicion anteerior.

always @(posedge clk) begin
	if (rst) begin 
		cnt<=0; 
		tick<=1'b0; 
	end else if (cnt == DIVIDE-1) begin 
		cnt<=0; 
		tick<=1'b1; 
	end else begin 
		cnt<=cnt+1'b1; 
		tick<=1'b0; 
	end
end
	 
	 
endmodule




