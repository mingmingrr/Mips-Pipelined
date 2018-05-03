`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Control/Signal/Register/Signal/WriteDataSource.v"

module Mips_Forward_Mem_forward #
	( parameter DIRECT = 1
	)
	( `Mips_Type_Word_T (output) memData
	, `Mips_Type_Word_T (input) pipeMem_MemAddr
	, `Mips_Type_Word_T (input) pipeReg_MemAddr
	, `Mips_Type_Word_T (input) pipeMem_MemData
	, `Mips_Type_Word_T (input) pipeReg_MemData
	, `Mips_Control_Signal_Register_Signal_WriteDataSource_T (input) pipeReg_WriteDataSource
	, `Mips_Type_RegAddr_T (input) pipeMem_Read1Addr
	, `Mips_Type_RegAddr_T (input) pipeMem_Read2Addr
	, `Mips_Type_RegAddr_T (input) pipeReg_WriteAddr
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
