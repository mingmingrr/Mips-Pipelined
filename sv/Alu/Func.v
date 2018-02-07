// vim: set ft=verilog:

`ifndef ALU_FUNC
`define ALU_FUNC

`define Alu_Func_T(T) T [4:0]
`define Alu_Func_L 20

`define Alu_Func_Add  5'd0
`define Alu_Func_Sub  5'd1
`define Alu_Func_Sll  5'd2
`define Alu_Func_Srl  5'd3
`define Alu_Func_Sra  5'd4
`define Alu_Func_And  5'd5
`define Alu_Func_Or   5'd6
`define Alu_Func_Nor  5'd7
`define Alu_Func_Xor  5'd8
`define Alu_Func_Slts 5'd9
`define Alu_Func_Sltu 5'd10
`define Alu_Func_Muls 5'd11
`define Alu_Func_Mulu 5'd12
`define Alu_Func_Divs 5'd13
`define Alu_Func_Divu 5'd14
`define Alu_Func_Mfhi 5'd15
`define Alu_Func_Mthi 5'd16
`define Alu_Func_Mflo 5'd17
`define Alu_Func_Mtlo 5'd18
`define Alu_Func_None 5'd19

`endif
