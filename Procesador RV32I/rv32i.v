`include "..\dataPath\dataPath.v"
`include "..\Unidad de Control\UC.v"



module rv32i (
    input clk
);



wire pcSrc;
wire regWrite;
wire [1:0] immSrc;
wire ALUsrc;
wire [2:0] ALUControl; 
wire [1:0] ResultSrc;
wire [31:0] instruccion;
wire zero;
wire branch;                  
wire MemWrite;        

dataPath u_datapath (
    .clk(clk),                              // Conexión del reloj
    .PCSrc(pcSrc),                          // Conexión de la señal PCSrc
    .RegWrite(regWrite),                    // Conexión de la señal RegWrite
    .immSrc(immSrc),                        // Conexión del selector de inmediato
    .ALUsrc(ALUsrc),                        // Conexión del selector de ALUsrc
    .ALUControl(ALUControl),                // Conexión del código de control de la ALU
    .MemWrite(MemWrite),                    // Conexión de la señal MemWrite
    .ResultSrc(ResultSrc),                  // Conexión de la señal ResultSrc  
    .instruccion(instruccion),
    .zero(zero)
);
UC unidad_control (
    .op(instruccion[6:0]),                  // Conexión del opcode
    .f3(instruccion[14:12]),                // Conexión de la función f3
    .f7(instruccion[31:25]),                // Conexión de la función f7
    .zero(zero),                            // Conexión de la señal de cero
    .branch(branch),                        // Conexión de la salida branch

    .PCSrc(pcSrc),                          // Conexión de la salida pcSrc
    .ResultSrc(ResultSrc),                  // Conexión de la salida resSrc
    .memWrite(MemWrite),                    // Conexión de la salida memWrite
    .ALUcontrol(ALUControl),                // Conexión de la salida ALUcontrol
    .aluSrc(ALUsrc),                        // Conexión de la salida aluSrc
    .immSrc(immSrc),                        // Conexión de la salida inmSrc
    .regWrite(regWrite)                     // Conexión de la salida regWrite
    );



endmodule
