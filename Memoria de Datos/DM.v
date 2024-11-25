module DM(
    input clk,
    input [4:0] addresDM,       // Direccion escritura
    input [31:0] wd,            // Dato para escritura
    input we,                   // Habilitacion de escritura
    output wire [31:0] rd       // Dato para Lectura

);
reg [31:0] Memoria_de_Datos [31:0];

//Bloque secuencial para actualizar el registro
always @(posedge clk) begin
    if (we) begin
            Memoria_de_Datos [addresDM]<= wd;
    end
end

assign rd = Memoria_de_Datos[addresDM];
endmodule