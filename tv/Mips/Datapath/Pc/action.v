`ifndef MIPS_DATAPATH_PC_ACTION_I
`define MIPS_DATAPATH_SIGNAL_PC_ACTION_I

`include "Mips/Alu/Status.v"
`include "Mips/Control/Signal/Pc/Control.v"
`include "Mips/Control/Signal/Pc/Signal/Action.v"
`include "Mips/Control/Signal/Pc/Signal/Condition.v"

module Mips_Datapath_Pc_action
	( `Mips_Alu_Status_T                          (input)  status
	, `Mips_Control_Signal_Pc_Control_Action_T    (input)  actionIn
	, `Mips_Control_Signal_Pc_Control_Condition_T (input)  condition
	, `Mips_Control_Signal_Pc_Control_Action_T    (output) actionOut
	);

`Mips_Control_Signal_Pc_Control_Action_T (reg) actionOut$;
always @(*)
	case(condition)
		`Mips_Control_Signal_Pc_Signal_Condition_None : actionOut$ = actionIn;
		`Mips_Control_Signal_Pc_Signal_Condition_EQ :
			if(
				actionIn ==  `Mips_Control_Signal_Pc_Signal_Action_Branch &&
				!`Mips_Alu_Status_Zero(status)
			)
				actionOut$ = `Mips_Control_Signal_Pc_Signal_Action_Inc;
			else
				actionOut$ = actionIn;
		`Mips_Control_Signal_Pc_Signal_Condition_NE :
			if(
				actionIn ==  `Mips_Control_Signal_Pc_Signal_Action_Branch &&
				`Mips_Alu_Status_Zero(status)
			)
				actionOut$ = `Mips_Control_Signal_Pc_Signal_Action_Inc;
			else
				actionOut$ = actionIn;
	endcase
assign actionOut = actionOut$;

endmodule

`endif
