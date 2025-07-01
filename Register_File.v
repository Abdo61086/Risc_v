module Register_File #(parameter ADDR_WIDTH = 32 , ADDR_DEPTH =32 )
                    (
                        input wire clk,WE3,rst,
                        input wire [4:0] A1,A2,A3,
                        input wire [31:0] WD3,
                        output  [31:0] RD1,RD2
                    );
        reg [ADDR_WIDTH-1 : 0] reg_file [0 : ADDR_DEPTH-1];

        
        integer i=0;
        always@(posedge clk or negedge rst ) begin
          if(!rst)begin
          for(i=0;i<ADDR_DEPTH;i=i+1)begin
             reg_file[i] <= 0;
          end
          end
          else begin
            if( WE3 &&  (A3 != 5'b0 )) begin
             reg_file[A3] <= WD3;
            end
             
          end
        end
        assign RD1 = (A1==5'b0 )? 32'b0 : reg_file[A1];
        assign RD2 = (A2==5'b0 )? 32'b0 : reg_file[A2];
endmodule
