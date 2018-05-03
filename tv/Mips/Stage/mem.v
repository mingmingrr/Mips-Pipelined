`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"

`include "Mips/Pipeline/Ex/Mem.v"
`include "Mips/Pipeline/Mem/Reg.v"
`include "Mips/Pipeline/Mem/Fwd.v"

`include "Mips/Datapath/Memory/datapath.v"

module Mips_Stage_mem #
	( parameter DELAYED = 1
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter INVERT_CTRL = 0
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Pipeline_ExMem_T (input) pipeExMem
	, `Mips_Pipeline_MemReg_T (output) pipeMemReg
	, `Mips_Pipeline_MemFwd_T (output) pipeMemFwd
	);

`Util_Math_log2_expr

`Mips_Pipeline_ExMem_Decl_Defaults
Mips_Pipeline_ExMem_unpack EXMEM
	( .in (pipeExMem)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .control     (control)
	, .regPort2    (regPort2)
	, .regPorts    (regPorts)
	, .aluResult   (aluResult)
	);

`Mips_Type_RegPorts_T (reg) regPorts$;
always @(posedge `Data_Control_Control_Clock(ctrl))
	regPorts$ <= regPorts;

`Mips_Type_Word_T (reg) aluResult$;
always @(posedge `Data_Control_Control_Clock(ctrl))
	aluResult$ <= aluResult;

`Mips_Type_Word_T (reg) memData;
always @(*)
	if(
		`Mips_Type_RegPorts_WriteAddr(regPorts$) ==
		`Mips_Type_RegPorts_Read2Addr(regPorts)
	)
		memData = aluResult$;
	else
		memData = regPort2;


`Mips_Type_Word_T (wire) memOut;
Mips_Datapath_Memory_datapath #
	( .ADDR_L (64)
	, .ADDR_W (Util_Math_log2(ADDR_L))
	, .INVERT_CTRL (INVERT_CTRL)
	) MEM
	( .ctrl (ctrl)
	, .aluResult (aluResult)
	, .regPort2  (memData)
	, .control   (control)
	, .out       (memOut)
	);

`Mips_Type_Word_T (reg) memOutD;
always @(posedge `Data_Control_Control_Clock(ctrl))
	memOutD <= memOut;

`Mips_Type_Word_T (reg) regPort2$;
always @(posedge `Data_Control_Control_Clock(ctrl))
	regPort2$ <= regPort2;

`Mips_Type_Word_T (reg) memOut$;
always @(*)
	if(
		aluResult == aluResult$
	)
		memOut$ = regPort2$;
	else
		memOut$ = memOut;


Mips_Pipeline_MemReg_generate #
	( .DELAYED (DELAYED)
	) MEMREG
	( .ctrl (ctrl)
	, .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .memOut      (memOut$)
	, .aluResult   (aluResult)
	, .regPorts    (regPorts)
	, .out         (pipeMemReg)
	);

Mips_Pipeline_MemFwd_pack MEMFWD
	( .out (pipeMemFwd)
	, .pcAddr    (pcAddr)
	, .aluResult (aluResult)
	, .regPorts  (regPorts)
	);

endmodule


