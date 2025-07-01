module Next_PC_logic(
                      input wire [31:0] PC,ImmExt,
                      input wire PCSrc,
                      output reg [31:0] PCNext
);

 always @(*) begin
  PCNext =(PCSrc == 0 ) ? (PC + 4) :(PC + ImmExt);
 end
endmodule