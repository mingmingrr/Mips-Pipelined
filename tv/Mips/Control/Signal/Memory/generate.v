`ifndef MIPS_CONTROL_SIGNAL_MEMORY_GENERATE_I
`define MIPS_CONTROL_SIGNAL_MEMORY_GENERATE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Control/Signal/Memory/Control.v"

module Mips_Control_Signal_Memory_generate
	( `Mips_Instruction_OpFunc_OpFunc_T     (input)  opFunc
	, `Mips_Instruction_Category_Category_T (input)  category
	, `Mips_Control_Signal_Memory_Control_T (output) control
	);

`Mips_Control_Signal_Memory_Control_WriteEnable_T (reg) writeEnable ;

always @(*)
	if(category == `Mips_Instruction_Category_Category_Store)
		writeEnable = `Mips_Control_Signal_Memory_Signal_WriteEnable_True  ;
	else
		writeEnable = `Mips_Control_Signal_Memory_Signal_WriteEnable_False ;

assign control = `Mips_Control_Signal_Memory_Control_Init_Defaults;

endmodule

`endif

