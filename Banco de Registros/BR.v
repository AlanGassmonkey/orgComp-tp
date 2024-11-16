module  BR(
    input clk,
    input [4:0] a1,             // Direccion Lectura 1
    input [4:0] a2,             // Direccion Lectura 2
    input [4:0] a3,             // Direccion Escritura
    input [31:0] wd3,           // Dato para escritura
    input we,                   // Habilitacion de escritura
    output wire [31:0] rd1,     // Salida del registro 1
    output wire [31:0] rd2      // Salida del registro 2
);
    reg [31:0] Banco_de_Registros [31:0];

    //Inicializo los registros en 0
    initial begin 
        for(1=0; i<32 ; i = i + 1 )
            Banco_de_Registros[i] = 32'd0;
    end

    
    assign rd1 = Banco_de_Registros [a1];
    assign rd2 = Banco_de_Registros [a2];

    // Bloque secuencial para actualizar el registro
    always @(posedge clk) 
    begin
        if (we && (a3 != 5'd0))                 // Verifico si we=1 y Si no estoy intentado escribir de la direccion zero
        begin
            Banco_de_Registros [a3]<= wd3;
        end
    end

endmodule