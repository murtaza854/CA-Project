module PipelineRegisterIFID(
    input clk,maintain,[31:0]Instruction,[63:0] Address,
    output reg [31:0] OutInstruction,[63:0] OutAddress
);

always @(posedge maintain or posedge clk)
begin
  if (!maintain & clk)
  begin
      OutInstruction=Instruction;
      OutAddress=Address;      
  end 
end

initial
begin
  OutInstruction=0;
  OutAddress=0;
end

endmodule // PipelineRegisterIFID