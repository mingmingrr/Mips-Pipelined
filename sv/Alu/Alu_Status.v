`ifndef ALU_STATUS_M
`define ALU_STATUS_M

`define Alu_Status_Zero_I 0
`define Alu_Status_Zero_W 1
`define Alu_Status_Zero_T(T) T
`define Alu_Status_Zero(x) x

`define Alu_Status_T(T) T
`define Alu_Status_W `Alu_Status_Zero_W
`define Alu_Status_Init(Zero) `Alu_Status_Zero_W'(Zero)

`endif
