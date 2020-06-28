module Control_Unit
(
    input [6:0]Opcode,[2:0] Funct3,
    output reg [1:0]ALUop,
    output reg MemRead, reg MemtoReg, reg MemWrite,reg  ALUSrc,reg  RegWrite,reg  Branch,wire BranchGeq
);

// reg [1:0]ALUop;
// reg MemRead;
// reg MemtoReg1;
// reg MemWrite;
// reg ALUSrc1;
// reg RegWrite;
// reg Branch;

always @(*)
begin
    case (Opcode)
        7'b0110011  :   begin
                        ALUSrc = 0;
                        MemtoReg = 0;
                        RegWrite = 1;
                        MemRead = 0;
                        MemWrite = 0;
                        Branch = 0;
                        ALUop = 2'b10;
                        end
        7'b0000011  :   begin
                        ALUSrc = 1;
                        MemtoReg = 1;
                        RegWrite = 1;
                        MemRead = 1;
                        MemWrite = 0;
                        Branch = 0;
                        ALUop = 2'b00;
                        end
        7'b0100011  :   begin
                        ALUSrc = 1;
                        MemtoReg = 1'bx;
                        RegWrite = 0;
                        MemRead = 0;
                        MemWrite = 1;
                        Branch = 0;
                        ALUop = 2'b00;
                        end
        7'b1100011  :   begin
                        ALUSrc = 0;
                        MemtoReg = 1'bx;
                        RegWrite = 0;
                        MemRead = 0;
                        MemWrite = 0;
                        Branch = 1;
                        ALUop = 2'b01;
                        end
        7'b0010011:
                begin
                    Branch = 0;
                    MemRead = 1;
                    MemtoReg = 0;
                    MemWrite = 0;
                    ALUSrc = 1;
                    RegWrite = 1;
                    ALUop = 2'b00;
                end
    endcase
end
initial
begin
ALUSrc = 0;
MemtoReg = 0;
RegWrite = 0;
MemRead = 0;
MemWrite = 0;
Branch = 0;
ALUop = 2'b00;
end

assign BranchGeq = Funct3[2];
endmodule // Control_Unit