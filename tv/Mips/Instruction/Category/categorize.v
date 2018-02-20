`ifndef MIPS_INSTRUCTION_CATEGORY_CATEGORIZE_I
`define MIPS_INSTRUCTION_CATEGORY_CATEGORIZE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/Source.v"

module Mips_Instruction_Category_categorize
	( `Mips_Instruction_OpFunc_OpFunc_T(input) opFunc
	, `Mips_Instruction_Category_Category_T(output) category
	);

`Mips_Instruction_Category_Category_T(reg) category$;
assign category = category$;

always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b0000??) : category$ = `Mips_Instruction_Category_Category_RShift  ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b0001??) : category$ = `Mips_Instruction_Category_Category_RShiftV ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b001???) : category$ = `Mips_Instruction_Category_Category_RShift  ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b010???) : category$ = `Mips_Instruction_Category_Category_RHilo   ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b011???) : category$ = `Mips_Instruction_Category_Category_RLong   ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b1000??) : category$ = `Mips_Instruction_Category_Category_RArith  ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b1001??) : category$ = `Mips_Instruction_Category_Category_RLogic  ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func , 6'b101???) : category$ = `Mips_Instruction_Category_Category_RComp   ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b000001) : category$ = `Mips_Instruction_Category_Category_Branch  ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b00001?) : category$ = `Mips_Instruction_Category_Category_Jump    ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b0001??) : category$ = `Mips_Instruction_Category_Category_Branch  ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b00100?) : category$ = `Mips_Instruction_Category_Category_Arith   ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b00101?) : category$ = `Mips_Instruction_Category_Category_Comp    ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b0011??) : category$ = `Mips_Instruction_Category_Category_Logic   ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b101???) : category$ = `Mips_Instruction_Category_Category_Store   ;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op   , 6'b100???) : category$ = `Mips_Instruction_Category_Category_Load    ;
		default                                                                                : category$ = `Mips_Instruction_Category_Category_Other   ;
	endcase

endmodule

`endif
