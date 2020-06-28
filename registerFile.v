module registerFile(
    input [63:0]WriteData, [4:0]RS1, [4:0]RS2, [4:0]RD,
    input RegWrite, clk, reset,
    output [63:0]ReadData1, [63:0]ReadData2
);

reg[63:0] Register[31:0];
reg [63:0]ReadDatareg1;
reg [63:0]ReadDatareg2;

initial Register[0] = 64'd0;
initial Register[1] = 64'd0;
initial Register[2] = 64'd0;
initial Register[3] = 64'd0;
initial Register[4] = 64'd0;
initial Register[5] = 64'd0;
initial Register[6] = 64'd0;
initial Register[7] = 64'd0;
initial Register[8] = 64'd0;
initial Register[9] = 64'd00;
initial Register[10] = 64'd0;
initial Register[11] = 64'd1;
initial Register[12] = 64'd00;
initial Register[13] = 64'd00;
initial Register[14] = 64'd00;
initial Register[15] = 64'd00;
initial Register[16] = 64'd00;
initial Register[17] = 64'd00;
initial Register[18] = 64'd00;
initial Register[19] = 64'd00;
initial Register[20] = 64'd00;
initial Register[21] = 64'd00;
initial Register[22] = 64'd00;
initial Register[23] = 64'd00;
initial Register[24] = 64'd00;
initial Register[25] = 64'd00;
initial Register[26] = 64'd00;
initial Register[27] = 64'd00;
initial Register[28] = 64'd00;
initial Register[29] = 64'd00;
initial Register[30] = 64'd00;
initial Register[31] = 64'd00;

always @(posedge clk) begin
    if (RegWrite == 1 & reset == 0)
        Register[RD] = WriteData;
end

always @(*) begin
    if (reset == 1)
        begin
            ReadDatareg1 = 64'd0;
            ReadDatareg2 = 64'd0;
        end
    else
        begin
            ReadDatareg1 = Register[RS1];
            ReadDatareg2 = Register[RS2];
        end
    
end

assign ReadData1 = ReadDatareg1;
assign ReadData2 = ReadDatareg2;

endmodule // registerFile