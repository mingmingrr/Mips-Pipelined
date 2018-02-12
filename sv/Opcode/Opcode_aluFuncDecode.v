// vim: set ft=verilog:

`ifndef OPCODE_ALUFUNCDECODE_I
`define OPCODE_ALUFUNCDECODE_I

`include "../Alu/Alu_Func.v"
`include "../Opcode/Opcode_OpFunc.v"

module Opcode_aluFuncDecode
	( `Opcode_OpFunc_T(input) opfunc
	, `Alu_Func_T(output) func
	);

`Alu_Func_T(reg) func$;
assign func = func$;

always @ (*)
	case(opfunc)
		`Opcode_OpFunc_Add     : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Addi    : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Addiu   : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Addu    : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_And     : func$ = `Alu_Func_And;
		`Opcode_OpFunc_Andi    : func$ = `Alu_Func_And;
		`Opcode_OpFunc_Lui     : func$ = `Alu_Func_Sll;
		`Opcode_OpFunc_Nor     : func$ = `Alu_Func_Nor;
		`Opcode_OpFunc_Or      : func$ = `Alu_Func_Or;
		`Opcode_OpFunc_Ori     : func$ = `Alu_Func_Or;
		`Opcode_OpFunc_Slt     : func$ = `Alu_Func_Slts;
		`Opcode_OpFunc_Slti    : func$ = `Alu_Func_Slts;
		`Opcode_OpFunc_Sltiu   : func$ = `Alu_Func_Sltu;
		`Opcode_OpFunc_Sltu    : func$ = `Alu_Func_Sltu;
		`Opcode_OpFunc_Sub     : func$ = `Alu_Func_Sub;
		`Opcode_OpFunc_Subu    : func$ = `Alu_Func_Sub;
		`Opcode_OpFunc_Xor     : func$ = `Alu_Func_Xor;
		`Opcode_OpFunc_Xori    : func$ = `Alu_Func_Xor;
		`Opcode_OpFunc_Sll     : func$ = `Alu_Func_Sll;
		`Opcode_OpFunc_Sllv    : func$ = `Alu_Func_Sll;
		`Opcode_OpFunc_Sra     : func$ = `Alu_Func_Sra;
		`Opcode_OpFunc_Srav    : func$ = `Alu_Func_Sra;
		`Opcode_OpFunc_Srl     : func$ = `Alu_Func_Srl;
		`Opcode_OpFunc_Srlv    : func$ = `Alu_Func_Srl;
		`Opcode_OpFunc_Div     : func$ = `Alu_Func_Divs;
		`Opcode_OpFunc_Divu    : func$ = `Alu_Func_Divu;
		`Opcode_OpFunc_Mfhi    : func$ = `Alu_Func_Mfhi;
		`Opcode_OpFunc_Mflo    : func$ = `Alu_Func_Mflo;
		`Opcode_OpFunc_Mthi    : func$ = `Alu_Func_Mthi;
		`Opcode_OpFunc_Mtlo    : func$ = `Alu_Func_Mtlo;
		`Opcode_OpFunc_Mult    : func$ = `Alu_Func_Muls;
		`Opcode_OpFunc_Multu   : func$ = `Alu_Func_Mulu;
		`Opcode_OpFunc_Beq     : func$ = `Alu_Func_Sub;
		`Opcode_OpFunc_Bgez    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Bgezal  : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Bgtz    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Blez    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Bltz    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Bltzal  : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Bne     : func$ = `Alu_Func_Sub;
		`Opcode_OpFunc_Break   : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Syscall : func$ = `Alu_Func_None;
		`Opcode_OpFunc_J       : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Jal     : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Jalr    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Jr      : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Mfc0    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Mtc0    : func$ = `Alu_Func_None;
		`Opcode_OpFunc_Lb      : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Lbu     : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Lh      : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Lhu     : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Lw      : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Sb      : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Sh      : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Sw      : func$ = `Alu_Func_Add;
		`Opcode_OpFunc_Nop     : func$ = `Alu_Func_None;
		default                : func$ = `Alu_Func_None;
	endcase

endmodule

`endif
