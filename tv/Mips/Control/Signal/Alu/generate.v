`ifndef MIPS_CONTROL_SIGNAL_ALU_GENERATE_I
`define MIPS_CONTROL_SIGNAL_ALU_GENERATE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Control/Signal/Alu/Control.v"

module Mips_Control_Signal_Alu_generate
	( `Mips_Instruction_OpFunc_OpFunc_T     (input)  opFunc
	, `Mips_Instruction_Category_Category_T (input)  category
	, `Mips_Control_Signal_Alu_Control_T    (output) control
	);

`Mips_Control_Signal_Alu_Control_Data2Source_T (reg) data2Source;

always @(*)
	if(
		`Mips_Instruction_Category_Category_Shift(category) &&
		(!`Mips_Instruction_Category_Category_ShiftV(category))
	)
		data2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Shamt;
	else if(
		`Mips_Instruction_Category_Category_Load(category) ||
		`Mips_Instruction_Category_Category_Store(category)
	)
		data2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Immediate;
	else if(
		`Mips_Instruction_Category_Category_Register(category) ||
		`Mips_Instruction_Category_Category_Branch(category)
	)
		data2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Register;
	else
		data2Source = `Mips_Control_Signal_Alu_Signal_Data2Source_Immediate;

assign control = `Mips_Control_Signal_Alu_Control_Init_Defaults;

endmodule

`endif

