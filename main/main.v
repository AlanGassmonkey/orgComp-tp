`include "..\Procesador RV32I\rv32i.v"
`include "..\Memoria de Instrucciones\IM.v"
`include "..\Memoria de Datos\DM.v"



module main(
    input clk,
    input reset
);

wire [31:0] instruccion;
wire [31:0] ReadData;
wire [31:0] rd2;
wire [31:0] pc;
wire [31:0] ALUResult;
//Memoria de Datos

DM memoria_datos (
    .clk(clk),
    .addresDM(ALUResult[6:2]),   //         //Equivalente a dividir por 4 
    .wd(rd2),                   //
    .we(MemWrite),
    .rd(ReadData)               //
);


//Memoria de instrucciones
IM memoria_instruccion (
    .addresIM( pc[6:2] ),         //        //Equivalente a dividir por 4 
    .inst(instruccion)
);


//Procesador
rv32i Procesador (
    .clk(clk),
    .reset(reset),
    .instruccion(instruccion),
    .ReadData(ReadData),
    .rd2(rd2),
    .pc(pc),
    .ALUResult(ALUResult),
    .MemWrite(MemWrite)
);

endmodule