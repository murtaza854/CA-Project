module data_memory (
    input [63:0]Mem_Addr, [63:0]Write_Data,
    input clk, MemWrite, MemRead,
    output reg [63:0]Read_Data
);

reg [7:0] Array[63:0];

initial
begin
Array[0] = 8'd9;
Array[1] = 8'd10;
Array[2] = 8'd11;
Array[3] = 8'd12;
Array[4] = 8'd13;
Array[5] = 8'd14;
Array[6] = 8'd15;
Array[7] = 8'd16;
Array[8] = 8'd17;
Array[9] = 8'd18;
Array[10] = 8'd19;
Array[11] = 8'd20;
Array[12] = 8'd21;
Array[13] = 8'd22;
Array[14] = 8'd23;
Array[15] = 8'd24;
Array[16] = 8'd25;
Array[17] = 8'd26;
Array[18] = 8'd27;
Array[19] = 8'd28;
Array[20] = 8'd29;
Array[21] = 8'd30;
Array[22] = 8'd31;
Array[23] = 8'd32;
Array[24] = 8'd33;
Array[25] = 8'd34;
Array[26] = 8'd35;
Array[27] = 8'd36;
Array[28] = 8'd37;
Array[29] = 8'd38;
Array[30] = 8'd39;
Array[31] = 8'd40;
Array[32] = 8'd41;
Array[33] = 8'd42;
Array[34] = 8'd43;
Array[35] = 8'd44;
Array[36] = 8'd45;
Array[37] = 8'd46;
Array[38] = 8'd47;
Array[39] = 8'd48;
Array[40] = 8'd49;
Array[41] = 8'd50;
Array[42] = 8'd51;
Array[43] = 8'd52;
Array[44] = 8'd53;
Array[45] = 8'd54;
Array[46] = 8'd55;
Array[47] = 8'd56;
Array[48] = 8'd57;
Array[49] = 8'd58;
Array[50] = 8'd59;
Array[51] = 8'd60;
Array[52] = 8'd61;
Array[53] = 8'd0;
Array[54] = 8'd0;
Array[55] = 8'd0;
Array[56] = 8'd0;
Array[57] = 8'd0;
Array[58] = 8'd0;
Array[59] = 8'd0;
Array[60] = 8'd0;
Array[61] = 8'd0;
Array[62] = 8'd0;
Array[63] = 8'd0;
end

always @(*) begin
    if (MemRead)
        Read_Data = {Array[Mem_Addr + 7], Array[Mem_Addr + 6], Array[Mem_Addr + 5], Array[Mem_Addr + 4], Array[Mem_Addr + 3], Array[Mem_Addr + 2], Array[Mem_Addr + 1], Array[Mem_Addr]};
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