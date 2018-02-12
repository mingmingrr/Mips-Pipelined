// vim: set ft=verilog:

`ifndef OPCODE_OPFUNC_M
`define OPCODE_OPFUNC_M

`include "../Opcode/Opcode_Source.v"

`define Opcode_OpFunc_Source_I 6
`define Opcode_OpFunc_Source_W 1
`define Opcode_OpFunc_Source_T(T) T
`define Opcode_OpFunc_Source(x) \
	x [ `Opcode_OpFunc_Source_I ]

`define Opcode_OpFunc_OpFunc_I 0
`define Opcode_OpFunc_OpFunc_W 6
`define Opcode_OpFunc_OpFunc_T(T) T [`Opcode_OpFunc_OpFunc_W-1:0]
`define Opcode_OpFunc_OpFunc(x) \
	x \
		[ `Opcode_OpFunc_OpFunc_W \
		+ `Opcode_OpFunc_OpFunc_I - 1 \
		: `Opcode_OpFunc_OpFunc_I ]


`define Opcode_OpFunc_W 7
`define Opcode_OpFunc_L 57
`define Opcode_OpFunc_T(T) T [`Opcode_OpFunc_W-1:0]
`define Opcode_OpFunc_Init(Source, OpFunc) \
	{ `Opcode_OpFunc_Source_W'(Source) \
	, `Opcode_OpFunc_OpFunc_W'(OpFunc) \
	}

`define Opcode_OpFunc_Add     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100000 )
`define Opcode_OpFunc_Addi    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001000 )
`define Opcode_OpFunc_Addiu   `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001001 )
`define Opcode_OpFunc_Addu    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100001 )
`define Opcode_OpFunc_And     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100100 )
`define Opcode_OpFunc_Andi    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001100 )
`define Opcode_OpFunc_Lui     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001111 )
`define Opcode_OpFunc_Nor     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100111 )
`define Opcode_OpFunc_Or      `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100101 )
`define Opcode_OpFunc_Ori     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001101 )
`define Opcode_OpFunc_Slt     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b101010 )
`define Opcode_OpFunc_Slti    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001010 )
`define Opcode_OpFunc_Sltiu   `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001011 )
`define Opcode_OpFunc_Sltu    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b101011 )
`define Opcode_OpFunc_Sub     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100010 )
`define Opcode_OpFunc_Subu    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100011 )
`define Opcode_OpFunc_Xor     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b100110 )
`define Opcode_OpFunc_Xori    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b001110 )
`define Opcode_OpFunc_Sll     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000000 )
`define Opcode_OpFunc_Sllv    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000100 )
`define Opcode_OpFunc_Sra     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000011 )
`define Opcode_OpFunc_Srav    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000111 )
`define Opcode_OpFunc_Srl     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000010 )
`define Opcode_OpFunc_Srlv    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000110 )
`define Opcode_OpFunc_Div     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b011010 )
`define Opcode_OpFunc_Divu    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b011011 )
`define Opcode_OpFunc_Mfhi    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b010000 )
`define Opcode_OpFunc_Mflo    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b010010 )
`define Opcode_OpFunc_Mthi    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b010001 )
`define Opcode_OpFunc_Mtlo    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b010011 )
`define Opcode_OpFunc_Mult    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b011000 )
`define Opcode_OpFunc_Multu   `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b011001 )
`define Opcode_OpFunc_Beq     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000100 )
`define Opcode_OpFunc_Bgez    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_OpFunc_Bgezal  `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_OpFunc_Bgtz    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000111 )
`define Opcode_OpFunc_Blez    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000110 )
`define Opcode_OpFunc_Bltz    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_OpFunc_Bltzal  `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_OpFunc_Bne     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000101 )
`define Opcode_OpFunc_Break   `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b001101 )
`define Opcode_OpFunc_Syscall `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b001100 )
`define Opcode_OpFunc_J       `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000010 )
`define Opcode_OpFunc_Jal     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b000011 )
`define Opcode_OpFunc_Jalr    `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b001001 )
`define Opcode_OpFunc_Jr      `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b001000 )
`define Opcode_OpFunc_Mfc0    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b010000 )
`define Opcode_OpFunc_Mtc0    `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b010000 )
`define Opcode_OpFunc_Lb      `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b100000 )
`define Opcode_OpFunc_Lbu     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b100100 )
`define Opcode_OpFunc_Lh      `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b100001 )
`define Opcode_OpFunc_Lhu     `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b100101 )
`define Opcode_OpFunc_Lw      `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b100011 )
`define Opcode_OpFunc_Sb      `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b101000 )
`define Opcode_OpFunc_Sh      `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b101001 )
`define Opcode_OpFunc_Sw      `Opcode_OpFunc_Init( `Opcode_Source_Op   , 6'b101011 )
`define Opcode_OpFunc_Nop     `Opcode_OpFunc_Init( `Opcode_Source_Func , 6'b000000 )

`endif
