`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module DM_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;

reg [4:0] addresDM_tb;   // Dirección escritura
reg [31:0] wd_tb;        // Dato para escritura
reg we_tb;               // Habilitación de escritura
wire [31:0] rd_tb;       // Dato para Lectura

DM UUT (
    .clk(clk),
    .addresDM(addresDM_tb),
    .wd(wd_tb),
    .we(we_tb),
    .rd(rd_tb)
);



initial begin

    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, DM_tb);
    
    // Inicialización
    we_tb = 0; // Inhabilitar escritura inicialmente
    wd_tb = 32'h00000000; // Inicializar dato de escritura

    // Escritura en la dirección 0
    addresDM_tb = 5'b00000; // Dirección de escritura
    wd_tb = 32'hA5A5A5A5; // Dato a escribir
    we_tb = 1; // Habilitar escritura
    #1; // Esperar un ciclo de reloj

    // Leer la dirección 0
    addresDM_tb = 5'b00000; // Dirección de lectura
    we_tb = 0;
    wd_tb = 32'hFFFF0FFF; // Dato a escribir
    #1; // Esperar un ciclo de reloj
    

    // Escritura en la dirección 1
    addresDM_tb = 5'b00001; // Dirección de escritura
    wd_tb = 32'hDEADBEEF; // Dato a escribir
    we_tb = 1; // Habilitar escritura
    #1; // Esperar un ciclo de reloj

    // Leer la dirección 1
    addresDM_tb = 5'b00001; // Dirección de lectura
    #1; // Esperar un ciclo de reloj
    
    // Escritura en la dirección 2
    addresDM_tb = 5'b00010; // Dirección de escritura
    wd_tb = 32'hFFFFFFFF; // Dato a escribir
    we_tb = 1; // Habilitar escritura
    #1; // Esperar un ciclo de reloj
    
    // Leer la dirección 2
    addresDM_tb = 5'b00010; // Dirección de lectura
    #1; // Esperar un ciclo de reloj
    
    // Escritura en la dirección 3
    addresDM_tb = 5'b00011; // Dirección de escritura
    wd_tb = 32'h12345678; // Dato a escribir
    we_tb = 1; // Habilitar escritura
    #1; // Esperar un ciclo de reloj
    
    // Leer la dirección 3
    addresDM_tb = 5'b00011; // Dirección de lectura
    #1; // Esperar un ciclo de reloj

    // 
    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
