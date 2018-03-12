`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"

`include "Mips/Pipeline/Fwd/Ex.v"
`include "Mips/Pipeline/Reg/Ex.v"
`include "Mips/Pipeline/Ex/Mem.v"
`include "Mips/Pipeline/Ex/Fwd.v"

`include "Mips/Datapath/Alu/datapath.v"

module Mips_Stage_ex #
	( parameter DELAYED = 1
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Pipeline_RegEx_T (input) pipeRegEx
	, `Mips_Pipeline_FwdEx_T (input) pipeFwdEx
	, `Mips_Pipeline_ExMem_T (output) pipeExMem
	, `Mips_Pipeline_ExFwd_T (output) pipeExFwd
	);

`Mips_Pipeline_RegEx_Decl_Defaults
Mips_Pipeline_RegEx_unpack REGEX
	( .in (pipeRegEx)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .regPort1    (regPort1)
	, .regPort2    (regPort2)
	, .regPorts    (regPorts)
	, .control     (control)
	);

`Mips_Type_Word_T (wire) regPort1Fwd;
`Mips_Type_Word_T (wire) regPort2Fwd;
Mips_Pipeline_FwdEx_unpack FWDEX
	( .in (pipeFwdEx)
	, .regPort1 (regPort1Fwd)
	, .regPort2 (regPort2Fwd)
	);

`Mips_Type_Word_T (wire) aluResult;
Mips_Datapath_Alu_datapath ALU
	( .ctrl (ctrl)
	, .instruction (instruction)
	, .regPort1    (regPort1Fwd)
	, .regPort2    (regPort2Fwd)
	, .control     (control)
	, .result      (aluResult)
	, .status      ()
	);

Mips_Pipeline_ExMem_generate #
	( .DELAYED (DELAYED)
	) EXMEM
	( .ctrl (ctrl)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .control     (control)
	, .regPort2    (regPort2)
	, .regPorts    (regPorts)
	, .aluResult   (aluResult)
	, .out         (pipeExMem)
	);

Mips_Pipeline_ExFwd_pack EXFWD
	( .out (pipeExFwd)
	, .regPort1 (regPort1)
	, .regPort2 (regPort2)
	, .regPorts (regPorts)
	);
endmodule

