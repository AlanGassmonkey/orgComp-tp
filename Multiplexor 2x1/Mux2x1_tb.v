`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module Mux2x1_tb();

reg [31:0] e1_tb, e2_tb;        // Entradas de 32 bits
reg sel_tb;                     //selector
wire [31:0] salMux_tb;          // Salida de 32 bits

Mux2x1 UUT(
    .e1(e1_tb),
    .e2(e2_tb),
    .sel(sel_tb),
    .salMux(salMux_tb)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, Mux2x1_tb);

    // Prueba de suma
    sel_tb=0;
    e1_tb = 32'd15;
    e2_tb = 32'd10;

    #1;
    sel_tb=1;
    e1_tb = 32'd20;
    e2_tb = 32'd5;
    #1;
    sel_tb=1;
    e1_tb = 32'd33;
    e2_tb = 32'd11;
    #1;
    sel_tb=0;
    e1_tb = 32'd1;
    e2_tb = 32'd10;
    #1;
    sel_tb=0;
    e1_tb = 32'd25;
    e2_tb = 32'd999;
    #1;




    $display("End of simulation");
    $finish;
end

endmodule
