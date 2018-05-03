`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/Bool.v"

`include "Mips/Pipeline/Haz/Reg.v"
`include "Mips/Pipeline/Mem/Reg.v"
`include "Mips/Pipeline/Pc/Reg.v"
`include "Mips/Pipeline/Reg/Ex.v"
`include "Mips/Pipeline/Reg/Pc.v"
`include "Mips/Pipeline/Reg/Fwd.v"
`include "Mips/Pipeline/Reg/Haz.v"

`include "Mips/Datapath/Register/datapath.v"
`include "Mips/Datapath/Register/stall.v"
`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"

module Mips_Stage_reg #
	( parameter DELAYED = 1
	, parameter PASSTHROUGH = DELAYED
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Pipeline_HazReg_T (input) pipeHazReg
	, `Mips_Pipeline_MemReg_T (input) pipeMemReg
	, `Mips_Pipeline_PcReg_T  (input) pipePcReg
	, `Mips_Pipeline_RegHaz_T (output) pipeRegHaz
	, `Mips_Pipeline_RegEx_T  (output) pipeRegEx
	, `Mips_Pipeline_RegPc_T  (output) pipeRegPc
	, `Mips_Pipeline_RegFwd_T (output) pipeRegFwd
	);

`Mips_Type_Word_T (wire) pipePcReg_instruction ;
`Mips_Type_Word_T (wire) pipePcReg_pcAddr ;
Mips_Pipeline_PcReg_unpack PCREG
	( .in (pipePcReg)
	, .instruction (pipePcReg_instruction)
	, .pcAddr      (pipePcReg_pcAddr)
	);

`Mips_Type_Bool_T (wire) pipeHazReg_stall;
Mips_Pipeline_HazReg_unpack HAZREG
	( .in (pipeHazReg)
	, .stall (pipeHazReg_stall)
	);

`Mips_Type_Word_T (wire) pipeMemReg_instruction;
`Mips_Type_Word_T (wire) pipeMemReg_pcAddr;
`Mips_Type_Word_T (wire) pipeMemReg_memOut;
`Mips_Type_Word_T (wire) pipeMemReg_aluResult;
`Mips_Type_RegPorts_T (wire) pipeMemReg_regPorts;
Mips_Pipeline_MemReg_unpack MEMREG
	( .in (pipeMemReg)
	, .instruction (pipeMemReg_instruction)
	, .pcAddr      (pipeMemReg_pcAddr)
	, .memOut      (pipeMemReg_memOut)
	, .aluResult   (pipeMemReg_aluResult)
	, .regPorts    (pipeMemReg_regPorts)
	);

`Mips_Control_Control_T (wire) control;
Mips_Control_generate CTRL
	( .instruction (pipePcReg_instruction)
	, .control     (control)
	);

`Mips_Control_Control_T (wire) stall_control;
`Mips_Type_Word_T (wire) stall_instruction;
Mips_Datapath_Register_stall STALL
	( .stall (pipeHazReg_stall)
	, .inControl (control)
	, .outControl (stall_control)
	, .inInstruction (pipePcReg_instruction)
	, .outInstruction (stall_instruction)
	);

`Mips_Type_Word_T (wire) regPort1 ;
`Mips_Type_Word_T (wire) regPort2 ;
`Mips_Type_RegPorts_T (wire) regPorts ;
wire regPortEq ;
`Mips_Type_Word_T (wire) regWriteData ;
Mips_Datapath_Register_datapath #
	( .PASSTHROUGH (PASSTHROUGH)
	) REG
	( .ctrl (ctrl)
	, .control     (stall_control)
	, .instruction (stall_instruction)
	, .pcAddr      (pipeMemReg_pcAddr)
	, .memOut      (pipeMemReg_memOut)
	, .aluResult   (pipeMemReg_aluResult)
	, .portsIn     (pipeMemReg_regPorts)
	, .port1       (regPort1)
	, .port2       (regPort2)
	, .portEq      (regPortEq)
	, .portsOut    (regPorts)
	, .writeData   (regWriteData)
	);

Mips_Pipeline_RegEx_generate #
	( .DELAYED (DELAYED)
	) REGEX
	( .ctrl (ctrl)
	, .instruction (stall_instruction)
	, .pcAddr      (pipePcReg_pcAddr)
	, .regPort1    (regPort1)
	, .regPort2    (regPort2)
	, .regPorts    (regPorts)
	, .control     (stall_control)
	, .out         (pipeRegEx)
	);

Mips_Pipeline_RegPc_generate #
	( .DELAYED (DELAYED)
	) REGPC
	( .ctrl (ctrl)
	, .regPort1  (regPort1)
	, .regPortEq (regPortEq)
	, .control   (stall_control)
	, .out       (pipeRegPc)
	);

Mips_Pipeline_RegFwd_pack REGFWD
	( .out (pipeRegFwd)
	, .writeData (regWriteData)
	, .regPorts  (pipeMemReg_regPorts)
	);

Mips_Pipeline_RegHaz_pack REGHAZ
	( .out (pipeRegHaz)
	, .control (control)
	, .instruction (pipePcReg_instruction)
	);

endmodule

