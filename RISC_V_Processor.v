module RISC_V_Processor(
    input clk, reset
    
);

wire [63:0]PC_Out;

wire [63:0] datafrommuxnearalu;
wire [63:0] mux12out;
wire [31:0]Instruction;
wire[1:0] ForwardA;
wire[1:0] ForwardB;
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
wire BranchGeq; // ! Added

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

wire [63:0]IFIDOutAddress;  // ! For IF ID Register
wire [31:0]IFIDOutInstruction; // ! For IF ID Register
// * Works
PipelineRegisterIFID IFID(
    .clk(clk),
    .maintain(1'b0), // ! Replace with hazard thing
    .Instruction(Instruction),
    .Address(PC_Out),
    .OutInstruction(IFIDOutInstruction),
    .OutAddress(IFIDOutAddress)
);
wire IDEXOutMemRead;
wire IDEXOutMemtoReg;
wire IDEXOutMemWrite;
wire IDEXOutALUSrc;
wire IDEXOutRegWrite;
wire IDEXOutBranch;
wire IDEXOutBranchGeq;
wire [63:0]IDEXOutReadData1;
wire [63:0]IDEXOutReadData2;
wire [63:0]IDEXOutImm;
wire [63:0]IDEXOutAddress;
wire [3:0]IDEXOutfunct;
wire [4:0]IDEXOutWriteReg;
wire [1:0]IDEXOutALUop;
wire [4:0] IDEXOutR1;
wire [4:0] IDEXOutR2;
// * works
PipelineRegisterIDEX IDEX(
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Branch(Branch),
    .BranchGeq(BranchGeq),
    .clk(clk),
    .maintain(1'b0), // ! Replace with Hazard setting
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .Imm(imm_data),
    .Address(IFIDOutAddress),
    .funct({IFIDOutInstruction[30],IFIDOutInstruction[14:12]}),
    .WriteReg(IFIDOutInstruction[11:7]),
    .R1(rs1),
    .R2(rs2),
    .ALUop(ALUop),
    .OutMemRead(IDEXOutMemRead),
    .OutMemtoReg(IDEXOutMemtoReg),
    .OutMemWrite(IDEXOutMemWrite),
    .OutALUSrc(IDEXOutALUSrc),
    .OutRegWrite(IDEXOutRegWrite),
    .OutBranch(IDEXOutBranch),
    .OutBranchGeq(IDEXOutBranchGeq),
    .OutReadData1(IDEXOutReadData1),
    .OutReadData2(IDEXOutReadData2),
    .OutImm(IDEXOutImm),
    .OutAddress(IDEXOutAddress),
    .Outfunct(IDEXOutfunct),
    .OutWriteReg(IDEXOutWriteReg),
    .OutALUop(IDEXOutALUop),
    .OutR1(IDEXOutR1),
    .OutR2(IDEXOutR2)
);
wire EXMEMOutZero;
wire EXMEMOutGreaterThanEqualZero;
wire EXMEMOutMemRead;
wire EXMEMOutMemtoReg;
wire EXMEMOutMemWrite;
wire EXMEMOutRegWrite;
wire EXMEMOutBranch;
wire EXMEMOutBranchGeq; 
wire [63:0]EXMEMOutWriteData;  
wire [63:0]EXMEMOutImm;
wire [63:0]EXMEMOutAddress;
wire [4:0]EXMEMOutWriteReg;
wire [63:0]EXMEMOutALUResult;
// * Works
PipelineRegisterEXMEM EXMEM(
    .Zero(Zero),
    .GreaterThanEqualZero(GreaterThanEqualZero),
    .MemRead(IDEXOutMemRead),
    .MemtoReg(IDEXOutMemtoReg),
    .MemWrite(IDEXOutMemWrite),
    .RegWrite(IDEXOutRegWrite),
    .Branch(IDEXOutBranch),
    .BranchGeq(IDEXOutBranchGeq),
    .clk(clk),
    .maintain(1'b0), // ! When hazard installed change
    .WriteData(IDEXOutReadData2),
    .Address(out1), 
    .WriteReg(IDEXOutWriteReg),
    .ALUResult(Result),
    .OutZero(EXMEMOutZero),
    .OutGreaterThanEqualZero(EXMEMOutGreaterThanEqualZero),
    .OutMemRead(EXMEMOutMemRead),
    .OutMemtoReg(EXMEMOutMemtoReg),
    .OutMemWrite(EXMEMOutMemWrite),
    .OutRegWrite(EXMEMOutRegWrite),
    .OutBranch(EXMEMOutBranch), 
    .OutBranchGeq(EXMEMOutBranchGeq), 
    .OutWriteData(EXMEMOutWriteData),  
    .OutImm(EXMEMOutImm),
    .OutAddress(EXMEMOutAddress),
    .OutWriteReg(EXMEMOutWriteReg),
    .OutALUResult(EXMEMOutALUResult)
);
wire MEMWBOutMemtoReg;
wire MEMWBOutRegWrite;
wire [63:0] MEMWBOutReadData;
wire [63:0] MEMWBOutReadData2;
wire  [4:0] MEMWBOutWriteReg;
wire  [63:0] MEMWBOutWriteData;
// * Works
PipelineRegisterMEMWB MEMWB(
    .MemtoReg(EXMEMOutMemtoReg),
    .RegWrite(EXMEMOutRegWrite),
    .clk(clk),
    .maintain(1'b0), // ! When hazard installed change
    .ReadData(Read_Data),
    .ReadData2(EXMEMOutALUResult), 
    .WriteReg(EXMEMOutWriteReg),
    .WriteData(EXMEMOutWriteData),
    .OutMemtoReg(MEMWBOutMemtoReg), 
    .OutRegWrite(MEMWBOutRegWrite), 
    .OutReadData(MEMWBOutReadData), 
    .OutReadData2(MEMWBOutReadData2),  
    .OutWriteReg(MEMWBOutWriteReg),
    .OutWriteData(MEMWBOutWriteData)
);

// * Works
program_counter pc (
    .PC_In(data_out2), 
    .reset(reset),
    .clk(clk),
    .PC_Out(PC_Out)
);
// * Works
Instruction_Memory imm(
    .Inst_Address(PC_Out),
    .Instruction(Instruction)
);

// * Works
// PC + 4

adder a1(
    .a(PC_Out),
    .b(64'd4),
    .out(out)
);

// PC + Imm data
// * Works
adder a2(
    .a(IDEXOutAddress), 
    .b(IDEXOutImm << 1),
    .out(out1)
);

// // assign andGateOut = Branch & (Zero | (GreaterThanEqualZero & BranchGeq)); // * Whether to jump or not. If branch is on and zero or branch is on. Greater than equals zero and funct3 is 1 meaning jump. Is stupid
// ! Branch Geq added
// * Works
InstructionParser ip(
    .instruction(IFIDOutInstruction),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);
// *  dataout1 is data sent by WB 
// * Works
registerFile rf(
    .clk(clk),
    .reset(reset),
    .RS1(rs1),
    .RS2(rs2),
    .RD(MEMWBOutWriteReg),
    .RegWrite(MEMWBOutRegWrite), 
    .WriteData(data_out1), 
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);
// * Works
Control_Unit cu(
    .Opcode(opcode),
    .Funct3(funct3), 
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUop(ALUop),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .BranchGeq(BranchGeq)
);
// * Works
alu_64 a(
    .a(mux12out),
    .b(data_out),
    .ALUOp(Operation),
    .Result(Result),
    .Zero(Zero),
    .GreaterThanEqualZero(GreaterThanEqualZero) // ! Added Greater than Zero
);

//  MUX between Register file and ALU
// * Works
MUX2x1 m1(
    .a(IDEXOutReadData2),
    .b(IDEXOutImm),
    .sel(IDEXOutALUSrc),
    .data_out(datafrommuxnearalu) 
);

MUX3x1 m12(
    .a(IDEXOutReadData1),
    .b(EXMEMOutALUResult),
    .c(data_out1),
    .sel(ForwardA),
    .data_out(mux12out) 
);
MUX3x1 m13(
    .a(datafrommuxnearalu),
    .b(EXMEMOutALUResult),
    .c(data_out1),
    .sel(ForwardB),
    .data_out(data_out) 
);


// Immediate Data Extractor
// * Works
dataExtract dE(
    .instruction(IFIDOutInstruction),
    .imm_data(imm_data)
);


// * Works
data_memory dm(
    .Mem_Addr(EXMEMOutALUResult),
    .Write_Data(EXMEMOutWriteData),
    .clk(clk),
    .MemWrite(EXMEMOutMemWrite),
    .MemRead(EXMEMOutMemRead),
    .Read_Data(Read_Data)
);

// * MUX after Data memory
MUX2x1 m2(
    .a(MEMWBOutReadData2),
    .b(MEMWBOutReadData),
    .sel(MEMWBOutMemtoReg),
    .data_out(data_out1)
);

// * Works
ALU_control aa(
    .ALUOp(IDEXOutALUop),
    .funct(IDEXOutfunct), 
    .operation(Operation)
);

// Choose whether to +4 or add imm
// * Works
MUX2x1 m3(
    .a(out), 
    .b(EXMEMOutAddress),
    .sel(EXMEMOutBranch!=1'bx & EXMEMOutBranch & (EXMEMOutZero | (EXMEMOutGreaterThanEqualZero & EXMEMOutBranchGeq))),
    .data_out(data_out2)
);

ForwardingUnit Forwardunit(
    .EXMEMRegRd(EXMEMOutWriteReg),
    .MEMWBRegRd(MEMWBOutWriteReg),
    .IDEXR1(IDEXOutR1),
    .IDEXR2(IDEXOutR2),
    .EXMEMRegWrite(EXMEMOutRegWrite),
    .MEMWBRegWrite(MEMWBOutRegWrite),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);

endmodule // RISC_V_Processor