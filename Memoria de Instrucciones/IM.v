module  IM(
    input [4:0] addresIM,       // Entrada de direccion del dato
    output wire [31:0] inst     // Salida del dato
);
    reg [31:0] memoria_de_instricciones [0:31];

    //Instrucciones
    initial begin
        $readmemh("../instrucciones.hex", memoria_de_instricciones);
    end

assign inst = memoria_de_instricciones[addresIM];

endmodule


