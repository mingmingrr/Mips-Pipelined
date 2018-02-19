`ifndef MIPS_CONTROL_SIGNAL_IMMEDIATE_GENERATE_I
`define MIPS_CONTROL_SIGNAL_IMMEDIATE_GENERATE_I

`include "Mips/Instruction/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Control/Signal/Immediate/Control.v"

module Mips_Control_Signal_Alu_generate
	( `Mips_Instruction_OpFunc_OpFunc_T  (input)  opFunc
	, `Mips_Instruction_Category_T       (input)  category
	, `Mips_Control_Signal_Alu_Control_T (output) control
	);

`Mips_Control_Signal_Immediate_Control_Extend_T (reg) extend ;
`Mips_Control_Signal_Immediate_Control_Shift_T  (reg) shift  ;

always @(*)
	if(opFunc == `Mips_Instruction_OpFunc_OpFuncs_Lui)
		shift = `Mips_Control_Signal_Immediate_Signal_Shift_Const16 ;
	else
		shift = `Mips_Control_Signal_Immediate_Signal_Shift_None    ;

always @(*)
	casez(category)
		`Mips_Instruction_Category_Logic_V:
			extend = `Mips_Control_Signal_Immediate_Signal_Extend_Unsigend ;
		default:
			extend = `Mips_Control_Signal_Immediate_Signal_Extend_Sigend   ;
	endcase

assign control = `Mips_Control_Signal_Alu_Control_Init_Defaults;

`endif

