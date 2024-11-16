`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module PC_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;

reg [31:0] pcNext_tb;
wire [31:0] pc_tb;

PC UUT (
    .pcNext(pcNext_tb),
    .pc(pc_tb),
    .clk(clk)
);

integer i;

initial begin

    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, PC_tb);

    for (i = 0; i < 4; i = i + 1) begin        
        #1 
        begin
            pcNext_tb = i;
        end
    end

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
