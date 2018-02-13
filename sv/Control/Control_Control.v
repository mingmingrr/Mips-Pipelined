`ifndef CONTROL_CONTROL_M
`define CONTROL_CONTROL_M

`include "../Pc/Pc_Action.v"
`include "../Opcode/Opcode_OpFunc.v"

`define Control_Control_OpFunc_W `Opcode_OpFunc_W
`define Control_Control_OpFunc_I 0
`define Control_Control_OpFunc_T(T) \
	T [ `Control_Control_OpFunc_W - 1 : 0 ]
`define Control_Control_OpFunc(x) \
	x \
	[ `Control_Control_OpFunc_I \
	+ `Control_Control_OpFunc_W - 1 \
	:`Control_Control_OpFunc_I ]

`define Control_Control_RegisterWriteDataSource_W 1
`define Control_Control_RegisterWriteDataSource_I \
	`Control_Control_OpFunc_W + \
	`Control_Control_OpFunc_I
`define Control_Control_RegisterWriteDataSource_T(T) T
`define Control_Control_RegisterWriteDataSource(x) \
	x [ `Control_Control_RegisterWriteDataSource_I ]

`define Control_Control_RegisterWriteAddrSource_W 1
`define Control_Control_RegisterWriteAddrSource_I \
	`Control_Control_RegisterWriteDataSource_W + \
	`Control_Control_RegisterWriteDataSource_I
`define Control_Control_RegisterWriteAddrSource_T(T) T
`define Control_Control_RegisterWriteAddrSource(x) \
	x [ `Control_Control_RegisterWriteAddrSource_I ]

`define Control_Control_MemoryReadEnable_W 1
`define Control_Control_MemoryReadEnable_I \
	`Control_Control_RegisterWriteAddrSource_W + \
	`Control_Control_RegisterWriteAddrSource_I
`define Control_Control_MemoryReadEnable_T(T) T
`define Control_Control_MemoryReadEnable(x) \
	x [ `Control_Control_MemoryReadEnable_I ]

`define Control_Control_MemoryWriteEnable_W 1
`define Control_Control_MemoryWriteEnable_I \
	`Control_Control_MemoryReadEnable_W + \
	`Control_Control_MemoryReadEnable_I
`define Control_Control_MemoryWriteEnable_T(T) T
`define Control_Control_MemoryWriteEnable(x) \
	x [ `Control_Control_MemoryWriteEnable_I ]

`define Control_Control_PcAction_W `Pc_Action_W
`define Control_Control_PcAction_I \
	`Control_Control_MemoryWriteEnable_W + \
	`Control_Control_MemoryWriteEnable_I
`define Control_Control_PcAction_T(T) \
	T [ `Control_Control_PcAction_W - 1 : 0 ]
`define Control_Control_PcAction(x) \
	x \
	[ `Control_Control_PcAction_I \
	+ `Control_Control_PcAction_W - 1 \
	:`Control_Control_PcAction_I ]

`define Control_Control_AluData2Source_W 1
`define Control_Control_AluData2Source_I \
	`Control_Control_PcAction_W + \
	`Control_Control_PcAction_I
`define Control_Control_AluData2Source_T(T) T
`define Control_Control_AluData2Source(x) \
	x [ `Control_Control_AluData2Source_I ]

`define Control_Control_W \
	`Opcode_OpFunc_W + \
	1 + \
	1 + \
	1 + \
	1 + \
	`Pc_Action_W + \
	1
`define Control_Control_T(T) T [`Control_Control_W-1:0]
`define Control_Control_Init(OpFunc, RegisterWriteDataSource, RegisterWriteAddrSource, MemoryReadEnable, MemoryWriteEnable, PcAction, AluData2Source) { \
	`Control_Control_OpFunc_W'(OpFunc), \
	`Control_Control_RegisterWriteDataSource_W'(RegisterWriteDataSource), \
	`Control_Control_RegisterWriteAddrSource_W'(RegisterWriteAddrSource), \
	`Control_Control_MemoryReadEnable_W'(MemoryReadEnable), \
	`Control_Control_MemoryWriteEnable_W'(MemoryWriteEnable), \
	`Control_Control_PcAction_W'(PcAction), \
	`Control_Control_AluData2Source_W'(AluData2Source) \
	}

`endif

