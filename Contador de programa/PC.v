module PC(
    input clk,                  // Reloj
    input [31:0] pcNext,        // Entrada de datos
    output reg [31:0] pc        // Salida del registro
);
initial pc = 32'd0;


    // Bloque secuencial para actualizar el registro
    always @(posedge clk) begin
        pc = pcNext;
    end
endmodule