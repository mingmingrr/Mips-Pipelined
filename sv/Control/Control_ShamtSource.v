`ifndef CONTROL_SHAMTSOURCE_M
`define CONTROL_SHAMTSOURCE_M

`define Control_ShamtSource_None `Control_ShamtSource_W'(0)
`define Control_ShamtSource_Shamt `Control_ShamtSource_W'(1)
`define Control_ShamtSource_Const2 `Control_ShamtSource_W'(2)
`define Control_ShamtSource_Const16 `Control_ShamtSource_W'(3)

`define Control_ShamtSource_L 4
`define Control_ShamtSource_W 2
`define Control_ShamtSource_T(T) \
	T [`Control_ShamtSource_W-1:0]

`endif

