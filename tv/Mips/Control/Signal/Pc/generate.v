`ifndef MIPS_CONTROL_SIGNAL_PC_GENERATE_I
`define MIPS_CONTROL_SIGNAL_PC_GENERATE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Control/Signal/Pc/Control.v"

module Mips_Control_Signal_Pc_generate
	( `Mips_Instruction_OpFunc_OpFunc_T     (input)  opFunc
	, `Mips_Instruction_Category_Category_T (input)  category
	, `Mips_Control_Signal_Pc_Control_T     (output) control
	);

`Mips_Control_Signal_Pc_Control_Action_T (reg) action ;

always @(*)
	case(category)
		`Mips_Instruction_Category_Category_Jump   : action = `Mips_Control_Signal_Pc_Signal_Action_Jump   ;
		`Mips_Instruction_Category_Category_RJump  : action = `Mips_Control_Signal_Pc_Signal_Action_Jump   ;
		`Mips_Instruction_Category_Category_Branch : action = `Mips_Control_Signal_Pc_Signal_Action_Branch ;
		default                                    : action = `Mips_Control_Signal_Pc_Signal_Action_Inc    ;
	endcase

assign control = `Mips_Control_Signal_Pc_Control_Init_Defaults;

endmodule

`endif

