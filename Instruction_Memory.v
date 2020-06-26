module Instruction_Memory
(
    input [63:0]Inst_Address,
    output [31:0]Instruction
);

reg [7:0]inst_mem[15:0];

initial inst_mem[0] = 8'b10000011;
initial inst_mem[1] = 8'b00110100;
initial inst_mem[2] = 8'b10000101;
initial inst_mem[3] = 8'b00000010;
initial inst_mem[4] = 8'b10110011;
initial inst_mem[5] = 8'b10000100;
initial inst_mem[6] = 8'b10011010;
initial inst_mem[7] = 8'b00000000;
initial inst_mem[8] = 8'b10010011;
initial inst_mem[9] = 8'b10000100;
initial inst_mem[10] = 8'b00010100;
initial inst_mem[11] = 8'b00000000;
initial inst_mem[12] = 8'b00100011;
initial inst_mem[13] = 8'b00110100;
initial inst_mem[14] = 8'b10010101;
initial inst_mem[15] = 8'b00000010;

assign Instruction = {inst_mem[Inst_Address + 3], inst_mem[Inst_Address + 2], inst_mem[Inst_Address + 1], inst_mem[Inst_Address]};

endmodule // Instruction_Memory