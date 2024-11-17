`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1ns / 1ps

module UC_tb;

    // Definición de señales de entrada
    reg [6:0] op;           // Opcode
    reg [2:0] f3;           // Función f3
    reg [6:0]f7;            // Función f7
    reg zero;               // Señal de cero

    // Definición de señales de salida
    wire branch;
    wire pcSrc;             // Control de la fuente del PC
    wire [1:0] resSrc;      // Control de la fuente del resultado
    wire memWrite;          // Habilitación de escritura en memoria
    wire [2:0] ALUcontrol;  // Control de operación de la ALU
    wire aluSrc;            // Control de la fuente de la ALU
    wire [1:0] immSrc;      // Fuente del inmediato
    wire regWrite;          // Habilitación de escritura en el banco de registros

    UC uut (
        .op(op),
        .f3(f3),
        .f7(f7),
        .zero(zero),
        .branch(branch),
        .pcSrc(pcSrc),
        .ResultSrc(resSrc),
        .memWrite(memWrite),
        .ALUcontrol(ALUcontrol),
        .aluSrc(aluSrc),
        .immSrc(immSrc),
        .regWrite(regWrite)
    );

    // Generar señales de entrada
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, UC_tb);

        // Inicializar señales
        op = 7'b0000000;
        f3 = 3'b000;
        f7 = 1'b0;
        zero = 1'b0;
        #1;

        // Prueba 1
        op = 7'b0000001; 
        f3 = 3'b010; 
        f7 = 1'b1; 
        zero = 1'b0; 
        #1; 

        // Prueba 2
        op = 7'b0000010; 
        f3 = 3'b100; 
        f7 = 1'b0; 
        zero = 1'b1; 
        #1; 

        // Prueba 3
        op = 7'b0000100; 
        f3 = 3'b101; 
        f7 = 1'b1; 
        zero = 1'b0; 
        #1; 
        
        $display("End of simulation");
        $finish;
    end
endmodule
