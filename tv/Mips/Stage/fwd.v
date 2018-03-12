`include "Mips/Type/Word.v"
`include "Mips/Type/RegPorts.v"

`include "Mips/Pipeline/Fwd/Ex.v"
`include "Mips/Pipeline/Ex/Fwd.v"
`include "Mips/Pipeline/Reg/Fwd.v"
`include "Mips/Pipeline/Mem/Fwd.v"

`include "Mips/Forward/Ex/forward.v"

module Mips_Stage_fwd #
	( parameter DIRECT = 1
	)
	( `Mips_Pipeline_FwdEx_T (output) pipeFwdEx
	, `Mips_Pipeline_ExFwd_T (input) pipeExFwd
	, `Mips_Pipeline_RegFwd_T (input) pipeRegFwd
	, `Mips_Pipeline_MemFwd_T (input) pipeMemFwd
	);

`Mips_Type_Word_T (wire) pipeEx_RegPort1;
`Mips_Type_Word_T (wire) pipeEx_RegPort2;
`Mips_Type_RegPorts_T (wire) pipeEx_RegPorts;
Mips_Pipeline_ExFwd_unpack EXFWD
	( .in (pipeExFwd)
	, .regPort1 (pipeEx_RegPort1)
	, .regPort2 (pipeEx_RegPort2)
	, .regPorts (pipeEx_RegPorts)
	);

`Mips_Type_Word_T (wire) pipeMem_PcAddr;
`Mips_Type_Word_T (wire) pipeMem_AluResult;
`Mips_Type_RegPorts_T (wire) pipeMem_RegPorts;
Mips_Pipeline_MemFwd_unpack MEMFWD
	( .in (pipeMemFwd)
	, .pcAddr    (pipeMem_PcAddr)
	, .aluResult (pipeMem_AluResult)
	, .regPorts  (pipeMem_RegPorts)
	);

`Mips_Type_Word_T (wire) pipeReg_WriteData;
`Mips_Type_RegPorts_T (wire) pipeReg_RegPorts;
Mips_Pipeline_RegFwd_unpack REGFWD
	( .in (pipeRegFwd)
	, .writeData (pipeReg_WriteData)
	, .regPorts  (pipeReg_RegPorts)
	);

`Mips_Type_Word_T (wire) regPort1;
`Mips_Type_Word_T (wire) regPort2;
Mips_Forward_Ex_forward #
	( .DIRECT (DIRECT)
	) EX
	( .regPort1 (regPort1)
	, .regPort2 (regPort2)
	, .pipeEx_RegPort1   (pipeEx_RegPort1)
	, .pipeEx_RegPort2   (pipeEx_RegPort2)
	, .pipeEx_RegPorts   (pipeEx_RegPorts)
	, .pipeMem_RegPorts  (pipeMem_RegPorts)
	, .pipeReg_RegPorts  (pipeReg_RegPorts)
	, .pipeMem_AluResult (pipeMem_AluResult)
	, .pipeMem_PcAddr    (pipeMem_PcAddr)
	, .pipeReg_WriteData (pipeReg_WriteData)
	);

Mips_Pipeline_FwdEx_pack FWDEX
	( .out (pipeFwdEx)
	, .regPort1 (regPort1)
	, .regPort2 (regPort2)
	);

endmodule
