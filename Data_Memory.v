module Data_Memory #(parameter DATA_WIDTH = 32, DATA_DEPTH=32,ADDR_DEPTH = 64)
(
                input wire WE,
                input wire clk,
                input wire [31:0]A,
                input wire [31:0]WD,
                output  [31:0]RD
);

reg [DATA_WIDTH-1 : 0] data_memory [0 : ADDR_DEPTH -1];

always@(posedge clk) begin
  
  if(WE) begin
    data_memory[A[31:2]] <= WD;
  end

end
assign RD = data_memory[A[31:2]];

endmodule