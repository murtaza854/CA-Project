module program_counter
(
  input [63:0]PC_In,
  input reset, clk,
  output [63:0]PC_Out
);

reg [63:0]pcOut;


always @(posedge reset or posedge clk)
begin
  if (reset)
    begin
      pcOut = 0;
    end
 else
    begin
      pcOut = PC_In;
    end  
end

assign PC_Out = pcOut;



endmodule