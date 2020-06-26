module data_memory (
    input [63:0]Mem_Addr, [63:0]Write_Data,
    input clk, MemWrite, MemRead,
    output reg [63:0]Read_Data
);

reg [7:0] Array[63:0];

initial
begin
{Array[63], Array[62], Array[61], Array[60], Array[59], Array[58], Array[57], Array[56]} = 64'h6;
{Array[55], Array[54], Array[53], Array[52], Array[51], Array[50], Array[49], Array[48]} = 64'h12;
{Array[47], Array[46], Array[45], Array[44], Array[43], Array[42], Array[41], Array[40]} = 64'h10;
{Array[39], Array[38], Array[37], Array[36], Array[35], Array[34], Array[33], Array[32]} = 64'h50;
{Array[31], Array[30], Array[29], Array[28], Array[27], Array[26], Array[25], Array[24]} = 64'h5;
{Array[23], Array[22], Array[21], Array[20], Array[19], Array[18], Array[17], Array[16]} = 64'h9;
{Array[15], Array[14], Array[13], Array[12], Array[11], Array[10], Array[9], Array[8]} = 64'h15;
{Array[7], Array[6], Array[5], Array[4], Array[3], Array[2], Array[1], Array[0]} = 64'h7;
end

always @(*) begin
    if (MemRead)
        Read_Data= 1;
        // Read_Data = {Array[Mem_Addr + 7], Array[Mem_Addr + 6], Array[Mem_Addr + 5], Array[Mem_Addr + 4], Array[Mem_Addr + 3], Array[Mem_Addr + 2], Array[Mem_Addr + 1], Array[Mem_Addr]};
end

always @(posedge clk) begin
    if (MemWrite)
        Array[Mem_Addr] = Write_Data[7:0];
    Array[Mem_Addr + 1] = Write_Data[15:8];
    Array[Mem_Addr + 2] = Write_Data[23:16];
    Array[Mem_Addr + 3] = Write_Data[31:24];
    Array[Mem_Addr + 4] = Write_Data[39:32];
    Array[Mem_Addr + 5] = Write_Data[47:40];
    Array[Mem_Addr + 6] = Write_Data[55:48];
    Array[Mem_Addr + 7] = Write_Data[63:56];
end

endmodule // data_memory 
