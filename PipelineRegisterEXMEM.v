module PipelineRegisterEXMEM(
    input Zero, GreaterThanEqualZero,MemRead, MemtoReg, MemWrite, RegWrite, Branch,BranchGeq,clk,maintain,[63:0]WriteData, [63:0] Address, [4:0]WriteReg,[63:0] ALUResult,
    output reg OutZero,reg OutGreaterThanEqualZero,reg OutMemRead,reg OutMemtoReg,reg OutMemWrite, reg OutRegWrite,reg OutBranch, reg OutBranchGeq, reg [63:0] OutWriteData,  reg [63:0] OutImm,reg [63:0] OutAddress,reg  [4:0]OutWriteReg, reg [63:0] OutALUResult
);

always @(posedge maintain or posedge clk)
begin
  if (!maintain & clk)
  begin
      OutZero=Zero;
      OutGreaterThanEqualZero=GreaterThanEqualZero;
      OutMemRead=MemRead;
      OutMemtoReg=MemtoReg;
      OutMemWrite=MemWrite;
      OutRegWrite=RegWrite;
      OutBranch=Branch;
      OutBranchGeq=BranchGeq;
      OutWriteData=WriteData;
      OutAddress=Address;
      OutWriteReg=WriteReg;
      OutALUResult=ALUResult;

  end 
end
initial
begin
      OutZero=0;
      OutGreaterThanEqualZero=0;
      OutMemRead=0;
      OutMemtoReg=0;
      OutMemWrite=0;
      OutRegWrite=0;
      OutBranch=0;
      OutBranchGeq=0;
      OutWriteData=0;
      OutAddress=0;
      OutWriteReg=0;
      OutALUResult=0;

  end
endmodule // PipelineRegisterEXMEM