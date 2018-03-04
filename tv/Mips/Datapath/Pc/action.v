`include "Mips/Datapath/Alu/Status.v"
`include "Mips/Control/Signal/Pc/Control.v"
`include "Mips/Control/Signal/Pc/Signal/Action.v"
`include "Mips/Control/Signal/Pc/Signal/Condition.v"

module Mips_Datapath_Pc_action
	( `Mips_Datapath_Alu_Status_T              (input)  status
	, `Mips_Control_Signal_Pc_Control_T   (input)  control
	, `Mips_Control_Signal_Pc_Control_Action_T (output) action
	);

`Mips_Control_Signal_Pc_Control_Action_T (reg) action$;
always @(*)
	case(`Mips_Control_Signal_Pc_Control_Condition(control))
		`Mips_Control_Signal_Pc_Signal_Condition_None :
			action$ = `Mips_Control_Signal_Pc_Control_Action(control);
		`Mips_Control_Signal_Pc_Signal_Condition_EQ :
			if(
				`Mips_Control_Signal_Pc_Control_Action(control) ==
					`Mips_Control_Signal_Pc_Signal_Action_Branch &&
				!`Mips_Datapath_Alu_Status_Zero(status)
			)
				action$ = `Mips_Control_Signal_Pc_Signal_Action_Inc;
			else
				action$ = `Mips_Control_Signal_Pc_Control_Action(control);
		`Mips_Control_Signal_Pc_Signal_Condition_NE :
			if(
				`Mips_Control_Signal_Pc_Control_Action(control) ==
					`Mips_Control_Signal_Pc_Signal_Action_Branch &&
				`Mips_Datapath_Alu_Status_Zero(status)
			)
				action$ = `Mips_Control_Signal_Pc_Signal_Action_Inc;
			else
				action$ = `Mips_Control_Signal_Pc_Control_Action(control) ;
		default :
			action$ = `Mips_Control_Signal_Pc_Control_Action(control);
	endcase
assign action = action$;

endmodule

