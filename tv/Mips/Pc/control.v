`ifndef PC_CONTROL_I
`define PC_CONTROL_I

`include "Mips/Alu/Status.v"
`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Pc/Signal/Action.v"
`include "Mips/Instruction/OpFunc/Source.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/OpFuncs.v"

module Mips_Pc_control
	( `Mips_Control_Control_T(input) control
	, input zeroflag
	, input zeroreg
	, `Mips_Control_Signal_Pc_Signal_Action_T(output) action
	);

`Mips_Control_Signal_Pc_Signal_Action_T(reg) action$;
assign action = action$;

always @(*)
	case(`Mips_Control_Control_PcAction(control))
		`Mips_Control_Signal_Pc_Signal_Action_None   : action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
		`Mips_Control_Signal_Pc_Signal_Action_Inc    : action$ = `Mips_Control_Signal_Pc_Signal_Action_Inc;
		`Mips_Control_Signal_Pc_Signal_Action_Jump   : action$ = `Mips_Control_Signal_Pc_Signal_Action_Jump;
		`Mips_Control_Signal_Pc_Signal_Action_Branch :
			case(`Mips_Control_Control_OpFunc(control))
				`Mips_Instruction_OpFunc_OpFuncs_Beq:
					if(zeroflag)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Bne:
					if(!zeroflag)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Bgez:
					if(!zeroflag)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Bgezal:
					if(!zeroflag)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Bltz:
					if(zeroflag)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Bltzal:
					if(zeroflag)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Bgtz:
					if(!zeroflag && !zeroreg)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				`Mips_Instruction_OpFunc_OpFuncs_Blez:
					if(zeroflag || zeroreg)
						action$ = `Mips_Control_Signal_Pc_Signal_Action_Branch;
					else
						action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
				default:
					action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
			endcase
		default:
			action$ = `Mips_Control_Signal_Pc_Signal_Action_None;
	endcase

endmodule

`endif
