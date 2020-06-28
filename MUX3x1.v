module MUX3x1(
    input [63:0]a, [63:0]b,[63:0]c,
    input [1:0] sel,
    output reg [63:0]data_out
);

always @ (*) begin
  case(sel)
    2'b00 : data_out = a;
    2'b10 : data_out = b;
    2'b01 : data_out = c;
    default : data_out = 0;
  endcase
end

initial
begin
  data_out=0;
end

endmodule