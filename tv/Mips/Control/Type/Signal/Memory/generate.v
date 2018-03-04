`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/OpFuncs.v"
`include "Mips/Control/Type/Signal/Memory/Control.v"

module Mips_Control_Type_Signal_Memory_generate
	( `Mips_Instruction_OpFunc_OpFunc_T     (input)  opFunc
	, `Mips_Instruction_Category_Category_T (input)  category
	, `Mips_Control_Type_Signal_Memory_Control_T (output) control
	);

`Mips_Control_Type_Signal_Memory_Control_WriteEnable_T (reg) writeEnable ;
`Mips_Control_Type_Signal_Memory_Control_ByteEnable_T  (reg) byteEnable  ;
`Mips_Control_Type_Signal_Memory_Control_ByteExtend_T  (reg) byteExtend  ;

always @(*)
	if(`Mips_Instruction_Category_Category_Store(category))
		writeEnable = `Mips_Control_Type_Signal_Memory_Signal_WriteEnable_True  ;
	else
		writeEnable = `Mips_Control_Type_Signal_Memory_Signal_WriteEnable_False ;

always @(*)
	case(opFunc)
		`Mips_Instruction_OpFunc_OpFuncs_Lb  : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Byte ;
		`Mips_Instruction_OpFunc_OpFuncs_Lh  : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Half ;
		`Mips_Instruction_OpFunc_OpFuncs_Lw  : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Word ;
		`Mips_Instruction_OpFunc_OpFuncs_Lbu : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Byte ;
		`Mips_Instruction_OpFunc_OpFuncs_Lhu : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Half ;
		`Mips_Instruction_OpFunc_OpFuncs_Sb  : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Byte ;
		`Mips_Instruction_OpFunc_OpFuncs_Sh  : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Half ;
		`Mips_Instruction_OpFunc_OpFuncs_Sw  : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_Word ;
		default                              : byteEnable = `Mips_Control_Type_Signal_Memory_Signal_ByteEnable_None ;
	endcase

always @(*)
	case(opFunc)
		`Mips_Instruction_OpFunc_OpFuncs_Lbu : byteExtend = `Mips_Control_Type_Signal_Memory_Signal_ByteExtend_Unsigned ;
		`Mips_Instruction_OpFunc_OpFuncs_Lhu : byteExtend = `Mips_Control_Type_Signal_Memory_Signal_ByteExtend_Unsigned ;
		default                              : byteExtend = `Mips_Control_Type_Signal_Memory_Signal_ByteExtend_Signed ;
	endcase

assign control = `Mips_Control_Type_Signal_Memory_Control_Init_Defaults;

endmodule


