`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Util/Math.v"

`include "Mips/Pipeline/Ex/Mem.v"
`include "Mips/Pipeline/Mem/Reg.v"
`include "Mips/Pipeline/Pc/Reg.v"
`include "Mips/Pipeline/Reg/Ex.v"
`include "Mips/Pipeline/Reg/Pc.v"
`include "Mips/Pipeline/Ex/Fwd.v"
`include "Mips/Pipeline/Fwd/Ex.v"
`include "Mips/Pipeline/Mem/Fwd.v"
`include "Mips/Pipeline/Reg/Fwd.v"

`include "Mips/Stage/pc.v"
`include "Mips/Stage/reg.v"
`include "Mips/Stage/ex.v"
`include "Mips/Stage/mem.v"
`include "Mips/Stage/fwd.v"

module Mips_mips_pipeline #
	( parameter DELAYED = 1
	, parameter FILE = "asm/old/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Type_Word_T(output)      pcAddr
	);

`Util_Math_log2_expr

`Mips_Pipeline_ExMem_T  (wire) pipeExMem;
`Mips_Pipeline_MemReg_T (wire) pipeMemReg;
`Mips_Pipeline_PcReg_T  (wire) pipePcReg;
`Mips_Pipeline_RegEx_T  (wire) pipeRegEx;
`Mips_Pipeline_RegPc_T  (wire) pipeRegPc;
`Mips_Pipeline_FwdEx_T  (wire) pipeFwdEx;
`Mips_Pipeline_RegFwd_T (wire) pipeRegFwd;
`Mips_Pipeline_MemFwd_T (wire) pipeMemFwd;
`Mips_Pipeline_ExFwd_T  (wire) pipeExFwd;

Mips_Stage_pc #
	( .DELAYED (DELAYED)
	, .FILE (FILE)
	, .ADDR_L (ADDR_L)
	, .ADDR_W (ADDR_W)
	) PC
	( .ctrl (ctrl)
	, .pipeRegPc (pipeRegPc)
	, .pipePcReg (pipePcReg)
	);

Mips_Stage_reg #
	( .DELAYED (DELAYED)
	, .PASSTHROUGH (DELAYED)
	) REG
	( .ctrl (ctrl)
	, .pipeMemReg (pipeMemReg)
	, .pipePcReg  (pipePcReg)
	, .pipeRegEx  (pipeRegEx)
	, .pipeRegPc  (pipeRegPc)
	, .pipeRegFwd (pipeRegFwd)
	);

Mips_Stage_ex #
	( .DELAYED (DELAYED)
	) EX
	( .ctrl (ctrl)
	, .pipeRegEx (pipeRegEx)
	, .pipeFwdEx (pipeFwdEx)
	, .pipeExMem (pipeExMem)
	, .pipeExFwd (pipeExFwd)
	);

Mips_Stage_mem #
	( .DELAYED     (DELAYED)
	, .ADDR_L      (64)
	, .INVERT_CTRL (!DELAYED)
	) MEM
	( .ctrl (ctrl)
	, .pipeExMem  (pipeExMem)
	, .pipeMemReg (pipeMemReg)
	, .pipeMemFwd (pipeMemFwd)
	);

Mips_Stage_fwd #
	( .DIRECT (!DELAYED)
	) FWD
	( .pipeFwdEx (pipeFwdEx)
	, .pipeExFwd (pipeExFwd)
	, .pipeRegFwd (pipeRegFwd)
	, .pipeMemFwd (pipeMemFwd)
	);

assign pcAddr = `Mips_Pipeline_PcReg_PcAddr(pipePcReg);

endmodule

