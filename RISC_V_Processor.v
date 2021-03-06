module RISC_V_Processor(
    input clk, reset
    
);

wire [63:0]PC_Out;

wire [31:0]Instruction;

wire [63:0]out;
wire [63:0]out1;

wire [6:0]opcode;
wire [4:0]rd;
wire [2:0]funct3;
wire [4:0]rs1;
wire [4:0]rs2;
wire [6:0]funct7;

wire [63:0]ReadData1;
wire [63:0]ReadData2;

wire [1:0]ALUop;
wire MemRead;
wire MemtoReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire Branch;

wire [63:0]data_out;
wire [63:0]data_out1;
wire [63:0]data_out2;

wire [63:0]imm_data;

wire [63:0]Result;

wire [63:0]Read_Data;

wire [3:0]Operation;

wire Zero;
wire GreaterThanEqualZero;
// // wire andGateOut;
wire BranchGeq; // ! Added
program_counter pc (
    .PC_In(data_out2),
    .reset(reset),
    .clk(clk),
    .PC_Out(PC_Out)
);

Instruction_Memory imm(
    .Inst_Address(PC_Out),
    .Instruction(Instruction)
);
// PC + 4
adder a1(
    .a(PC_Out),
    .b(64'd4),
    .out(out)
);

// PC + Imm data
adder a2(
    .a(PC_Out),
    .b(imm_data << 1),
    .out(out1)
);

// // assign andGateOut = Branch & (Zero | (GreaterThanEqualZero & BranchGeq)); // * Whether to jump or not. If branch is on and zero or branch is on. Greater than equals zero and funct3 is 1 meaning jump. Is stupid
// ! Branch Geq added

InstructionParser ip(
    .instruction(Instruction),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);
// *  dataout1 is data sent by WB 
registerFile rf(
    .clk(clk),
    .reset(reset),
    .RS1(rs1),
    .RS2(rs2),
    .RD(rd),
    .RegWrite(RegWrite),
    .WriteData(data_out1),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

Control_Unit cu(
    .Opcode(opcode),
    .Funct3(funct3), // ! Added
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUop(ALUop),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .BranchGeq(BranchGeq)
);

alu_64 a(
    .a(ReadData1),
    .b(data_out),
    .ALUOp(Operation),
    .Result(Result),
    .Zero(Zero),
    .GreaterThanEqualZero(GreaterThanEqualZero) // ! Added Greater than Zero
);

//  MUX between Register file and ALU
MUX2x1 m1(
    .a(ReadData2),
    .b(imm_data),
    .sel(ALUSrc),
    .data_out(data_out)
);

// Immediate Data Extractor
dataExtract dE(
    .instruction(Instruction),
    .imm_data(imm_data)
);



data_memory dm(
    .Mem_Addr(Result),
    .Write_Data(ReadData2),
    .clk(clk),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .Read_Data(Read_Data)
);

// * MUX after Data memory
MUX2x1 m2(
    .a(Result),
    .b(Read_Data),
    .sel(MemtoReg),
    .data_out(data_out1)
);


ALU_control aa(
    .ALUOp(ALUop),
    .funct({Instruction[30],Instruction[14:12]}),
    .operation(Operation)
);

// Choose whether to +4 or add imm
MUX2x1 m3(
    .a(out),
    .b(out1),
    .sel(Branch & (Zero | (GreaterThanEqualZero & BranchGeq))),
    .data_out(data_out2)
);

endmodule // RISC_V_Processor