`ifndef CONTROL_REGISTER1ADDRSOURCE_M
`define CONTROL_REGISTER1ADDRSOURCE_M

`define Control_Register1AddrSource_None `Control_Register1AddrSource_W'(0)
`define Control_Register1AddrSource_Rs `Control_Register1AddrSource_W'(1)
`define Control_Register1AddrSource_Rt `Control_Register1AddrSource_W'(2)

`define Control_Register1AddrSource_L 3
`define Control_Register1AddrSource_W 2
`define Control_Register1AddrSource_T(T) \
	T [`Control_Register1AddrSource_W-1:0]

`endif
