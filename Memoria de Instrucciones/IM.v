module  IM(
    input [4:0] addresIM,       // Entrada de direccion del dato
    output wire [31:0] inst     // Salida del dato
);
    reg [31:0] memoria_de_instricciones [0:31];

    //Instrucciones
    initial begin
        memoria_de_instricciones[0] = 32'h00300413;
        memoria_de_instricciones[1] = 32'h00100493;
        memoria_de_instricciones[2] = 32'h01000913;
        memoria_de_instricciones[3] = 32'h009462b3;
        memoria_de_instricciones[4] = 32'h00947333;
        memoria_de_instricciones[5] = 32'h009403b3;
        memoria_de_instricciones[6] = 32'h40940e33;
        memoria_de_instricciones[7] = 32'h40848eb3;
        memoria_de_instricciones[8] = 32'h00942f33;
        memoria_de_instricciones[9] = 32'h0084afb3;
        memoria_de_instricciones[10] = 32'h01d4afb3;
        memoria_de_instricciones[11] = 32'h00100293;
        memoria_de_instricciones[12] = 32'h00000313;
        memoria_de_instricciones[13] = 32'h01228863;
        memoria_de_instricciones[14] = 32'h005282b3;
        memoria_de_instricciones[15] = 32'h00130313;
        memoria_de_instricciones[16] = 32'hff5ff06f;
        memoria_de_instricciones[17] = 32'h000004b3;
        memoria_de_instricciones[18] = 32'h00000293;
        memoria_de_instricciones[19] = 32'h00a00313;
        memoria_de_instricciones[20] = 32'h00628863;
        memoria_de_instricciones[21] = 32'h008484b3;
        memoria_de_instricciones[22] = 32'h00128293;
        memoria_de_instricciones[23] = 32'hff5ff06f;
        memoria_de_instricciones[24] = 32'h00802023;
        memoria_de_instricciones[25] = 32'h00902223;
        memoria_de_instricciones[26] = 32'h01202423;
        memoria_de_instricciones[27] = 32'h00002283;
        memoria_de_instricciones[28] = 32'h00402303;
        memoria_de_instricciones[29] = 32'h00802383;
    end

assign inst = memoria_de_instricciones[addresIM];

endmodule