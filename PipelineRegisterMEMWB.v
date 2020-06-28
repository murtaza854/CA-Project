module PipelineRegisterMEMWB(
    input  MemtoReg, RegWrite, clk,maintain,[63:0]ReadData,[63:0]ReadData2,  [4:0]WriteReg,[63:0] WriteData,
    output reg OutMemtoReg, reg OutRegWrite, reg [63:0] OutReadData, reg [63:0] OutReadData2, reg  [4:0]OutWriteReg, reg [63:0] OutWriteData
);

always @(posedge maintain or posedge clk)
begin
  if (!maintain & clk)
  begin
      OutMemtoReg=MemtoReg;
      OutRegWrite=RegWrite;
      OutReadData=ReadData;
      OutReadData2=ReadData2;
      // OutAddress=Address;
      OutWriteReg=WriteReg;
      OutWriteData=WriteData;
      // OutALUResult=ALUResult;
  end 
end
initial
begin
      OutMemtoReg=0;
      OutRegWrite=0;
      OutReadData=0;
      OutReadData2=0;
      // OutAddress=Address;
      OutWriteReg=0;
      // OutALUResult=ALUResult;
  end
endmodule // PipelineRegisterMEMWB