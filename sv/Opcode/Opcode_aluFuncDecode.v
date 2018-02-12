// vim: set ft=verilog:

`ifndef OPCODE_ALUFUNCDECODE_I
`define OPCODE_ALUFUNCDECODE_I

`include "../Alu/Alu_Func.v"
`include "../Opcode/Opcode_Opcode.v"

module Opcode_aluFuncDecode
	( `Opcode_Opcode_T(input) op
	, `Alu_Func_T(output) func
	);

`Alu_Func_T(reg) func$;
assign func = func$;

always @ (*)
	case(op)
		`Opcode_Opcode_Add     : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Addi    : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Addiu   : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Addu    : func$ = `Alu_Func_Add;
		`Opcode_Opcode_And     : func$ = `Alu_Func_And;
		`Opcode_Opcode_Andi    : func$ = `Alu_Func_And;
		`Opcode_Opcode_Lui     : func$ = `Alu_Func_Sll;
		`Opcode_Opcode_Nor     : func$ = `Alu_Func_Nor;
		`Opcode_Opcode_Or      : func$ = `Alu_Func_Or;
		`Opcode_Opcode_Ori     : func$ = `Alu_Func_Or;
		`Opcode_Opcode_Slt     : func$ = `Alu_Func_Slts;
		`Opcode_Opcode_Slti    : func$ = `Alu_Func_Slts;
		`Opcode_Opcode_Sltiu   : func$ = `Alu_Func_Sltu;
		`Opcode_Opcode_Sltu    : func$ = `Alu_Func_Sltu;
		`Opcode_Opcode_Sub     : func$ = `Alu_Func_Sub;
		`Opcode_Opcode_Subu    : func$ = `Alu_Func_Sub;
		`Opcode_Opcode_Xor     : func$ = `Alu_Func_Xor;
		`Opcode_Opcode_Xori    : func$ = `Alu_Func_Xor;
		`Opcode_Opcode_Sll     : func$ = `Alu_Func_Sll;
		`Opcode_Opcode_Sllv    : func$ = `Alu_Func_Sll;
		`Opcode_Opcode_Sra     : func$ = `Alu_Func_Sra;
		`Opcode_Opcode_Srav    : func$ = `Alu_Func_Sra;
		`Opcode_Opcode_Srl     : func$ = `Alu_Func_Srl;
		`Opcode_Opcode_Srlv    : func$ = `Alu_Func_Srl;
		`Opcode_Opcode_Div     : func$ = `Alu_Func_Divs;
		`Opcode_Opcode_Divu    : func$ = `Alu_Func_Divu;
		`Opcode_Opcode_Mfhi    : func$ = `Alu_Func_Mfhi;
		`Opcode_Opcode_Mflo    : func$ = `Alu_Func_Mflo;
		`Opcode_Opcode_Mthi    : func$ = `Alu_Func_Mthi;
		`Opcode_Opcode_Mtlo    : func$ = `Alu_Func_Mtlo;
		`Opcode_Opcode_Mult    : func$ = `Alu_Func_Muls;
		`Opcode_Opcode_Multu   : func$ = `Alu_Func_Mulu;
		`Opcode_Opcode_Beq     : func$ = `Alu_Func_Sub;
		`Opcode_Opcode_Bgez    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Bgezal  : func$ = `Alu_Func_None;
		`Opcode_Opcode_Bgtz    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Blez    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Bltz    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Bltzal  : func$ = `Alu_Func_None;
		`Opcode_Opcode_Bne     : func$ = `Alu_Func_Sub;
		`Opcode_Opcode_Break   : func$ = `Alu_Func_None;
		`Opcode_Opcode_Syscall : func$ = `Alu_Func_None;
		`Opcode_Opcode_J       : func$ = `Alu_Func_None;
		`Opcode_Opcode_Jal     : func$ = `Alu_Func_None;
		`Opcode_Opcode_Jalr    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Jr      : func$ = `Alu_Func_None;
		`Opcode_Opcode_Mfc0    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Mtc0    : func$ = `Alu_Func_None;
		`Opcode_Opcode_Lb      : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Lbu     : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Lh      : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Lhu     : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Lw      : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Sb      : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Sh      : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Sw      : func$ = `Alu_Func_Add;
		`Opcode_Opcode_Nop     : func$ = `Alu_Func_None;
		default                : func$ = `Alu_Func_None;
	endcase

endmodule

`endif
