`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps



module dataPath_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;


reg PCSrc;                              // Selector mux pre contador de programas
reg RegWrite;                           // Habilitación de escritura del Banco de registros
reg [1:0] immSrc;                       // Selector Extend de inmediato a 32 bits
reg ALUsrc;                             // Selector del MUX antes de SRCb de la ALU
reg [2:0] ALUControl;                   // Código de control de la ALU
reg MemWrite;                           // Habilitación de escritura de la Memoria de datos
reg [1:0] ResultSrc;                    // Selector del MUX pos Memoria de datos

// Salidas
wire [31:0] instruccion;                // Salida instruccion de la memoria de instrucciones (Para el modulo de Control)
wire zero;                              // Señal de zero desde la ALU

// Instancia del módulo dataPath
dataPath uut (
    .clk(clk),
    .PCSrc(PCSrc),
    .RegWrite(RegWrite),
    .immSrc(immSrc),
    .ALUsrc(ALUsrc),
    .ALUControl(ALUControl),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .instruccion(instruccion),
    .zero(zero)
);


initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, dataPath_tb);

    //Inicializo todo en 0
    PCSrc = 0;
    RegWrite = 0;
    immSrc = 2'd0;
    ALUsrc = 0;
    ALUControl = 3'd0;
    MemWrite = 0;
    ResultSrc = 2'd0;
    #1;

    //Prueba 1
    PCSrc = 1;
    RegWrite = 1;
    immSrc = 2'd1;
    ALUsrc = 1;
    ALUControl = 3'd1;
    MemWrite = 1;
    ResultSrc = 2'd1;
    #1;

    //Prueba 2
    PCSrc = 1;
    RegWrite = 1;
    immSrc = 2'd2;
    ALUsrc = 1;
    ALUControl = 3'd2;
    MemWrite = 1;
    ResultSrc = 2'd1;
    #1;

    #(DURATION) $display("End of simulation");
    $finish;

end

endmodule