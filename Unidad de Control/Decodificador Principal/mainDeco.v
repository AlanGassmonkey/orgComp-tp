module mainDeco(
    input [6:0] op,               // Opcode para identificar el tipo de instrucción

    output reg branch,            // Señal para saltos condicionales
    output reg [1:0] ResultSrc,   // Control de la fuente del resultado
    output reg memWrite,          // Habilitación de escritura en memoria
    output reg ALUSrc,            // Control de la fuente de la ALU
    output reg [1:0] immSrc,      // Selecciona cómo se extenderá el inmediato 
    output reg regWrite,          // Habilitación de escritura en el banco de registros
    output reg [1:0] ALUOp,       // Control de operación de la ALU
    output reg Jump               //Señal de salto no condicional
);

 always @(*) begin
        // Decodificación según el tipo de instrucción (op)
        case (op)
            7'b1101111: begin // J-type: Jal (Jump and Link)
                regWrite = 1;       
                immSrc = 2'b11;     
                ALUSrc = 1'b0;         //No utiliza el mux pre alu         
                memWrite = 0;       
                ResultSrc = 2'b10;
                branch = 0;
                ALUOp = 2'bxx;  // No usa la alu
                Jump = 1;
            end


            7'b0000011: begin // I-type: lw (Load Word)
                regWrite = 1;
                immSrc = 2'b00;
                ALUSrc = 1;
                memWrite = 0;
                ResultSrc = 2'b01;
                branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end

            7'b0100011: begin // S-type: sw (Store Word)
                regWrite = 0;
                immSrc = 2'b01;
                ALUSrc = 1;
                memWrite = 1;
                ResultSrc = 2'b00; // No importa, ya que no se escribe en registro
                branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end

            7'b0110011: begin // r-type
                regWrite = 1;
                immSrc = 2'b00; // No importa, ya que no se usa inmediato
                ALUSrc = 0;
                memWrite = 0;
                ResultSrc = 2'b00;
                branch = 0;
                ALUOp = 2'b10;
                Jump = 0;
            end
            7'b0010011: begin // I-type: addi 
                regWrite = 1;
                immSrc = 2'b00;
                ALUSrc = 1;
                memWrite = 0;
                ResultSrc = 2'b00;
                branch = 0;
                ALUOp = 2'b10;
                Jump = 0;
            
            end
            7'b1100011: begin // B-type: beq 
                regWrite = 0;
                immSrc = 2'b10;
                ALUSrc = 0;
                memWrite = 0;
                ResultSrc = 2'b00; // No importa, ya que no se escribe en registro
                branch = 1;
                ALUOp = 2'b01;
                Jump = 0;
            end

            default: begin
                // Valores por defecto para instrucciones no reconocidas
                regWrite = 0;
                immSrc = 2'b00;
                ALUSrc = 0;
                memWrite = 0;
                ResultSrc = 2'b00;
                branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end
        endcase
    

 end

 endmodule