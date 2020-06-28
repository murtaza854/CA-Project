module Control_Unit
(
    input [6:0]Opcode,[2:0] Funct3,
    output [1:0]ALUop,
    output MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Branch,BranchGeq
);

reg [1:0]ALUop1;
reg MemRead1;
reg MemtoReg1;
reg MemWrite1;
reg ALUSrc1;
reg RegWrite1;
reg Branch1;

always @(*)
begin
    case (Opcode)
        7'b0110011  :   begin
                        ALUSrc1 = 0;
                        MemtoReg1 = 0;
                        RegWrite1 = 1;
                        MemRead1 = 0;
                        MemWrite1 = 0;
                        Branch1 = 0;
                        ALUop1 = 2'b10;
                        end
        7'b0000011  :   begin
                        ALUSrc1 = 1;
                        MemtoReg1 = 1;
                        RegWrite1 = 1;
                        MemRead1 = 1;
                        MemWrite1 = 0;
                        Branch1 = 0;
                        ALUop1 = 2'b00;
                        end
        7'b0100011  :   begin
                        ALUSrc1 = 1;
                        MemtoReg1 = 1'bx;
                        RegWrite1 = 0;
                        MemRead1 = 0;
                        MemWrite1 = 1;
                        Branch1 = 0;
                        ALUop1 = 2'b00;
                        end
        7'b1100011  :   begin
                        ALUSrc1 = 0;
                        MemtoReg1 = 1'bx;
                        RegWrite1 = 0;
                        MemRead1 = 0;
                        MemWrite1 = 0;
                        Branch1 = 1;
                        ALUop1 = 2'b01;
                        end
        7'b0010011:
                begin
                    Branch1 = 0;
                    MemRead1 = 1;
                    MemtoReg1 = 0;
                    MemWrite1 = 0;
                    ALUSrc1 = 1;
                    RegWrite1 = 1;
                    ALUop1 = 2'b00;
                end
    endcase
end

assign ALUSrc = ALUSrc1;
assign MemtoReg = MemtoReg1;
assign RegWrite = RegWrite1;
assign MemRead = MemRead1;
assign MemWrite = MemWrite1;
assign Branch = Branch1;
assign ALUop = ALUop1;
assign BranchGeq = Funct3[2];
endmodule // Control_Unit