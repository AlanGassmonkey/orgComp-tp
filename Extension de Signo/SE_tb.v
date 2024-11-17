`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module SE_tb();

    reg [24:0] inm_tb;     // Entrada de inmediato de 25 bits
    reg [1:0] src_tb;      // Selección de tipo de operación
    wire [31:0] inmExt_tb; // Salida extendida de inmediato a 32 bits

    SE UUT (
        .inm(inm_tb),
        .src(src_tb),
        .inmExt(inmExt_tb)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, SE_tb);

        // Prueba de extensión tipo I (positivo y negativo)
        inm_tb = 25'b0000000000010000011000001;  // Positivo
        src_tb = 2'b00;                         // Tipo I
        #1;
        inm_tb = 25'b1111111110101111111111111;  // Negativo
        src_tb = 2'b00;                         // Tipo I
        #1;

        // Prueba de extensión tipo S (positivo y negativo)
        inm_tb = 25'b0000000000000000000000010;  // Positivo
        src_tb = 2'b01;                         // Tipo S
        #1;
        inm_tb = 25'b1111111111111111111111110;  // Negativo
        src_tb = 2'b01;                         // Tipo S
        #1;

        // Prueba de extensión tipo B (positivo y negativo)
        inm_tb = 25'b0000000000000000000000100;     // Positivo
        src_tb = 2'b10;                             // Tipo B
        #1;
        inm_tb = 25'b1111111111111111111111100;     // Negativo
        src_tb = 2'b10;                             // Tipo B
        #1;

        // Prueba de extensión tipo J (positivo y negativo)
        inm_tb = 25'b0000000000000000100000000;     // Positivo
        src_tb = 2'b11;                             // Tipo J
        #1;
        inm_tb = 25'b1111111111111110100000000;     // Negativo
        src_tb = 2'b11;                             // Tipo J
        #1;

        $finish;
    end

endmodule
