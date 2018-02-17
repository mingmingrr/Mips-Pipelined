// vim: set ft=verilog:

`ifndef ALU_FUNC_M
`define ALU_FUNC_M

`define Alu_Func_T(T) T [`Alu_Func_W-1:0]
`define Alu_Func_W 5
`define Alu_Func_L 20

`define Alu_Func_Add  `Alu_Func_W'(0)
`define Alu_Func_Sub  `Alu_Func_W'(1)
`define Alu_Func_Sll  `Alu_Func_W'(2)
`define Alu_Func_Srl  `Alu_Func_W'(3)
`define Alu_Func_Sra  `Alu_Func_W'(4)
`define Alu_Func_And  `Alu_Func_W'(5)
`define Alu_Func_Or   `Alu_Func_W'(6)
`define Alu_Func_Nor  `Alu_Func_W'(7)
`define Alu_Func_Xor  `Alu_Func_W'(8)
`define Alu_Func_Slts `Alu_Func_W'(9)
`define Alu_Func_Sltu `Alu_Func_W'(10)
`define Alu_Func_Muls `Alu_Func_W'(11)
`define Alu_Func_Mulu `Alu_Func_W'(12)
`define Alu_Func_Divs `Alu_Func_W'(13)
`define Alu_Func_Divu `Alu_Func_W'(14)
`define Alu_Func_Mfhi `Alu_Func_W'(15)
`define Alu_Func_Mthi `Alu_Func_W'(16)
`define Alu_Func_Mflo `Alu_Func_W'(17)
`define Alu_Func_Mtlo `Alu_Func_W'(18)
`define Alu_Func_None `Alu_Func_W'(19)

`endif
