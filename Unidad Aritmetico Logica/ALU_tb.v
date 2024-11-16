`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module ALU_tb();

    reg [31:0] srcA_tb, srcB_tb;     // Entradas de 32 bits
    reg [2:0] ALUControl_tb;         // Código de control de la ALU
    wire [31:0] result_tb;           // Salida de 32 bits

    ALU UUT (
        .srcA(srcA_tb),
        .srcB(srcB_tb),
        .ALUControl(ALUControl_tb),
        .result(result_tb)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, ALU_tb);

        // Prueba de suma
        srcA_tb = 32'd15;
        srcB_tb = 32'd10;
        ALUControl_tb = 3'b000;
        #10;
        $display("Add: srcA = %d, srcB = %d, result = %d", srcA_tb, srcB_tb, result_tb);

        // Prueba de resta
        srcA_tb = 32'd20;
        srcB_tb = 32'd5;
        ALUControl_tb = 3'b001;
        #10;
        $display("Subtract: srcA = %d, srcB = %d, result = %d", srcA_tb, srcB_tb, result_tb);

        // Prueba de AND
        srcA_tb = 32'h0F0F0F0F;
        srcB_tb = 32'h00FF00FF;
        ALUControl_tb = 3'b010;
        #10;
        $display("AND: srcA = %h, srcB = %h, result = %h", srcA_tb, srcB_tb, result_tb);

        // Prueba de OR
        srcA_tb = 32'h0F0F0F0F;
        srcB_tb = 32'h00FF00FF;
        ALUControl_tb = 3'b011;
        #10;
        $display("OR: srcA = %h, srcB = %h, result = %h", srcA_tb, srcB_tb, result_tb);

        // Prueba de SLT (Set Less Than)
        srcA_tb = 32'd5;
        srcB_tb = 32'd10;
        ALUControl_tb = 3'b101;
        #10;
        $display("SLT: srcA = %d, srcB = %d, result = %d", srcA_tb, srcB_tb, result_tb);

        $display("End of simulation");
        $finish;
    end

endmodule
