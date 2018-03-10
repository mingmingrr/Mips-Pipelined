`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"

`include "Mips/Pipeline/RegPc.v"
`include "Mips/Pipeline/PcReg.v"

`include "Mips/Datapath/Pc/datapath.v"

module Mips_Stage_pc #
	( parameter DELAYED = 1
	, parameter FILE = "asm/old/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Pipeline_RegPc_T (input) pipeRegPc
	, `Mips_Pipeline_PcReg_T (output) pipePcReg
	);

`Util_Math_log2_expr

`Mips_Pipeline_RegPc_Decl_Defaults
Mips_Pipeline_RegPc_unpack REGPC
	( .in       (pipeRegPc)
	, .regPort1  (regPort1)
	, .regPortEq (regPortEq)
	, .control   (control)
	);

`Mips_Type_Word_T (wire) instruction;
`Mips_Type_Word_T (wire) pcAddr;
Mips_Datapath_Pc_datapath #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	) PC
	( .ctrl (ctrl)
	, .control     (control)
	, .instruction (instruction)
	, .regPort1    (regPort1)
	, .regPortEq   (regPortEq)
	, .addrNext    ()
	, .addrCurr    (pcAddr)
	);

Mips_Pipeline_PcReg_generate #
	( .DELAYED (DELAYED)
	) IFREG
	( .ctrl (ctrl)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .out         (pipePcReg)
	);

endmodule

