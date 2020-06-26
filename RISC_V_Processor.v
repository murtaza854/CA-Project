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
wire [63:0]imm_data1;

wire [63:0]Result;

wire [63:0]Read_Data;

wire [3:0]Operation;

wire Zero;

wire andGateOut;

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

adder a1(
    .a(PC_Out),
    .b(64'd4),
    .out(out)
);

adder a2(
    .a(PC_Out),
    .b(imm_data1),
    .out(out1)
);

assign andGateOut = Branch & Zero;


InstructionParser ip(
    .instruction(Instruction),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);

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
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUop(ALUop),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

alu_64 a(
    .a(ReadData1),
    .b(data_out),
    .ALUOp(Operation),
    .Result(Result),
    .Zero(Zero)
);

MUX2x1 m1(
    .a(ReadData2),
    .b(imm_data),
    .sel(ALUSrc),
    .data_out(data_out)
);

dataExtract dE(
    .instruction(Instruction),
    .imm_data(imm_data)
);

assign imm_data1 = imm_data << 1;

data_memory dm(
    .Mem_Addr(Result),
    .Write_Data(ReadData2),
    .clk(clk),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .Read_Data(Read_Data)
);

MUX2x1 m2(
    .a(Result),
    .b(Read_Data),
    .sel(MemtoReg),
    .data_out(data_out1)
);

ALU_Control aa(
    .ALUOp(ALUop),
    .Funct({Instruction[30],Instruction[14:12]}),
    .Operation(Operation)
);

MUX2x1 m3(
    .a(out),
    .b(out1),
    .sel(andGateOut),
    .data_out(data_out2)
);

endmodule // RISC_V_Processor