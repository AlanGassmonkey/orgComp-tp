`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module Adder_tb();

reg [31:0] op1_tb, op2_tb;     // Entradas de 32 bits
wire [31:0] res_tb;           // Salida de 32 bits

Adder UUT (
    .op1(op1_tb),
    .op2(op2_tb),
    .res(res_tb)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, Adder_tb);

    // Prueba de suma
    op1_tb = 32'd15;
    op2_tb = 32'd10;
    #1;
    op1_tb = 32'd20;
    op2_tb = -32'd5;
    #1;
    op1_tb = 32'd33;
    op2_tb = 32'd11;
    #1;
    op1_tb = 32'd1;
    op2_tb = 32'd10;
    #1;
    op1_tb = 32'd25;
    op2_tb = 32'd999;
    #1;




    $display("End of simulation");
    $finish;
end

endmodule
