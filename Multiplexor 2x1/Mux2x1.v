module Mux2x1(
    input [31:0] e1,                // Entrada 1
    input [31:0] e2,                // Entrada 2
    input sel,                      // Selector
    output reg [31:0] salMux        // Salida
);

    always @(*) begin
        if (sel) 
            salMux = e2;       // Si sel es 1, la salida es e2
        else
            salMux = e1;       // Si sel es 0, la salida es e1
    end

endmodule
