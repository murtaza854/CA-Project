module alu_64(
    input [63:0]a, [63:0]b, [3:0]ALUOp,
    output [63:0]Result,
    output reg Zero, GreaterThanEqualZero // ! Line Changed
);

reg [63:0]result;

always @(*) begin
    begin
        case (ALUOp)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b1100: result = ~(a | b);
            default: result = 0;
        endcase
        Zero <= result ? 0:1;
        GreaterThanEqualZero <= result[63] ? 0 : 1; // ! Line added
    end
end

assign Result = result;

endmodule // alu_64