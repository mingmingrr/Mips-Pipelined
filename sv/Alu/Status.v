// vim: set ft=verilog:

`ifndef ALU_STATUS_M
`define ALU_STATUS_M

`define Alu_Status_L 4
`define Alu_Status_T(T) T [`Alu_Status_L-1:0]

`define Alu_Status_carry(x) x[0]
`define Alu_Status_over(x) x[1]
`define Alu_Status_sign(x) x[2]
`define Alu_Status_zero(x) x[3]

`endif
