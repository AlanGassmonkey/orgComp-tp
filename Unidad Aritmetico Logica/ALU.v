module ALU(
    input signed [31:0] srcA,           // Operando A
    input signed [31:0] srcB,           // Operando B
    input [2:0] ALUControl,             // Código de operación
    output reg [31:0] result,           // Resultado de la operación
    output reg zero                     // Señal si el resultado es 0
);

always @(*) begin
    case(ALUControl)
        3'b000: result = srcA + srcB;                       // Suma
        3'b001: result = srcA - srcB;                       // Resta 
        3'b010: result = srcA & srcB;                       // AND
        3'b011: result = srcA | srcB;                       // OR
        3'b101: result = (srcA < srcB) ? 32'b1 : 32'b0;     // Set Less Than (SLT)
        default: result = 32'b0;                            // Valor por defecto
    endcase
    zero = (result == 1'b0) ? 1'b1 : 1'b0;                  //Señal si el resutado de 0

end

endmodule
