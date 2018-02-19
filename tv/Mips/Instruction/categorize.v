`ifndef MIPS_INSTRUCTION_CATEGORIZE_M
`define MIPS_INSTRUCTION_CATEGORIZE_M

`include "Mips/Instruction/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/Source.v"

module Mips_Instruction_categorize
	( `Mips_Instruction_OpFunc_OpFunc_T(input) opFunc
	, `Mips_Instruction_Category_T(output) category
	);

`Mips_Instruction_Category_T(reg) category$;
assign category = category$;

always @(*)
	casez(opFunc)
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b0000??):
			category$ = `Mips_Instruction_Category_RShift_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b0001??):
			category$ = `Mips_Instruction_Category_RShiftV_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b001???):
			category$ = `Mips_Instruction_Category_RShift_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b010???):
			category$ = `Mips_Instruction_Category_RHilo_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b011???):
			category$ = `Mips_Instruction_Category_RLong_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b1000??):
			category$ = `Mips_Instruction_Category_RArith_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b1001??):
			category$ = `Mips_Instruction_Category_RLogic_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Func, 6'b101???):
			category$ = `Mips_Instruction_Category_RComp_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b000001):
			category$ = `Mips_Instruction_Category_Branch_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b00001?):
			category$ = `Mips_Instruction_Category_Jump_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b0001??):
			category$ = `Mips_Instruction_Category_Branch_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b00100?):
			category$ = `Mips_Instruction_Category_Arith_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b00101?):
			category$ = `Mips_Instruction_Category_Comp_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b0011??):
			category$ = `Mips_Instruction_Category_Logic_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b101???):
			category$ = `Mips_Instruction_Category_Store_V;
		`Mips_Instruction_OpFunc_OpFunc_Init(`Mips_Instruction_OpFunc_Source_Op, 6'b100???):
			category$ = `Mips_Instruction_Category_Load_V;
		default:
			category$ = `Mips_Instruction_Category_Other_V;
	endcase

endmodule

`endif
