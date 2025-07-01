module ALU(
           input wire [2:0] ALU_Control,
           input wire [31:0] A,B,
           output reg Zero_Flag,Sign_Flag,
           output reg [31:0] ALU_Result
);

always @(*)begin
  
   case(ALU_Control)
    3'b000:begin 
           ALU_Result = A + B ;
           end
    3'b001:begin 
           ALU_Result = A << B[4:0] ;
           end
    3'b010:begin 
           ALU_Result = A - B ;
           end
    3'b100:begin 
           ALU_Result = A ^ B ;
           end
    3'b101:begin 
           ALU_Result = A >> B[4:0] ;
           end
    3'b110:begin 
           ALU_Result = A | B ;
           end
    3'b111:begin 
           ALU_Result = A & B ;
           end
    default:begin 
           ALU_Result = 32'b0 ;
           end
  endcase

  Zero_Flag = (ALU_Result==0)? 1'b1 : 1'b0;
  Sign_Flag = ALU_Result[31] ;  

end
endmodule