module Control_Unit_Main_Decoder(
                                 input wire [6:0] Opcode,
                                 output reg RegWrite,
                                 output reg [1:0] ImmSrc,
                                 output reg ALUSrc,
                                 output reg MemWrite,
                                 output reg ResultSrc,
                                 output reg Branch,
                                 output reg [1:0] ALUOp
                                );
        always@(*)begin
                           RegWrite  = 1'b0;
                           ImmSrc    = 2'b00;
                           ALUSrc    = 1'b0;
                           MemWrite  = 1'b0;
                           ResultSrc = 1'b0;
                           Branch    = 1'b0;
                           ALUOp     = 2'b00;
          case(Opcode)
            
            7'b000_0011 : begin
                           RegWrite  = 1'b1;
                           ALUSrc    = 1'b1;
                           ResultSrc = 1'b1;
            end
            7'b010_0011 : begin
                           ImmSrc    = 2'b01;
                           ALUSrc    = 1'b1;
                           MemWrite  = 1'b1;
            end
            7'b011_0011 : begin
                           RegWrite  = 1'b1;
                           ALUOp     = 2'b10;
            end
            7'b001_0011 : begin
                           RegWrite  = 1'b1;
                           ALUSrc    = 1'b1;
                           ALUOp     = 2'b10;
            end
            7'b110_0011 : begin
                           ImmSrc    = 2'b10;
                           Branch    = 1'b1;
                           ALUOp     = 2'b01;
            end
           //I added defult case above

          endcase
        end
endmodule