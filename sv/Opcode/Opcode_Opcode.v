// vim: set ft=verilog:

`ifndef OPCODE_OPCODE_M
`define OPCODE_OPCODE_M

`include "../Opcode/Opcode_Source.v"

`define Opcode_Opcode_T(T) T [6:0]
`define Opcode_Opcode_W 7
`define Opcode_Opcode_L 57

`define Opcode_Opcode_Init(Source, Opcode) {Source, Opcode}

`define Opcode_Opcode_Source(x) x[6]
`define Opcode_Opcode_Source_T(T) T
`define Opcode_Opcode_Opcode(x) x[5:0]
`define Opcode_Opcode_Opcode_T(T) T [5:0]

`define Opcode_Opcode_Add     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100000 )
`define Opcode_Opcode_Addi    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001000 )
`define Opcode_Opcode_Addiu   `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001001 )
`define Opcode_Opcode_Addu    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100001 )
`define Opcode_Opcode_And     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100100 )
`define Opcode_Opcode_Andi    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001100 )
`define Opcode_Opcode_Lui     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001111 )
`define Opcode_Opcode_Nor     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100111 )
`define Opcode_Opcode_Or      `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100101 )
`define Opcode_Opcode_Ori     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001101 )
`define Opcode_Opcode_Slt     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b101010 )
`define Opcode_Opcode_Slti    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001010 )
`define Opcode_Opcode_Sltiu   `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001011 )
`define Opcode_Opcode_Sltu    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b101011 )
`define Opcode_Opcode_Sub     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100010 )
`define Opcode_Opcode_Subu    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100011 )
`define Opcode_Opcode_Xor     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b100110 )
`define Opcode_Opcode_Xori    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b001110 )
`define Opcode_Opcode_Sll     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000000 )
`define Opcode_Opcode_Sllv    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000100 )
`define Opcode_Opcode_Sra     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000011 )
`define Opcode_Opcode_Srav    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000111 )
`define Opcode_Opcode_Srl     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000010 )
`define Opcode_Opcode_Srlv    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000110 )
`define Opcode_Opcode_Div     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b011010 )
`define Opcode_Opcode_Divu    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b011011 )
`define Opcode_Opcode_Mfhi    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b010000 )
`define Opcode_Opcode_Mflo    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b010010 )
`define Opcode_Opcode_Mthi    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b010001 )
`define Opcode_Opcode_Mtlo    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b010011 )
`define Opcode_Opcode_Mult    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b011000 )
`define Opcode_Opcode_Multu   `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b011001 )
`define Opcode_Opcode_Beq     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000100 )
`define Opcode_Opcode_Bgez    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_Opcode_Bgezal  `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_Opcode_Bgtz    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000111 )
`define Opcode_Opcode_Blez    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000110 )
`define Opcode_Opcode_Bltz    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_Opcode_Bltzal  `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000001 )
`define Opcode_Opcode_Bne     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000101 )
`define Opcode_Opcode_Break   `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b001101 )
`define Opcode_Opcode_Syscall `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b001100 )
`define Opcode_Opcode_J       `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000010 )
`define Opcode_Opcode_Jal     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b000011 )
`define Opcode_Opcode_Jalr    `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b001001 )
`define Opcode_Opcode_Jr      `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b001000 )
`define Opcode_Opcode_Mfc0    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b010000 )
`define Opcode_Opcode_Mtc0    `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b010000 )
`define Opcode_Opcode_Lb      `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b100000 )
`define Opcode_Opcode_Lbu     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b100100 )
`define Opcode_Opcode_Lh      `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b100001 )
`define Opcode_Opcode_Lhu     `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b100101 )
`define Opcode_Opcode_Lw      `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b100011 )
`define Opcode_Opcode_Sb      `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b101000 )
`define Opcode_Opcode_Sh      `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b101001 )
`define Opcode_Opcode_Sw      `Opcode_Opcode_Init( `Opcode_Source_Op   , 6'b101011 )
`define Opcode_Opcode_Nop     `Opcode_Opcode_Init( `Opcode_Source_Func , 6'b000000 )

`endif
