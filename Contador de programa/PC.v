module PC(
    input clk,                  // Reloj
    input reset,                // Reset
    input [31:0] pcNext,        // Entrada de datos
    output reg [31:0] pc        // Salida del registro

);
    initial pc = 32'd0;

    // Bloque secuencial para actualizar el registro PC
    always @(posedge clk or posedge reset) begin
        if(reset)
            pc <= 0;
        else
            pc <= pcNext;
    end
endmodule