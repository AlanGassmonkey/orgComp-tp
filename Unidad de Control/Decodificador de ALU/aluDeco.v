module aluDeco(
    input [6:0] op,             // Opcode de la instrucción
    input [6:0] f7,             // Función f7 (7 bit)
    input [2:0] f3,             // Función f3 (campo de 3 bits)
    input [1:0] aluOp,          // Control de operación de la ALU desde la Unidad de Control
    output reg [2:0] aluControl // Control de la ALU
);

 always @(*) begin
        // Decodificación según el tipo de instrucción (op)
        case (aluOp)
            2'b00: aluControl = 3'b000;         // Operación de suma: usado para instrucciones de carga (lw) y almacenamiento (sw)
            2'b01: aluControl = 3'b001;         // Operación de resta: usado para instrucciones de salto condicional (beq)
            2'b10: begin                        // Decodificación de instrucciones R-type utilizando los campos f3 y f7 
                case(f3)
                    3'b000:     aluControl = (f7 == 7'b0100000) ? 3'b001 : 3'b000;  // Operación de resta o suma
                    3'b010:     aluControl = 3'b101;                                // Operación de comparación: set less than (slt)
                    3'b110:     aluControl = 3'b011;                                // Operación OR
                    3'b111:     aluControl = 3'b010;                                // Operación AND
                    default:    aluControl = 3'b111;                                // Por defecto
                endcase
            end
            default: aluControl = 3'b111; // Por defecto
        endcase    
    end
endmodule
