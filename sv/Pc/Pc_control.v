`ifndef PC_CONTROL_I
`define PC_CONTROL_I

`include "../Alu/Alu_Status.v"
`include "../Pc/Pc_Action.v"
`include "../Control/Control_Control.v"

module Pc_control
	( `Control_Control_T(input) control
	, `Alu_Status_T(input) status
	, `Pc_Action_T(output) action
	);

`Pc_Action_T(reg) action$;
assign action = action$;

always @(*)
	case(`Control_Control_PcAction(control))
		`Pc_Action_None   : action$ = `Pc_Action_None;
		`Pc_Action_Inc    : action$ = `Pc_Action_Inc;
		`Pc_Action_Jump   : action$ = `Pc_Action_Jump;
		`Pc_Action_Branch : action$ = `Pc_Action_Branch;
	endcase

endmodule

`endif
