`ifndef CONTROL_REGISTERWRITEADDRSOURCE_M
`define CONTROL_REGISTERWRITEADDRSOURCE_M

`define Control_RegisterWriteAddrSource_None `Control_RegisterWriteAddrSource_W'(0)
`define Control_RegisterWriteAddrSource_Rt `Control_RegisterWriteAddrSource_W'(1)
`define Control_RegisterWriteAddrSource_Rd `Control_RegisterWriteAddrSource_W'(2)

`define Control_RegisterWriteAddrSource_L 3
`define Control_RegisterWriteAddrSource_W 2
`define Control_RegisterWriteAddrSource_T(T) \
	T [`Control_RegisterWriteAddrSource_W-1:0]

`endif
