`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1ns / 1ps

module mainDeco_tb();

    reg [6:0] op_tb;
    wire branch_tb;
    wire [1:0]resSrc_tb;
    wire memWrite_tb;
    wire ALUSrc_tb;
    wire [1:0] inmSrc_tb;
    wire regWrite_tb;
    wire [1:0] ALUOp_tb;

    // Instancia del módulo mainDeco
    mainDeco UUT (
        .op(op_tb),
        .branch(branch_tb),
        .ResultSrc(resSrc_tb),
        .memWrite(memWrite_tb),
        .ALUSrc(ALUSrc_tb),
        .immSrc(inmSrc_tb),
        .regWrite(regWrite_tb),
        .ALUOp(ALUOp_tb)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, mainDeco_tb);

        // Caso LW (load word)
        op_tb = 7'b0000011;
        #1;
    
        // Caso SW (store word)
        op_tb = 7'b0100011;
        #1;
      
        // Caso R-type (operaciones aritmético-lógicas)
        op_tb = 7'b0110011;
        #1;
      
        // Caso BEQ (branch if equal)
        op_tb = 7'b1100011;
        #1;
     

        // Caso default (instrucción no reconocida)
        op_tb = 7'b1111111;
        #1;
        
        $display("Fin de la simulación.");
        $finish;
    end

endmodule
