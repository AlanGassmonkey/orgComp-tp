module SE (
    input [24:0] inm,               // Entrada de inmediato de 25 bits
    input [1:0] src,                // Selección de tipo de operación
    output reg [31:0] inmExt        // Salida extendida de inmediato a 32 bits
);

always @(*) begin
    case (src)
        2'b00: inmExt = {{20{inm[24]}}, inm[24:13]};                                            // Tipo I
        2'b01: inmExt = {{20{inm[24]}}, inm[24:18], inm[4:0]};                                  // Tipo S
        2'b10: inmExt = {{19{inm[24]}}, inm[24], inm[0], inm[23:18], inm[4:1], 1'b0};           // Tipo B
        //3'b11: inmExt = {inm[24:5], 12'b0};                                                   // Tipo U
        2'b11: inmExt = {{11{inm[24]}}, inm[24], inm[12:5], inm[13], inm[23:14], 1'b0};         // Tipo J 
        default: inmExt = 32'b0;                                                                // Valor por defecto
    endcase
end

endmodule