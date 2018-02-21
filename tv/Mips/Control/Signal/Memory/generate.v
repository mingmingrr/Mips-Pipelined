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
`Mips_Control_Signal_Memory_Control_ByteEnable_T  (reg) byteEnable  ;

always @(*)
	if(`Mips_Instruction_Category_Category_Store(category))
		writeEnable = `Mips_Control_Signal_Memory_Signal_WriteEnable_True  ;
	else
		writeEnable = `Mips_Control_Signal_Memory_Signal_WriteEnable_False ;

always @(*)
	case(opFunc)
		`Mips_Instruction_OpFunc_OpFuncs_Lb  : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Byte ;
		`Mips_Instruction_OpFunc_OpFuncs_Lh  : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Half ;
		`Mips_Instruction_OpFunc_OpFuncs_Lw  : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Int  ;
		`Mips_Instruction_OpFunc_OpFuncs_Lbu : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Byte ;
		`Mips_Instruction_OpFunc_OpFuncs_Lhu : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Half ;
		`Mips_Instruction_OpFunc_OpFuncs_Sb  : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Byte ;
		`Mips_Instruction_OpFunc_OpFuncs_Sh  : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Half ;
		`Mips_Instruction_OpFunc_OpFuncs_Sw  : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_Int  ;
		default                              : byteEnable = `Mips_Control_Signal_Memory_Signal_ByteEnable_None ;
	endcase

assign control = `Mips_Control_Signal_Memory_Control_Init_Defaults;

endmodule

`endif

