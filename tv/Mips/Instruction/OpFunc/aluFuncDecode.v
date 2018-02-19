`ifndef MIPS_INSTRUCTION_OPFUNC_ALUFUNCDECODE_I
`define MIPS_INSTRUCTION_OPFUNC_ALUFUNCDECODE_I

`include "Mips/Alu/Func.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/OpFuncs.v"

module Mips_Instruction_OpFunc_aluFuncDecode
	( `Mips_Instruction_OpFunc_OpFunc_T(input) opFunc
	, `Mips_Alu_Func_T(output) func
	);

`Mips_Alu_Func_T(reg) func$;
assign func = func$;

always @ (*)
	case(opFunc)
		`Mips_Instruction_OpFunc_OpFuncs_Add     : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Addi    : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Addiu   : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Addu    : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_And     : func$ = `Mips_Alu_Func_And  ;
		`Mips_Instruction_OpFunc_OpFuncs_Andi    : func$ = `Mips_Alu_Func_And  ;
		`Mips_Instruction_OpFunc_OpFuncs_Lui     : func$ = `Mips_Alu_Func_Sll  ;
		`Mips_Instruction_OpFunc_OpFuncs_Nor     : func$ = `Mips_Alu_Func_Nor  ;
		`Mips_Instruction_OpFunc_OpFuncs_Or      : func$ = `Mips_Alu_Func_Or   ;
		`Mips_Instruction_OpFunc_OpFuncs_Ori     : func$ = `Mips_Alu_Func_Or   ;
		`Mips_Instruction_OpFunc_OpFuncs_Slt     : func$ = `Mips_Alu_Func_Slts ;
		`Mips_Instruction_OpFunc_OpFuncs_Slti    : func$ = `Mips_Alu_Func_Slts ;
		`Mips_Instruction_OpFunc_OpFuncs_Sltiu   : func$ = `Mips_Alu_Func_Sltu ;
		`Mips_Instruction_OpFunc_OpFuncs_Sltu    : func$ = `Mips_Alu_Func_Sltu ;
		`Mips_Instruction_OpFunc_OpFuncs_Sub     : func$ = `Mips_Alu_Func_Sub  ;
		`Mips_Instruction_OpFunc_OpFuncs_Subu    : func$ = `Mips_Alu_Func_Sub  ;
		`Mips_Instruction_OpFunc_OpFuncs_Xor     : func$ = `Mips_Alu_Func_Xor  ;
		`Mips_Instruction_OpFunc_OpFuncs_Xori    : func$ = `Mips_Alu_Func_Xor  ;
		`Mips_Instruction_OpFunc_OpFuncs_Sll     : func$ = `Mips_Alu_Func_Sll  ;
		`Mips_Instruction_OpFunc_OpFuncs_Sllv    : func$ = `Mips_Alu_Func_Sll  ;
		`Mips_Instruction_OpFunc_OpFuncs_Sra     : func$ = `Mips_Alu_Func_Sra  ;
		`Mips_Instruction_OpFunc_OpFuncs_Srav    : func$ = `Mips_Alu_Func_Sra  ;
		`Mips_Instruction_OpFunc_OpFuncs_Srl     : func$ = `Mips_Alu_Func_Srl  ;
		`Mips_Instruction_OpFunc_OpFuncs_Srlv    : func$ = `Mips_Alu_Func_Srl  ;
		`Mips_Instruction_OpFunc_OpFuncs_Div     : func$ = `Mips_Alu_Func_Divs ;
		`Mips_Instruction_OpFunc_OpFuncs_Divu    : func$ = `Mips_Alu_Func_Divu ;
		`Mips_Instruction_OpFunc_OpFuncs_Mfhi    : func$ = `Mips_Alu_Func_Mfhi ;
		`Mips_Instruction_OpFunc_OpFuncs_Mflo    : func$ = `Mips_Alu_Func_Mflo ;
		`Mips_Instruction_OpFunc_OpFuncs_Mthi    : func$ = `Mips_Alu_Func_Mthi ;
		`Mips_Instruction_OpFunc_OpFuncs_Mtlo    : func$ = `Mips_Alu_Func_Mtlo ;
		`Mips_Instruction_OpFunc_OpFuncs_Mult    : func$ = `Mips_Alu_Func_Muls ;
		`Mips_Instruction_OpFunc_OpFuncs_Multu   : func$ = `Mips_Alu_Func_Mulu ;
		`Mips_Instruction_OpFunc_OpFuncs_Beq     : func$ = `Mips_Alu_Func_Sub  ;
		`Mips_Instruction_OpFunc_OpFuncs_Bgez    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Bgezal  : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Bgtz    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Blez    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Bltz    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Bltzal  : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Bne     : func$ = `Mips_Alu_Func_Sub  ;
		`Mips_Instruction_OpFunc_OpFuncs_Break   : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Syscall : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_J       : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Jal     : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Jalr    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Jr      : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Mfc0    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Mtc0    : func$ = `Mips_Alu_Func_None ;
		`Mips_Instruction_OpFunc_OpFuncs_Lb      : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Lbu     : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Lh      : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Lhu     : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Lw      : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Sb      : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Sh      : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Sw      : func$ = `Mips_Alu_Func_Add  ;
		`Mips_Instruction_OpFunc_OpFuncs_Nop     : func$ = `Mips_Alu_Func_None ;
		default                                  : func$ = `Mips_Alu_Func_None ;
	endcase

endmodule

`endif
