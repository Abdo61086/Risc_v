module RISC_V_SingleCycle_Processor (
    input wire clk,
    input wire reset
);

    // ========= PC =========
    wire [31:0] PC, PCNext;
    wire PCSrc;
    wire [31:0] ImmExt; 
    wire [31:0] Result; 
    Program_Counter pc_reg (
        .NextPC(PCNext),
        .areset(reset),
        .clk(clk),
        .Load(1'b1),   
        .PC(PC)
    );

    Next_PC_logic pc_next_logic (
        .PC(PC),
        .ImmExt(ImmExt),
        .PCSrc(PCSrc),
        .PCNext(PCNext)
    );

    // ========= Instruction Memory =========
    wire [31:0] Instr;

    Instruction_Memory instr_mem (
        .address(PC),
        .Instr(Instr)
    );

    // ========= Instruction Fields =========
    wire [6:0] opcode = Instr[6:0];
    wire [4:0] rd     = Instr[11:7];
    wire [2:0] funct3 = Instr[14:12];
    wire [4:0] rs1    = Instr[19:15];
    wire [4:0] rs2    = Instr[24:20];
    wire [6:0] funct7 = Instr[31:25];

    // ========= Control Signals =========
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    wire [1:0] ALUOp, ImmSrc;

    Control_Unit_Main_Decoder main_decoder (
        .Opcode(opcode),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // ========= Register File =========
    wire [31:0] RD1, RD2;

    Register_File reg_file (
        .clk(clk),
        .WE3(RegWrite),
        .rst(reset),
        .A1(rs1),
        .A2(rs2),
        .A3(rd),
        .WD3(Result),
        .RD1(RD1),
        .RD2(RD2)
    );

    // ========= Sign Extend =========
    

    Sign_Extend sign_extend (
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    // ========= ALU Decoder =========
    wire [2:0] ALUControl;

    Control_Unit_ALU_Decoder alu_decoder (
        .ALUOP(ALUOp),
        .funct3(funct3),
        .op5(funct7[5]),
        .funct7(funct7[0]),   
        .ALUcontrol(ALUControl)
    );

    // ========= ALU =========
    wire [31:0] SrcB, ALUResult;
    wire Zero_Flag, Sign_Flag;

    MUX2x1 #(.WIDTH(32)) alu_src_mux (
        .in0(RD2),
        .in1(ImmExt),
        .sel(ALUSrc),
        .out(SrcB)
    );

    ALU alu_unit (
        .ALU_Control(ALUControl),
        .A(RD1),
        .B(SrcB),
        .Zero_Flag(Zero_Flag),
        .Sign_Flag(Sign_Flag),
        .ALU_Result(ALUResult)
    );

    // ========= Data Memory =========
    wire [31:0] ReadData;

    Data_Memory data_mem (
        .WE(MemWrite),
        .clk(clk),
        .A(ALUResult),
        .WD(RD2),
        .RD(ReadData)
    );

    // ========= Result MUX =========
     

    MUX2x1 #(.WIDTH(32)) result_mux (
        .in0(ALUResult),
        .in1(ReadData),
        .sel(ResultSrc),
        .out(Result)
    );

    // ========= Branch Logic =========
    Branch_Control_Logic branch_logic (
        .Zero_Flag(Zero_Flag),
        .Sign_Flag(Sign_Flag),
        .Branch(Branch),
        .funct3(funct3),
        .PCSrc(PCSrc)
    );

endmodule

