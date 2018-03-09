`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"

`include "Mips/Pipeline/MemReg.v"
`include "Mips/Pipeline/PcReg.v"
`include "Mips/Pipeline/RegEx.v"
`include "Mips/Pipeline/RegPc.v"

`include "Mips/Datapath/Register/datapath.v"
`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"

module Mips_Stage_reg #
	( parameter DELAYED = 1
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Pipeline_MemReg_T (input) pipeMemReg
	, `Mips_Pipeline_PcReg_T  (input) pipePcReg
	, `Mips_Pipeline_RegEx_T  (output) pipeRegEx
	, `Mips_Pipeline_RegPc_T  (output) pipeRegPc
	);

`Mips_Type_Word_T (wire) pipePcReg_instruction ;
`Mips_Type_Word_T (wire) pipePcReg_pcAddr ;
Mips_Pipeline_PcReg_unpack PCREG
	( .pipe (pipePcReg)
	, .instruction (pipePcReg_instruction)
	, .pcAddr      (pipePcReg_pcAddr)
	);

`Mips_Type_Word_T (wire) pipeMemReg_instruction;
`Mips_Type_Word_T (wire) pipeMemReg_pcAddr;
`Mips_Type_Word_T (wire) pipeMemReg_memOut;
`Mips_Type_Word_T (wire) pipeMemReg_aluResult;
`Mips_Control_Control_T (wire) pipeMemReg_control;
Mips_Pipeline_MemReg_unpack MEMREG
	( .pipe (pipeMemReg)
	, .instruction (pipeMemReg_instruction)
	, .pcAddr      (pipeMemReg_pcAddr)
	, .memOut      (pipeMemReg_memOut)
	, .aluResult   (pipeMemReg_aluResult)
	, .control     (pipeMemReg_control)
	);

`Mips_Control_Control_T (wire) control ;
Mips_Control_generate CTRL
	( .instruction (pipePcReg_instruction)
	, .control     (control)
	);

`Mips_Type_Word_T (wire) regPort1 ;
`Mips_Type_Word_T (wire) regPort2 ;
wire regPortEq ;
Mips_Datapath_Register_datapath REG
	( .ctrl (ctrl)
	, .writeControl     (pipeMemReg_control)
	, .readInstruction  (pipePcReg_instruction)
	, .writeInstruction (pipeMemReg_instruction)
	, .pcAddr           (pipeMemReg_pcAddr)
	, .memOut           (pipeMemReg_memOut)
	, .aluResult        (pipeMemReg_aluResult)
	, .port1            (regPort1)
	, .port2            (regPort2)
	, .portEq           (regPortEq)
	);

Mips_Pipeline_RegEx_generate #
	( .DELAYED (DELAYED)
	, .INSTRUCTION_DELAY (1)
	, .PCADDR_DELAY      (1)
	, .REGPORT1_DELAY    (1)
	, .REGPORT2_DELAY    (1)
	, .CONTROL_DELAY     (1)
	) REGEX
	( .ctrl (ctrl)
	, .instruction (pipePcReg_instruction)
	, .pcAddr      (pipePcReg_pcAddr)
	, .regPort1    (regPort1)
	, .regPort2    (regPort2)
	, .control     (control)
	, .pipe        (pipeRegEx)
	);

Mips_Pipeline_RegPc_generate #
	( .DELAYED (DELAYED)
	, .REGPORT1_DELAY  (0)
	, .REGPORTEQ_DELAY (0)
	, .CONTROL_DELAY   (0)
	) REGPC
	( .ctrl (ctrl)
	, .regPort1  (regPort1)
	, .regPortEq (regPortEq)
	, .control   (control)
	, .pipe      (pipeRegPc)
	);

endmodule

