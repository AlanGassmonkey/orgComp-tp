`include "..\Contador de programa\PC.v"
`include "..\Banco de Registros\BR.v"
`include "..\Extension de Signo\SE.v"
`include "..\Unidad Aritmetico Logica\ALU.v"
`include "..\Unidad Aritmetico Logica adder\Adder.v"
`include "..\Multiplexor 2x1\Mux2x1.v"
`include "..\Memoria de Instrucciones\IM.v"
`include "..\Memoria de Datos\DM.v"


module  dataPath(
    input clk,
    input wire PCSrc,                     // Selector mux pre contador de programas
    input wire RegWrite,                  // Habilitación de escritura del Banco de registros
    input wire [1:0] immSrc,              // Selector Extend de inmediato a 32 bits
    input wire ALUsrc,                    // Selector del MUX antes de SRCb de la ALU
    input wire [2:0] ALUControl,          // Código de control de la ALU
    input wire MemWrite,                  // Habilitación de escritura de la Memoria de datos
    input wire [1:0] ResultSrc,           // Selector del MUX pos Memoria de datos
    output wire [31:0] instruccion,       // Salida instruccion de la memoria de instrucciones
    output wire zero                      // Señal de zero desde la ALU
);

//Cables:
wire [31:0] pcNext;                       // Entrada Contador de programas
wire [31:0] pc;                           // Salida Contador de programas

wire [31:0] wd3;                          // Valor de escritura en el Banco de registros
wire [31:0] rd1, rd2;                     // Datos de Salida del Banco de Registros
wire [31:0] srcB;                         // Entradas de 32 bits de la ALU
wire [31:0] ALUResult;                    // Salida de 32 bits de la ALU
wire [31:0] ReadData;                     // Dato para Lectura de la Memoria de datos
wire [31:0] Result;                       // Salida del MUX pos Memoria de datos
wire [31:0] immExt;                       // Salida Extend de inmediato a 32 bits
wire [31:0] PCTarget;                     // Salida del Adder pos Extend
wire [31:0] PCPlus4;                      // Salida del Adder pos Contador de programas
wire [31:0] Result_mux1;                  // Usado para pasar de un dmux 2-1 a 4-1

//Contador de programa
PC contador_programa (
    .pcNext(pcNext),
    .pc(pc),
    .clk(clk)
);

//Memoria de instrucciones
IM memoria_instruccion (
    .addresIM( pc[6:2] ),                 //Equivalente a dividir por 4 
    .inst(instruccion)
);

//Banco de registros
BR banco_registros (
    .clk(clk),
    .a1(instruccion[19:15]),
    .a2(instruccion[24:20]),
    .a3(instruccion[11:7]),
    .wd3(Result),
    .we(RegWrite),
    .rd1(rd1),
    .rd2(rd2)
);

// MUX Pre ALU
Mux2x1 mux_alu(
    .e1(rd2),          
    .e2(immExt),
    .sel(ALUsrc),
    .salMux(srcB)
);


//ALU
ALU alu (
    .srcA(rd1),
    .srcB(srcB),
    .ALUControl(ALUControl),
    .result(ALUResult),
    .zero(zero)
);

//Memoria de Datos
DM memoria_datos (
    .clk(clk),
    .addresDM(ALUResult[6:2]),            //Equivalente a dividir por 4 
    .wd(rd2),
    .we(MemWrite),
    .rd(ReadData)
);

// MUX pos Memoria de datos
Mux2x1 mux_memoria_datos_1(  
    .e1(ALUResult),          
    .e2(ReadData),
    .sel(ResultSrc[0]),
    .salMux(Result_mux1)
);
// MUX pos Memoria de datos
Mux2x1 mux_memoria_datos_2(  
    .e1(Result_mux1),          
    .e2(PCPlus4),
    .sel(ResultSrc[1]),
    .salMux(Result)
);


// Extensor de signo
SE ext (
    .inm(instruccion[31:7]),
    .src(immSrc),
    .inmExt(immExt)
    );

// Adder pos Extend
Adder adder_ext (
    .op1(immExt),
    .op2(pc),
    .res(PCTarget)
);

//Adder pos Contador de programas 
Adder adder_contador_programa (
    .op1(pc),
    .op2(32'd4),                          // Valor '4' Constante              
    .res(PCPlus4)
);

//MUX pre Contador de programas
Mux2x1 mux_contador_programa(
    .e1(PCPlus4),            
    .e2(PCTarget),
    .sel(PCSrc),
    .salMux(pcNext)
);

endmodule

