`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/Format/IFormat.v"

`include "Mips/Pipeline/IdEx/Pipeline.v"

`include "Mips/Control/Signal/Alu/Control.v"
`include "Mips/Control/Signal/Alu/Signal/Data2Source.v"
`include "Mips/Control/Signal/Alu/Signal/Func.v"

`include "Mips/Datapath/Alu/hilo.v"
`include "Mips/Datapath/Alu/immediate.v"
`include "Mips/Datapath/Alu/data2.v"

module Mips_Datapath_Alu_datapath
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Pipeline_IdEx_Pipeline_T(input) pipeIdEx
	, `Mips_Type_Word_T(output) result
	, `Mips_Datapath_Alu_Status_T (output) status
	);

`Mips_Pipeline_IdEx_Pipeline_Unpack(pipeIdEx)

`Mips_Control_Signal_Alu_Control_T(wire) aluControl;
assign aluControl = `Mips_Control_Control_Alu(control);

`Mips_Type_Word_T (wire) shamt;
assign shamt = `Mips_Instruction_Format_RFormat_Shamt(instruction);

`Mips_Type_Word_T (wire) immediate;
Mips_Datapath_Alu_immediate IMM
	( .control (aluControl)
	, .immIn   (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .immOut  (immediate)
	);

`Mips_Type_Word_T (wire) data1;
`Mips_Type_Word_T (wire) data2;
Mips_Datapath_Alu_hilo #
	( .DATA_W (32)
	) ALU
	( .ctrl   (ctrl)
	, .func   (`Mips_Control_Signal_Alu_Control_Func(aluControl))
	, .data1  (data1)
	, .data2  (data2)
	, .result (result)
	, .status (status)
	);

assign data1 = regPort1;

Mips_Datapath_Alu_data2 DATA2
	( .control   (`Mips_Control_Signal_Alu_Control_Data2Source(aluControl))
	, .immediate (immediate)
	, .shamt     (shamt)
	, .regPort2  (regPort2)
	, .data2     (data2)
	);

endmodule
