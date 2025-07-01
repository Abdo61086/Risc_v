module Instruction_Memory #(parameter ROM_WIDTH = 32 ,ROM_DEPTH = 64 )
                          (
                           input wire  [31:0] address ,
                           output reg [31:0] Instr
                          );

        reg  [ ROM_WIDTH-1 : 0 ]  mem  [ 0 : ROM_DEPTH - 1 ] ;   

        always@(*) begin
          Instr = mem[address[31:2]];
        end
        initial begin
          $readmemh("program.txt",mem);
        end
endmodule