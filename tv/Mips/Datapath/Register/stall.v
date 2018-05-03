`include "Mips/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/Bool.v"

module Mips_Datapath_Register_stall #
	( parameter STALL_CONTROL = `Mips_Control_Control_W'(0)
	, parameter STALL_INSTRUCTION = `Mips_Type_Word_W'(0)
	)
	( `Mips_Type_Bool_T (input) stall
	, `Mips_Control_Control_T (input) inControl
	, `Mips_Control_Control_T (output) outControl
	, `Mips_Type_Word_T (input) inInstruction
	, `Mips_Type_Word_T (output) outInstruction
	);

assign outControl = stall ? STALL_CONTROL : inControl;
assign outInstruction = stall ? STALL_INSTRUCTION : inInstruction;

endmodule

