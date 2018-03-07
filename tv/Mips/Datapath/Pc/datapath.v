`include "Data/Control/Control.v"
`include "Data/Memory/rom.v"

`include "Mips/Type/Word.v"
`include "Mips/Instruction/Format/IFormat.v"
`include "Mips/Instruction/Format/JFormat.v"

`include "Mips/Type/AluStatus.v"
`include "Mips/Datapath/Pc/pc.v"
`include "Mips/Datapath/Pc/action.v"
`include "Mips/Control/Control.v"

`include "Mips/Control/Signal/Pc/Control.v"

module Mips_Datapath_Pc_datapath #
	( parameter FILE   = "asm/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter DATA_W = 32
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Control_Control_T (input) control
	, `Mips_Type_AluStatus_T (input) aluStatus
	, `Mips_Type_Word_T (input)  regPort1
	,                    input   regPortEq
	, `Mips_Type_Word_T (output) addrCurr
	, `Mips_Type_Word_T (output) addrNext
	, `Mips_Type_Word_T (output) instruction
	);

`Util_Math_log2_expr

Data_Memory_rom #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (DATA_W)
	) ROM
	( .addr  (addrNext[ADDR_W+1:2])
	, .ctrl  (ctrl)
	, .out   (instruction)
	);

`Mips_Control_Signal_Pc_Control_T(wire) pcControl;
assign pcControl = `Mips_Control_Control_Pc(control);

`Mips_Control_Signal_Pc_Control_Action_T(wire) action;
Mips_Datapath_Pc_action ACT
	( .status  (aluStatus)
	, .portEq  (regPortEq)
	, .control (pcControl)
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
