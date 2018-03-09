`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"

`include "Mips/Pipeline/ExMem.v"
`include "Mips/Pipeline/MemReg.v"

`include "Mips/Datapath/Memory/datapath.v"

module Mips_Stage_mem #
	( parameter DELAYED = 1
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter INVERT_CTRL = 1
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Pipeline_ExMem_T (input) pipeExMem
	, `Mips_Pipeline_MemReg_T (output) pipeMemReg
	);

`Util_Math_log2_expr

`Mips_Pipeline_ExMem_Decl_Defaults
Mips_Pipeline_ExMem_unpack EXMEM
	( .pipe (pipeExMem)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .control     (control)
	, .regPort2    (regPort2)
	, .aluResult   (aluResult)
	);

`Mips_Type_Word_T (wire) memOut;
Mips_Datapath_Memory_datapath #
	( .ADDR_L (64)
	, .ADDR_W (Util_Math_log2(ADDR_L))
	, .INVERT_CTRL (1)
	) MEM
	( .ctrl (ctrl)
	, .aluResult (aluResult)
	, .regPort2  (regPort2)
	, .control   (control)
	, .out       (memOut)
	);

Mips_Pipeline_MemReg_generate #
	( .DELAYED (DELAYED)
	, .INSTRUCTION_DELAY (1)
	, .PCADDR_DELAY      (1)
	, .MEMOUT_DELAY      (0)
	, .ALURESULT_DELAY   (1)
	, .CONTROL_DELAY     (1)
	) MEMREG
	( .ctrl (ctrl)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .memOut      (memOut)
	, .aluResult   (aluResult)
	, .control     (control)
	, .pipe        (pipeMemReg)
	);

endmodule


