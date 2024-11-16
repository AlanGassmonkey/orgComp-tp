//`include "Decodificador de ALU\aluDeco.v"
//`include "Decodificador Principal\mainDeco.v"
`include "..\Unidad de Control\Decodificador de ALU\aluDeco.v"
`include "..\Unidad de Control\Decodificador Principal\mainDeco.v"


module UC(
    input [6:0] op,               // Opcode para identificar el tipo de instrucción
    input [2:0] f3,               // Función f3 (campo de 3 bits)
    input [6:0] f7,               // Función f7 (7 bit)
    input zero,                   // Señal de cero desde la ALU, indica si el resultado es cero

    output branch,                // Señal para saltos condicionales
    output PCSrc,                 // Control de la fuente del PC
    output [1:0] ResultSrc,       // Control de la fuente del resultado
    output memWrite,              // Habilitación de escritura en memoria
    output [2:0] ALUcontrol,      // Control de operación de la ALU
    output aluSrc,                // Control de la fuente de la ALU
    output [1:0] immSrc,          // Selecciona cómo se extenderá el inmediato
    output regWrite               // Habilitación de escritura en el banco de registros
    
);
wire [1:0] ALUOp_wire;
wire jump;

mainDeco main_decoder (
    .op(op),
    .branch(branch),
    .ResultSrc(ResultSrc),
    .memWrite(memWrite),
    .ALUSrc(aluSrc),
    .immSrc(immSrc),
    .regWrite(regWrite),
    .ALUOp(ALUOp_wire),
    .Jump(jump)
);

aluDeco alu_decoder (
    .aluOp(ALUOp_wire),
    .f3(f3),
    .op(op),
    .f7(f7),
    .aluControl(ALUcontrol)
);

assign PCSrc = (zero & branch) | jump;

endmodule