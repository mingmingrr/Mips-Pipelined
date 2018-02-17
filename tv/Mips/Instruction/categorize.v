`ifndef INSTRUCTION_CATEGORIZE_M
`define INSTRUCTION_CATEGORIZE_M

`include "../../Mips/Instruction/Category.v"
`include "../../Mips/Instruction/OpFunc/OpFunc.v"

module Instruction_categorize
	( `Opcode_OpFunc_T(input) opFunc
	, `Instruction_Category_T(output) category
	);

`Instruction_Category_T(reg) category$;
assign category = category$;

always @(*)
	casez(opFunc)
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b0000??):
			category$ = `Instruction_Category_RShift_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b0001??):
			category$ = `Instruction_Category_RShiftV_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b001???):
			category$ = `Instruction_Category_RShift_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b010???):
			category$ = `Instruction_Category_RHilo_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b011???):
			category$ = `Instruction_Category_RLong_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b1000??):
			category$ = `Instruction_Category_RArith_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b1001??):
			category$ = `Instruction_Category_RLogic_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Func, 6'b101???):
			category$ = `Instruction_Category_RComp_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b000001):
			category$ = `Instruction_Category_Branch_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b00001?):
			category$ = `Instruction_Category_Jump_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b0001??):
			category$ = `Instruction_Category_Branch_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b00100?):
			category$ = `Instruction_Category_Arith_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b00101?):
			category$ = `Instruction_Category_Comp_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b0011??):
			category$ = `Instruction_Category_Logic_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b101???):
			category$ = `Instruction_Category_Store_V;
		`Opcode_OpFunc_Init(`Opcode_Source_Op, 6'b100???):
			category$ = `Instruction_Category_Load_V;
		default:
			category$ = `Instruction_Category_Other_V;
	endcase

endmodule

`endif
