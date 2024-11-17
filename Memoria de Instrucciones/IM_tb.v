`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module IM_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;

reg [31:0] addres;
wire [31:0] instruccion;

IM UUT (
    .addresIM(addres[6:2]),
    .inst(instruccion)
);

integer i;

initial begin

    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, IM_tb);

    for (i = 0; i < 128; i = i + 4) begin                                   //30 de 32 Instrucciones cargadas
        #1        
            addres = i;
    end

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
