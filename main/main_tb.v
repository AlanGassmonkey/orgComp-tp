`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module main_tb();

parameter DURATION = 3000;
reg clk = 0;
reg reset = 0; 
always #0.5 clk = ~clk;



    main UUT (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, main_tb);

        //Reinicio
        reset = 1;
        #1
        reset = 0;

        //Espero la ejecucion del codigo.
        #50
        reset = 1;
        #1
        reset = 0;
        #100
        $display("End of simulation");
        $finish;
    end

endmodule
