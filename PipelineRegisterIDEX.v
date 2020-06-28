module PipelineRegisterIDEX(
    input MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Branch,BranchGeq,clk,maintain,[63:0]ReadData1,[63:0]ReadData2,[63:0]Imm, [63:0] Address, [3:0] funct, [4:0]WriteReg, [4:0] R1,[4:0] R2,
    input [1:0]ALUop,
    output reg OutMemRead,reg OutMemtoReg,reg OutMemWrite,reg OutALUSrc, reg OutRegWrite,reg OutBranch, reg OutBranchGeq, reg [63:0] OutReadData1, reg [63:0] OutReadData2,  reg [63:0] OutImm,reg [63:0] OutAddress,reg [3:0] Outfunct,reg  [4:0]OutWriteReg, reg [1:0]OutALUop,reg [4:0] OutR1,reg [4:0] OutR2
);

always @(posedge maintain or posedge clk)
begin
  if (!maintain & clk)
  begin
      OutMemRead=MemRead;
      OutMemtoReg=MemtoReg;
      OutMemWrite=MemWrite;
      OutALUSrc=ALUSrc;
      OutRegWrite=RegWrite;
      OutBranch=Branch;
      OutBranchGeq=BranchGeq;
      OutReadData1=ReadData1;
      OutReadData2=ReadData2;
      OutImm=Imm;
      OutAddress=Address;
      Outfunct=funct;
      OutWriteReg=WriteReg;
      OutALUop=ALUop;
      OutR1=R1;
      OutR2=R2;
  end 
end
initial
begin
      OutMemRead=0;
      OutMemtoReg=0;
      OutMemWrite=0;
      OutALUSrc=0;
      OutRegWrite=0;
      OutBranch=0;
      OutBranchGeq=0;
      OutReadData1=0;
      OutReadData2=0;
      OutImm=0;
      OutAddress=0;
      Outfunct=0;
      OutWriteReg=0;
      OutALUop=0;
      OutR1=0;
      OutR2=0;
end
endmodule // PipelineRegisterIDEX