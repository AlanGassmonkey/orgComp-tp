`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module rv32i_tb();

parameter DURATION = 3000;
reg clk = 0;
always #0.5 clk = ~clk;

    rv32i UUT (
        .clk(clk)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, rv32i_tb);

        #100
        $display("End of simulation");
        $finish;
    end

endmodule
