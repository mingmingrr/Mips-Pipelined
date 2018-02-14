`ifndef CONTROL_REGISTER2ADDRSOURCE_M
`define CONTROL_REGISTER2ADDRSOURCE_M

`define Control_Register2AddrSource_None `Control_Register2AddrSource_W'(0)
`define Control_Register2AddrSource_Rt `Control_Register2AddrSource_W'(1)

`define Control_Register2AddrSource_L 2
`define Control_Register2AddrSource_W 1
`define Control_Register2AddrSource_T(T) \
	T [`Control_Register2AddrSource_W-1:0]

`endif
