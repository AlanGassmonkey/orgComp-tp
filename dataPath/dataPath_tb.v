`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps



module dataPath_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;


reg PCSrc;
reg RegWrite;
reg [1:0] immSrc;
reg ALUsrc;
reg [2:0] ALUControl;
reg MemWrite;
reg [1:0] ResultSrc;

// Salidas
wire [31:0] instruccion;
wire zero;

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

    PCSrc = 0;
    RegWrite = 0;
    immSrc = 2'd0;
    ALUsrc = 0;
    ALUControl = 3'd0;
    MemWrite = 0;
    ResultSrc = 2'd0;
    #1;

    PCSrc = 1;
    RegWrite = 1;
    immSrc = 2'd1;
    ALUsrc = 1;
    ALUControl = 3'd1;
    MemWrite = 1;
    ResultSrc = 2'd1;
    #1;


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