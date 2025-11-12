
/*************** Decoder para display 7 seg ****************/

// seg = {a,b,c,d,e,f,g}
module seg7_decoder
#(parameter SEG_ACTIVE_LOW = 1)
(
    input  wire [3:0] bcd,
    output reg  [6:0] seg
);
    reg [6:0] raw; // activo en alto (común cátodo) como base
    always @* begin
        case (bcd)
            4'd0: raw=7'b1111110; 4'd1: raw=7'b0110000; 4'd2: raw=7'b1101101;
            4'd3: raw=7'b1111001; 4'd4: raw=7'b0110011; 4'd5: raw=7'b1011011;
            4'd6: raw=7'b1011111; 4'd7: raw=7'b1110000; 4'd8: raw=7'b1111111;
            4'd9: raw=7'b1111011; default: raw=7'b0000001; // guion (solo g)
        endcase
    end
    always @* seg = SEG_ACTIVE_LOW ? ~raw : raw;
endmodule 



