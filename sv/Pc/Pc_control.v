`ifndef PC_CONTROL_I
`define PC_CONTROL_I

`include "../Alu/Alu_Status.v"
`include "../Pc/Pc_Action.v"
`include "../Control/Control_Control.v"
`include "../Opcode/Opcode_OpFunc.v"

module Pc_control
	( `Control_Control_T(input) control
	, input zeroflag
	, input zeroreg
	, `Pc_Action_T(output) action
	);

`Pc_Action_T(reg) action$;
assign action = action$;

always @(*)
	case(`Control_Control_PcAction(control))
		`Pc_Action_None   : action$ = `Pc_Action_None;
		`Pc_Action_Inc    : action$ = `Pc_Action_Inc;
		`Pc_Action_Jump   : action$ = `Pc_Action_Jump;
		`Pc_Action_Branch :
			case(`Control_Control_OpFunc(control))
				`Opcode_OpFunc_Beq:
					if(zeroflag)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Bne:
					if(!zeroflag)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Bgez:
					if(!zeroflag)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Bgezal:
					if(!zeroflag)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Bltz:
					if(zeroflag)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Bltzal:
					if(zeroflag)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Bgtz:
					if(!zeroflag && !zeroreg)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				`Opcode_OpFunc_Blez:
					if(zeroflag || zeroreg)
						action$ = `Pc_Action_Branch;
					else
						action$ = `Pc_Action_None;
				default:
					action$ = `Pc_Action_None;
			endcase
		default:
			action$ = `Pc_Action_None;
	endcase

endmodule

`endif
