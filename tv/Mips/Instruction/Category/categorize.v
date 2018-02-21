`ifndef MIPS_INSTRUCTION_CATEGORY_CATEGORIZE_I
`define MIPS_INSTRUCTION_CATEGORY_CATEGORIZE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/OpFuncs.v"
`include "Mips/Instruction/OpFunc/Source.v"

module Mips_Instruction_Category_categorize
	( `Mips_Instruction_OpFunc_OpFunc_T(input)      opFunc
	, `Mips_Instruction_Format_RFormat_Rt_T(input)  branchOp
	, `Mips_Instruction_Category_Category_T(output) category
	);


reg register;
always @(*)
	casez(`Mips_Instruction_OpFunc_OpFunc_Source(opFunc))
		`Mips_Instruction_OpFunc_Source_Func : register = 1'b1;
		`Mips_Instruction_OpFunc_Source_Op   : register = 1'b0;
		default                               : register = 1'b0;
	endcase

reg immediate;
always @(*)
	casez(`Mips_Instruction_OpFunc_OpFunc_Source(opFunc))
		`Mips_Instruction_OpFunc_Source_Op   : immediate = 1'b1;
		`Mips_Instruction_OpFunc_Source_Func : immediate = 1'b0;
		default                              : immediate = 1'b0;
	endcase

reg jump;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b001???) : jump = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b00001?) : jump = 1'b1;
		default                                                                                : jump = 1'b0;
	endcase

reg branch;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b000001) : branch = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b0001??) : branch = 1'b1;
		default                                                                             : branch = 1'b0;
	endcase

reg link;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b000011) : link = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b001001) : link = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b000001) : link = branchOp[4];
		default                                                                                : link = 1'b0;
	endcase

reg shift;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b000???) : shift = 1'b1;
		default                                                                                : shift = 1'b0;
	endcase

reg shiftV;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b0001??) : shiftV = 1'b1;
		default                                                                                : shiftV = 1'b0;
	endcase

reg hilo;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b010???) : hilo = 1'b1;
		default                                                                                : hilo = 1'b0;
	endcase

reg mulDiv;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b011???) : mulDiv = 1'b1;
		default                                                                                : mulDiv = 1'b0;
	endcase

reg compare;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b101???) : compare = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b00101?) : compare = 1'b1;
		default                                                                                : compare = 1'b0;
	endcase

reg logic;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b1001??) : logic = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b0011??) : logic = 1'b1;
		default                                                                                : logic = 1'b0;
	endcase

reg arithmetic;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b1000??) : arithmetic = 1'b1;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b00100?) : arithmetic = 1'b1;
		default                                                                                : arithmetic = 1'b0;
	endcase

reg load;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b100???) : load = 1'b1;
		default                                                                                : load = 1'b0;
	endcase

reg store;
always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b101???) : store = 1'b1;
		default                                                                                : store = 1'b0;
	endcase

assign category = `Mips_Instruction_Category_Category_Init_Defaults;

endmodule

`endif

