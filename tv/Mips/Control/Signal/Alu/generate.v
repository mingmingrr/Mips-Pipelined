`ifndef MIPS_CONTROL_SIGNAL_ALU_GENERATE_I
`define MIPS_CONTROL_SIGNAL_ALU_GENERATE_I

`include "Mips/Instruction/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Control/Signal/Alu/Control.v"

module Mips_Control_Signal_Alu_generate
	( `Mips_Instruction_OpFunc_OpFunc_T  (input)  opFunc
	, `Mips_Instruction_Category_T       (input)  category
	, `Mips_Control_Signal_Alu_Control_T (output) control
	);

`Mips_Control_Signal_Alu_Control_Data2Source_T (reg) data2Source;

always @(*)
	if(`Mips_Instruction_OpFunc_OpFunc_Source(opFunc) == `Mips_Instruction_OpFunc_Source_Func)
		aluData2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Register;
	else
		casez(category)
			`Mips_Instruction_Category_Branch_V:
				aluData2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Register;
			default:
				aluData2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Immediate;
		endcase

assign control = `Mips_Control_Signal_Alu_Control_Init_Defaults;

`endif

