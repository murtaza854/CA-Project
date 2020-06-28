vlog registerFile.v alu_64.v ALU_Control.v Control_Unit.v data_memory.v dataExtract.v program_counter.v adder.v Instruction_Memory.v tb.v instructionParser.v MUX2x1.v RISC_V_Processor.v PipelineRegisterIFID.v PipelineRegisterIDEX.v PipelineRegisterEXMEM.v PipelineRegisterMEMWB.v ForwardingUnit.v MUX3x1.v
vsim -novopt work.tb

view wave

add wave -r /*

run 400ns
