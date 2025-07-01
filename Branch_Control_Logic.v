module Branch_Control_Logic(
                            input wire Zero_Flag,
                            input wire Sign_Flag,
                            input wire Branch,
                            input wire [2:0] funct3,
                            output reg PCSrc
);

always@(*)begin
  case(funct3)
   3'b000 : PCSrc = Branch & Zero_Flag;
   3'b001 : PCSrc = Branch & ~Zero_Flag;
   3'b100 : PCSrc = Branch & Sign_Flag;
    default : PCSrc = 1'b0;
  endcase 
end
endmodule