module Control_Unit_ALU_Decoder (
  input wire [1:0] ALUOP,        // ALU Operation type (load/store, branch, R-type, etc.)
  input wire [2:0] funct3,       // Function field from instruction
  input wire op5, funct7,        // Opcode (op5) and additional function (funct7)
  output reg [2:0] ALUcontrol    // Output control signal for the ALU
);

always @(*) begin
  case (ALUOP)
    // Load/Store Operations: Always perform addition
    2'b00: ALUcontrol = 3'b000;

    // Branch Operations: Typically subtraction for comparisons
    2'b01: begin
      case (funct3)
        3'b000, 3'b001, 3'b100: ALUcontrol = 3'b010; // Subtraction for branch instructions
        default: ALUcontrol = 3'b000;                // Default to add (if funct3 isn't valid)
      endcase
    end

    // R-Type Operations
    2'b10: begin
      case (funct3)
        3'b000: begin
          // Add or Subtract based on op5 and funct7
          if ({op5, funct7} == 2'b00 || {op5, funct7} == 2'b01) 
            ALUcontrol = 3'b000; // Add
          else if ({op5, funct7} == 2'b10) 
            ALUcontrol = 3'b010; // Sub
          else 
            ALUcontrol = 3'b000; // Default Add
        end
        3'b001: ALUcontrol = 3'b001; // Shift Left
        3'b100: ALUcontrol = 3'b100; // XOR
        3'b101: ALUcontrol = 3'b101; // Shift Right
        3'b110: ALUcontrol = 3'b110; // OR
        3'b111: ALUcontrol = 3'b111; // AND
        default: ALUcontrol = 3'b000; // Default Add for undefined funct3
      endcase
    end

    // Default ALU operation (Add) for any undefined ALUOP
    default: ALUcontrol = 3'b000;
  endcase
end

endmodule
