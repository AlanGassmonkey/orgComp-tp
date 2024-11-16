module Adder(
    input [31:0] op1,           // Operando A
    input [31:0] op2,           // Operando B
    output reg [31:0] res       // Resultado de la operación
);

    always @(*) begin
        res = op1 + op2;
    end

endmodule
