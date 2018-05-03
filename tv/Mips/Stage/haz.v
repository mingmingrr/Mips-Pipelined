`include "Mips/Type/Word.v"
`include "Mips/Type/Bool.v"
`include "Mips/Type/RegPorts.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Register/Control.v"

`include "Mips/Pipeline/Ex/Haz.v"
`include "Mips/Pipeline/Reg/Haz.v"
`include "Mips/Pipeline/Haz/Reg.v"

`include "Mips/Hazard/hazard.v"

module Mips_Stage_haz #
	( parameter ENABLE = 1
	)
	( `Mips_Pipeline_HazReg_T (output) pipeHazReg
	, `Mips_Pipeline_ExHaz_T (input) pipeExHaz
	, `Mips_Pipeline_RegHaz_T (input) pipeRegHaz
	);

`Mips_Control_Control_T (wire) pipeEx_Control;
`Mips_Type_RegPorts_T (wire) pipeEx_RegPorts;
Mips_Pipeline_ExHaz_unpack EXHAZ
	( .in (pipeExHaz)
	, .regPorts (pipeEx_RegPorts)
	);

`Mips_Type_Word_T (wire) pipeReg_Instruction;
`Mips_Control_Control_T (wire) pipeReg_Control;
Mips_Pipeline_RegHaz_unpack REGHAZ
	( .in (pipeRegHaz)
	, .control (pipeReg_Control)
	, .instruction (pipeReg_Instruction)
	);

`Mips_Type_RegPorts_T (wire) pipeReg_RegPorts;
Mips_Datapath_Register_ports PORTS
	( .ports (pipeReg_RegPorts)
	, .control (pipeReg_Control)
	, .instruction (pipeReg_Instruction)
	);

`Mips_Control_Signal_Register_Control_T (wire) pipeEx_RegControl;

`Mips_Type_Bool_T (wire) stallLwRead;
Mips_Hazard_hazard HAZ
	( .stallLwRead (stallLwRead)
	, .regRead1Addr (`Mips_Type_RegPorts_Read1Addr(pipeReg_RegPorts))
	, .regRead2Addr (`Mips_Type_RegPorts_Read2Addr(pipeReg_RegPorts))
	, .exWriteData (`Mips_Type_RegPorts_WriteData(pipeEx_RegPorts))
	, .exWriteAddr (`Mips_Type_RegPorts_WriteAddr(pipeEx_RegPorts))
	);

`Mips_Type_Bool_T (wire) stall;
assign stall = 1'(ENABLE) && stallLwRead;

Mips_Pipeline_HazReg_pack HAZREG
	( .out (pipeHazReg)
	, .stall (stall)
	);

endmodule



