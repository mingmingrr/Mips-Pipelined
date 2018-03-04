`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Instruction/Format/IFormat.v"
`include "Mips/Instruction/Format/JFormat.v"
`include "Mips/Datapath/Alu/Status.v"
`include "Mips/Control/Type/Signal/Pc/Control.v"

`include "Mips/Datapath/Pc/pc.v"
`include "Mips/Datapath/Pc/action.v"

module Mips_Datapath_Pc_datapath
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Type_Word_T(input) instruction
	, `Mips_Type_Word_T(input) regPort1
	, `Mips_Datapath_Alu_Status_T(input) status
	, `Mips_Control_Type_Signal_Pc_Control_T(input) control
	, `Mips_Type_Word_T(output) addrCurr
	, `Mips_Type_Word_T(output) addrNext
	);

`Mips_Control_Type_Signal_Pc_Control_Action_T(wire) action;
Mips_Datapath_Pc_action ACT
	( .status  (status)
	, .control (control)
	, .action  (action)
	);

Mips_Datapath_Pc_pc #
	( .ADDR_W (32)
	) PC
	( .ctrl   (ctrl)
	, .action (action)
	, .offset (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .jump   (`Mips_Instruction_Format_JFormat_Target(instruction))
	, .jumpr  (regPort1)
	, .addrNext (addrNext)
	, .addrCurr (addrCurr)
	);

endmodule
