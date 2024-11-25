`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module PC_tb();

parameter DURATION = 10;

reg clk = 0;
always #0.5 clk = ~clk;

reg [31:0] pcNext_tb;           //PCNEXT            
wire [31:0] pc_tb;              //PC
reg reset_tb;                   //Reset

PC UUT (
    .pcNext(pcNext_tb),
    .pc(pc_tb),
    .clk(clk),
    .reset(reset_tb)
);

initial begin

    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, PC_tb);
    reset_tb = 0 ;
    pcNext_tb = 32'd0;
    #1;
    pcNext_tb = 32'd1;
    #1;
    reset_tb = 1;
    #1;
    reset_tb = 0;
    #1;
    pcNext_tb = 32'd5;
    #1;
    pcNext_tb = 32'd9;
    #1;
    pcNext_tb = 32'd10;
    #1;
    pcNext_tb = 32'd1;
    #1;

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule
