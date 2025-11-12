
/*************** Contador de 0 a 59 ****************/

module bcd_counter_00_59(
    input  wire clk,
    input  wire rst,
    input  wire en,
    output reg  [3:0] tens,
    output reg  [3:0] ones,
    output wire carry
);
    assign carry = en && (tens==4'd5) && (ones==4'd9);

    always @(posedge clk) begin
        if (rst) begin
            tens <= 4'd0; 
            ones <= 4'd0;
        end else if (en) begin
            if (ones == 4'd9) begin // si llega a 9 lo reinicia a 0
                ones <= 4'd0;
                if (tens == 4'd5) begin
                    tens <= 4'd0;       // si llega a 5 lo reinicia a 0
                end else begin
                    tens <= tens + 1'b1; 
                end
            end else begin
                ones <= ones + 1'b1;
            end
        end

    end
endmodule





