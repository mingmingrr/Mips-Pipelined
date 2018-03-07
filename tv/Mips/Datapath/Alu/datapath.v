`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/AluStatus.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/Format/IFormat.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Alu/Control.v"
`include "Mips/Control/Signal/Alu/Signal/Data1Source.v"
`include "Mips/Control/Signal/Alu/Signal/Data2Source.v"
`include "Mips/Control/Signal/Alu/Signal/Func.v"

`include "Mips/Datapath/Alu/hilo.v"
`include "Mips/Datapath/Alu/immediate.v"
`include "Mips/Datapath/Alu/data1.v"
`include "Mips/Datapath/Alu/data2.v"

module Mips_Datapath_Alu_datapath
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Type_Word_T       (input) instruction
	, `Mips_Type_Word_T       (input) regPort1
	, `Mips_Type_Word_T       (input) regPort2
	, `Mips_Control_Control_T (input) control
	, `Mips_Type_Word_T       (output) result
	, `Mips_Type_AluStatus_T  (output) status
	);

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

Mips_Datapath_Alu_data1 DATA1
	( .control   (`Mips_Control_Signal_Alu_Control_Data1Source(aluControl))
	, .shamt     (shamt)
	, .regPort1  (regPort1)
	, .data1     (data1)
	);

Mips_Datapath_Alu_data2 DATA2
	( .control   (`Mips_Control_Signal_Alu_Control_Data2Source(aluControl))
	, .immediate (immediate)
	, .regPort2  (regPort2)
	, .data2     (data2)
	);

endmodule
