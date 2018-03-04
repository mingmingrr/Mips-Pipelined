`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/Format/IFormat.v"

`include "Mips/Control/Type/Signal/Alu/Control.v"
`include "Mips/Control/Type/Signal/Alu/Signal/Data2Source.v"
`include "Mips/Control/Type/Signal/Alu/Signal/Func.v"

`include "Mips/Datapath/Alu/hilo.v"
`include "Mips/Datapath/Alu/immediate.v"

module Mips_Datapath_Alu_datapath
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Control_Type_Signal_Alu_Control_T(input) control
	, `Mips_Type_Word_T(input) regPort1
	, `Mips_Type_Word_T(input) regPort2
	, `Mips_Type_Word_T(input) instruction
	, `Mips_Type_Word_T(output) result
	, `Mips_Datapath_Alu_Status_T (output) status
	);

`Mips_Type_Word_T (wire) shamt;
assign shamt = `Mips_Instruction_Format_RFormat_Shamt(instruction);

`Mips_Type_Word_T (wire) immediate;
Mips_Datapath_Alu_immediate IMM
	( .control (control)
	, .immIn   (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .immOut  (immediate)
	);

`Mips_Type_Word_T (wire) data1;
`Mips_Type_Word_T (wire) data2;
Mips_Datapath_Alu_hilo #
	( .DATA_W (32)
	) ALU
	( .ctrl   (ctrl)
	, .func   (`Mips_Control_Type_Signal_Alu_Control_Func(control))
	, .data1  (data1)
	, .data2  (data2)
	, .result (result)
	, .status (status)
	);

assign data1 = regPort1;

`Mips_Type_Word_T (reg) data2$ ;
always @(*)
	case(`Mips_Control_Type_Signal_Alu_Control_Data2Source(control))
		`Mips_Control_Type_Signal_Alu_Signal_Data2Source_Immediate : data2$ = immediate;
		`Mips_Control_Type_Signal_Alu_Signal_Data2Source_Shamt     : data2$ = shamt;
		`Mips_Control_Type_Signal_Alu_Signal_Data2Source_Register  : data2$ = regPort2;
		default                                                    : data2$ = regPort2;
	endcase
assign data2 = data2$;

endmodule
