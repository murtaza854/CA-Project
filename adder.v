module adder
(
  input [63:0]a, [63:0]b,
  output [63:0]out
);

reg [63:0]Out;

always @(*)
begin
  Out = a + b;
end

assign out = Out;

endmodule