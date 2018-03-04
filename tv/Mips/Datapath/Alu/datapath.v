`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"

`include "Mips/Control/Type/Signal/Alu/Control.v"
`include "Mips/Control/Type/Signal/Alu/Signal/Data2Source.v"

`include "Mips/Datapath/Alu/hilo.v"
`include "Mips/Datapath/Alu/decode.v"

module Mips_Datapath_Alu_datapath
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Control_Type_Signal_Alu_Control_T(input) control
	, `Mips_Instruction_OpFunc_OpFunc_T(input) opFunc
	, `Mips_Type_Word_T(input) regPort1
	, `Mips_Type_Word_T(input) regPort2
	, `Mips_Type_Word_T(input) shamt
	, `Mips_Type_Word_T(input) immediate
	, `Mips_Type_Word_T  (output) result
	, `Mips_Datapath_Alu_Status_T (output) status
	);

`Mips_Datapath_Alu_Func_T (wire) func ;
Mips_Datapath_Alu_decode DEC
	( .opFunc (opFunc)
	, .func   (func)
	);

`Mips_Type_Word_T  (wire) data1  ;
`Mips_Type_Word_T  (wire) data2  ;
Mips_Datapath_Alu_hilo #
	( .DATA_W (32)
	) ALU
	( .ctrl   (ctrl)
	, .func   (func)
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
		default                                               : data2$ = regPort2;
	endcase
assign data2 = data2$;

endmodule
