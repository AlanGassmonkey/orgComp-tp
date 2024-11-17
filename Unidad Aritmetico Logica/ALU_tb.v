`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module ALU_tb();

    reg signed [31:0] srcA_tb, srcB_tb;     // Entradas de 32 bits
    reg [2:0] ALUControl_tb;                // Código de control de la ALU
    wire [31:0] result_tb;                  // Salida de 32 bits
    wire zero_tb;
    ALU UUT (
        .srcA(srcA_tb),
        .srcB(srcB_tb),
        .ALUControl(ALUControl_tb),
        .result(result_tb),
        .zero(zero_tb)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, ALU_tb);

        // Prueba de suma
        srcA_tb = 32'd15;
        srcB_tb = 32'd10;
        ALUControl_tb = 3'b000;
        #1;

        // Prueba de suma con negativos
        srcA_tb = -32'd15;
        srcB_tb = 32'd10;
        ALUControl_tb = 3'b000;
        #1;

        // Prueba de resta
        srcA_tb = 32'd20;
        srcB_tb = 32'd5;
        ALUControl_tb = 3'b001;
        #1;

        // Prueba de resta con negativos
        srcA_tb = 32'd20;
        srcB_tb = -32'd5;
        ALUControl_tb = 3'b001;
        #1;

        // Prueba de AND
        srcA_tb = 32'h0F0F0F0F;
        srcB_tb = 32'h00FF00FF;
        ALUControl_tb = 3'b010;
        #1;
       
        // Prueba de OR
        srcA_tb = 32'h0F0F0F0F;
        srcB_tb = 32'h00FF00FF;
        ALUControl_tb = 3'b011;
        #1;
       
        // Prueba de SLT (Set Less Than)
        srcA_tb = 32'd5;
        srcB_tb = 32'd10;
        ALUControl_tb = 3'b101;
        #1;

        // Prueba de SLT (Set Less Than) con negativos
        srcA_tb = 32'd5;
        srcB_tb = -32'd10;
        ALUControl_tb = 3'b101;
        #1;


        $display("End of simulation");
        $finish;
    end

endmodule
