`include "Mips/Control/Signal/Pc/Signal/Action.v"

module Mips_Datapath_Pc_demote
	( `Mips_Control_Signal_Pc_Signal_Action_T (input) in
	, `Mips_Control_Signal_Pc_Signal_Action_T (output) out
	);

`Mips_Control_Signal_Pc_Signal_Action_T (reg) out$;
always @(*)
	if(in == `Mips_Control_Signal_Pc_Signal_Action_None)
		out$ = `Mips_Control_Signal_Pc_Signal_Action_None;
	else
		out$ = `Mips_Control_Signal_Pc_Signal_Action_Inc;
assign out = out$;

endmodule
