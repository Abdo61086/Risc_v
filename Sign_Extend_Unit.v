module Sign_Extend (
    input wire [31:0] Instr,         
    input wire [1:0] ImmSrc,         
    output reg [31:0] ImmExt         
);

    always @(*) begin
        case (ImmSrc)
            2'b00: begin 
                ImmExt = {{20{Instr[31]}}, Instr[31:20]};
            end

            2'b01: begin 
                ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
            end

            2'b10: begin 
                ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
            end

            default: ImmExt = 32'b0;
        endcase
    end

endmodule

