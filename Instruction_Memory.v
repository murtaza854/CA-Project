module Instruction_Memory
(
    input [63:0]Inst_Address,
    output [31:0]Instruction
);


// reg [7:0] inst_mem [7:0];
// initial {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h016bd463;
// initial {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00d00733;
// initial {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00508093;
// initial {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00608093;

reg [7:0]inst_mem[79:0];

initial {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00800593; // done

initial {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h04b68463; // done
initial {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00d00733;
initial {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h01400ab3;
initial {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h02b70863;
initial {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h00aa0c33;
initial {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h00aa8cb3;

initial {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h000C3B03; // ld
initial {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h000CBB83; // ld

initial {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h008a8a93;
initial {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h00170713;
initial {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'hff6bd2e3;
initial {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h016007b3;

initial {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h017C3023; // sd
initial {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h00FCB023; // sd

initial {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'hfc000ae3;
initial {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'h008a0a13;
initial {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h00168693;
initial {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'hfa000ee3;

initial {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h00000013;

assign Instruction = {inst_mem[Inst_Address + 3], inst_mem[Inst_Address + 2], inst_mem[Inst_Address + 1], inst_mem[Inst_Address]};

endmodule // Instruction_Memory
