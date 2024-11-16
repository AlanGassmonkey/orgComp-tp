`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1ns / 1ps

module aluDeco_tb();

    // Parámetro de duración de la simulación
    parameter DURATION = 100;

    // Entradas del módulo
    reg [1:0] aluOp_tb;
    reg [2:0] funct3_tb;
    reg [6:0] op_tb;      // Para simplificar, consideramos solo los bits relevantes de op (f7 y op[1:0])
    reg [6:0] f7_tb;            // Bit de funct7 para distinguir operaciones

    // Salida del módulo
    wire [2:0] aluControl_tb;

    // Instancia del módulo aluDeco
    aluDeco UUT (
        .aluOp(aluOp_tb),
        .f3(funct3_tb),
        .op(op_tb),
        .f7(f7_tb),
        .aluControl(aluControl_tb)
    );

    // Testbench
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, aluDeco_tb);

        // Prueba de las combinaciones en la tabla
        // Formato: ALUOp | Funct3 | op, funct7 | aluControl esperado

        // Caso 1: ALUOp = 00 (Suma para lw/sw)
        aluOp_tb = 2'b00; funct3_tb = 3'bxxx; op_tb = 2'bxx; f7_tb = 1'bx;
        #1;
      
        // Caso 2: ALUOp = 01 (Resta para beq)
        aluOp_tb = 2'b01; funct3_tb = 3'bxxx; op_tb = 2'bxx; f7_tb = 1'bx;
        #1;
       

        // Caso 3: ALUOp = 10, Funct3=000, op=00 (Suma R-type)
        aluOp_tb = 2'b10; funct3_tb = 3'b000; op_tb = 2'b00; f7_tb = 1'b0;
        #1;
      

        // Caso 4: ALUOp = 10, Funct3=000, op=11 (Resta R-type)
        aluOp_tb = 2'b10; funct3_tb = 3'b000; op_tb = 2'b11; f7_tb = 1'b1;
        #1;
        

        // Caso 5: ALUOp = 10, Funct3=010 (Set Less Than SLT)
        aluOp_tb = 2'b10; funct3_tb = 3'b010; op_tb = 2'bxx; f7_tb = 1'bx;
        #1;
      

        // Caso 6: ALUOp = 10, Funct3=110 (OR)
        aluOp_tb = 2'b10; funct3_tb = 3'b110; op_tb = 2'bxx; f7_tb = 1'bx;
        #1;
      

        // Caso 7: ALUOp = 10, Funct3=111 (AND)
        aluOp_tb = 2'b10; funct3_tb = 3'b111; op_tb = 2'bxx; f7_tb = 1'bx;
        #1;
        

        #(DURATION) $display("End of simulation");
        $finish;
    end

endmodule
