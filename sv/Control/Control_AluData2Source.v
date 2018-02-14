`ifndef CONTROL_ALUDATA2SOURCE_M
`define CONTROL_ALUDATA2SOURCE_M

`define Control_AluData2Source_Register `Control_AluData2Source_W'(0)
`define Control_AluData2Source_ImmediateSigned `Control_AluData2Source_W'(1)
`define Control_AluData2Source_ImmediateUnsigned `Control_AluData2Source_W'(2)

`define Control_AluData2Source_L 3
`define Control_AluData2Source_W 2
`define Control_AluData2Source_T(T) \
	T [`Control_AluData2Source_W-1:0]

`endif

