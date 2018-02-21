`ifndef MIPS_CONTROL_SIGNAL_IMMEDIATE_GENERATE_I
`define MIPS_CONTROL_SIGNAL_IMMEDIATE_GENERATE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/OpFuncs.v"
`include "Mips/Control/Signal/Immediate/Control.v"

module Mips_Control_Signal_Immediate_generate
	( `Mips_Instruction_OpFunc_OpFunc_T        (input)  opFunc
	, `Mips_Instruction_Category_Category_T    (input)  category
	, `Mips_Control_Signal_Immediate_Control_T (output) control
	);

`Mips_Control_Signal_Immediate_Control_Extend_T (reg) extend ;
`Mips_Control_Signal_Immediate_Control_Shift_T  (reg) shift  ;

wire lui;
assign lui = opFunc == `Mips_Instruction_OpFunc_OpFuncs_Lui;
wire log;
assign log = `Mips_Instruction_Category_Category_Logic(category);

always @(*)
	if(lui)
		shift = `Mips_Control_Signal_Immediate_Signal_Shift_Left16 ;
	else
		shift = `Mips_Control_Signal_Immediate_Signal_Shift_None   ;

always @(*)
	if(log)
		extend = `Mips_Control_Signal_Immediate_Signal_Extend_Unsigned ;
	else
		extend = `Mips_Control_Signal_Immediate_Signal_Extend_Signed   ;

assign control = `Mips_Control_Signal_Immediate_Control_Init_Defaults;

endmodule

`endif

