`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module BR_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;

reg [4:0] a1_tb,a2_tb,a3_tb;            // Direccion Lectura, Lectura, Escritura        
reg we_tb;                              // Habilitacion Escritura
reg [31:0] wd3_tb;                      // Valor a Escribir

wire [31:0] rd1_tb, rd2_tb;             // Salidas de lectura
BR UUT (
    .clk(clk),
    .a1(a1_tb),
    .a2(a2_tb),
    .a3(a3_tb),
    .wd3(wd3_tb),
    .we(we_tb),
    .rd1(rd1_tb),
    .rd2(rd2_tb)
);



initial begin

    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, BR_tb);

    // Inicialización
    we_tb = 0;                          // Inhabilitar escritura inicialmente
    wd3_tb = 32'h00000000;              // Inicializar datos de escritura
    a1_tb = 5'b00000;
    a2_tb = 5'b00001;
    a3_tb = 5'b00000;
    #1
    
    // Escritura en el registro 0
    a3_tb = 5'b00000;                   // Dirección de escritura
    wd3_tb = 32'hA5A5A5A5;              // Datos a escribir
    we_tb = 1;                          // Habilitar escritura
    #1
    // Lectura de registro 0
    a1_tb = 5'b00000;                   // Leer el registro 0
    a2_tb = 5'b00001;                   // Leer el registro 1
    #1; 

 
    // Escribir en el registro 1
    a3_tb = 5'b00001;                   // Dirección de escritura
    wd3_tb = 32'hDEADBEEF;              // Datos a escribir
    we_tb = 1;                          // Habilitar escritura
    #1
    // Lectura de registro 0 y 1
    a1_tb = 5'b00000;                   // Leer el registro 0
    a2_tb = 5'b00001;                   // Leer el registro 1 
    #1; 


    // Escribir en el registro 2
    a3_tb = 5'b00010;                   // Dirección de escritura
    wd3_tb = 32'hFFFFFFFF;              // Datos a escribir
    we_tb = 1;                          // Habilitar escritura
    #1
    // Lectura de registro 1 y 2
    a1_tb = 5'b00001;                   // Leer el registro 1
    a2_tb = 5'b00010;                   // Leer el registro 2
    #1;                                 // Esperar un ciclo de reloj


    // No Escribir en el registro 2
    a3_tb = 5'b00010;                   // Dirección de escritura
    wd3_tb = 32'hF6FA5F0F;              // Datos a escribir
    we_tb = 0;                          // Deshabilitar escritura
    #1
    a1_tb = 5'b00001;                   // Leer el registro 1
    a2_tb = 5'b00010;                   // Leer el registro 2
    #1;                                 // Esperar un ciclo de reloj



    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
