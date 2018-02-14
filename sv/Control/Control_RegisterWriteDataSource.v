`ifndef CONTROL_REGISTERWRITEDATSOURCE_M
`define CONTROL_REGISTERWRITEDATSOURCE_M

`define Control_RegisterWriteDataSource_Alu `Control_RegisterWriteDataSource_W'(0)
`define Control_RegisterWriteDataSource_Memory `Control_RegisterWriteDataSource_W'(1)

`define Control_RegisterWriteDataSource_L 2
`define Control_RegisterWriteDataSource_W 1
`define Control_RegisterWriteDataSource_T(T) \
	T [`Control_RegisterWriteDataSource_W-1:0]

`endif

