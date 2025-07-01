module Program_Counter(
                       input wire [31:0] NextPC,
                       input wire areset,clk,Load,
                       output reg [31:0]PC

);

always@(posedge clk or negedge areset ) begin
  
  if(~areset)
   PC <= 32'b0 ;
  else begin
    PC <= (Load == 0) ? PC : NextPC ;
  end

end

endmodule