`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module rv32i_tb();

parameter DURATION = 3000;
reg clk = 0;
reg reset = 0; 
always #0.5 clk = ~clk;

reg [31:0] instruccion_tb;
reg [31:0] ReadData_tb;
wire [31:0] rd2_tb;
wire [31:0] pc_tb;
wire [31:0] ALUResult_tb;
wire memWrite_tb;

rv32i UUT (
    .clk(clk),
    .reset(reset),
    .instruccion(instruccion_tb),
    .ReadData(ReadData_tb),
    .rd2(rd2_tb),
    .pc(pc_tb),
    .ALUResult(ALUResult_tb),
    .MemWrite(memWrite_tb)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, rv32i_tb);

    // Prueba 1: Reset del procesador
    reset = 1; 
    #1 
    reset = 0; 
    #1;

    // Prueba 2: Carga datos ADDI, Prueba ALUResult, 
    instruccion_tb = 32'h00300413;      // ADDI x8, x0, 3
    #1;
    instruccion_tb = 32'h00100493;      // ADDI x9, x0, 1
    #1;

    // Prueba 3: OR para verificar rd2 y ALUResult 
    instruccion_tb = 32'h009462b3;      // OR x5, x8, x9
    #1;

    // Prueba 4: Escritura en memoria (SW) prueba MemWrite, ALUResult y rd2
    instruccion_tb = 32'h00802023;      //SW x8, 0(x0)
    #1;

    $display("End of simulation");
    $finish;
    end

endmodule
