`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/OpFuncs.v"
`include "Mips/Control/Signal/Pc/Control.v"

module Mips_Control_Signal_Pc_generate
	( `Mips_Instruction_OpFunc_OpFunc_T     (input)  opFunc
	, `Mips_Instruction_Category_Category_T (input)  category
	, `Mips_Control_Signal_Pc_Control_T     (output) control
	);

`Mips_Control_Signal_Pc_Control_Action_T    (reg) action    ;
`Mips_Control_Signal_Pc_Control_Condition_T (reg) condition ;

always @(*)
	if(`Mips_Instruction_Category_Category_Jump(category)) begin
		if(
			opFunc == `Mips_Instruction_OpFunc_OpFuncs_Jr ||
			opFunc == `Mips_Instruction_OpFunc_OpFuncs_Jalr
		)
			action = `Mips_Control_Signal_Pc_Signal_Action_JumpR;
		else
			action = `Mips_Control_Signal_Pc_Signal_Action_Jump;
	end else if(`Mips_Instruction_Category_Category_Branch(category))
		action = `Mips_Control_Signal_Pc_Signal_Action_Branch;
	else
		action = `Mips_Control_Signal_Pc_Signal_Action_Inc;

always @(*)
	case(opFunc)
		// `Mips_Instruction_OpFunc_OpFuncs_Bgez   : condition = `Mips_Control_Signal_Pc_Signal_Condition_GE   ;
		// `Mips_Instruction_OpFunc_OpFuncs_Bgezal : condition = `Mips_Control_Signal_Pc_Signal_Condition_GE   ;
		// `Mips_Instruction_OpFunc_OpFuncs_Bgtz   : condition = `Mips_Control_Signal_Pc_Signal_Condition_GT   ;
		// `Mips_Instruction_OpFunc_OpFuncs_Blez   : condition = `Mips_Control_Signal_Pc_Signal_Condition_LE   ;
		// `Mips_Instruction_OpFunc_OpFuncs_Bltz   : condition = `Mips_Control_Signal_Pc_Signal_Condition_LT   ;
		// `Mips_Instruction_OpFunc_OpFuncs_Bltzal : condition = `Mips_Control_Signal_Pc_Signal_Condition_LE   ;
		`Mips_Instruction_OpFunc_OpFuncs_Beq    : condition = `Mips_Control_Signal_Pc_Signal_Condition_EQ ;
		`Mips_Instruction_OpFunc_OpFuncs_Bne    : condition = `Mips_Control_Signal_Pc_Signal_Condition_NE ;
		default                                 : condition = `Mips_Control_Signal_Pc_Signal_Condition_None ;
	endcase

assign control = `Mips_Control_Signal_Pc_Control_Pack_Defaults;

endmodule


