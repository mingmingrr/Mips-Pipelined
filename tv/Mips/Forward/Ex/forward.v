`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"

`include "Mips/Forward/Ex/ports.v"

module Mips_Forward_Ex_forward #
	( parameter DIRECT = 1
	)
	( `Mips_Type_Word_T (output) regPort1
	, `Mips_Type_Word_T (output) regPort2
	, `Mips_Type_Word_T (input) pipeEx_RegPort1
	, `Mips_Type_Word_T (input) pipeEx_RegPort2
	, `Mips_Type_RegPorts_T (input) pipeEx_RegPorts
	, `Mips_Type_RegPorts_T (input) pipeMem_RegPorts
	, `Mips_Type_RegPorts_T (input) pipeReg_RegPorts
	, `Mips_Type_Word_T (input) pipeMem_AluResult
	, `Mips_Type_Word_T (input) pipeMem_PcAddr
	, `Mips_Type_Word_T (input) pipeReg_WriteData

	);

Mips_Forward_Ex_port1 #
	( .DIRECT (DIRECT)
	) PORT1
	( .port (regPort1)
	, .pipeEx_RegPorts   (pipeEx_RegPorts)
	, .pipeMem_RegPorts  (pipeMem_RegPorts)
	, .pipeReg_RegPorts  (pipeReg_RegPorts)
	, .pipeMem_AluResult (pipeMem_AluResult)
	, .pipeMem_PcAddr    (pipeMem_PcAddr)
	, .pipeReg_WriteData (pipeReg_WriteData)
	, .pipeEx_RegPort1   (pipeEx_RegPort1)
	);

Mips_Forward_Ex_port2 #
	( .DIRECT (DIRECT)
	) PORT2
	( .port (regPort2)
	, .pipeEx_RegPorts   (pipeEx_RegPorts)
	, .pipeMem_RegPorts  (pipeMem_RegPorts)
	, .pipeReg_RegPorts  (pipeReg_RegPorts)
	, .pipeMem_AluResult (pipeMem_AluResult)
	, .pipeMem_PcAddr    (pipeMem_PcAddr)
	, .pipeReg_WriteData (pipeReg_WriteData)
	, .pipeEx_RegPort2   (pipeEx_RegPort2)
	);

endmodule
