
/*************** Contador de 1 a 12 ****************/

module bcd_counter_01_12(
    input  wire clk,
    input  wire rst,
    input  wire en,
    output reg  [3:0] tens,
    output reg  [3:0] ones,
    output wire carry
);
    assign carry = en && (tens==4'd1) && (ones==4'd2);

    always @(posedge clk) begin
        if (rst) begin
            tens <= 4'd0; ones <= 4'd1;	// Hora de inicio 
        end else if (en) begin
            if (tens == 4'd1) begin			
                if (ones == 4'd2) begin	// cuando llega a 12 reinicia en 01
                    tens <= 4'd0;
                    ones <= 4'd1;
                end else begin
                    ones <= ones + 1'b1;       
                end
            end else begin
                if (ones == 4'd9) begin  	// si llega a 9, las decenas suma 1
                    tens <= 4'd1;
                    ones <= 4'd0;
                end else begin
                    ones <= ones + 1'b1;      
                end
            end
        end
    end
endmodule


