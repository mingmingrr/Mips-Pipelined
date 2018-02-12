`ifndef CONTROL_CONTROL_M
`define CONTROL_CONTROL_M

`include "../Opcode/Opcode_OpFunc.v"

`define Control_Control_OpFunc_I 6
`define Control_Control_OpFunc_W `Opcode_OpFunc_W
`define Control_Control_OpFunc_T(T) T
`define Control_Control_OpFunc(x) \
	x \
		[ `Control_Control_OpFunc_I \
		+ `Control_Control_OpFunc_W - 1 \
		: `Control_Control_OpFunc_I ]

`define Control_Control_RegisterWriteDataSource_I 5
`define Control_Control_RegisterWriteDataSource_W 1
`define Control_Control_RegisterWriteDataSource_T(T) T
`define Control_Control_RegisterWriteDataSource(x) \
	x [ `Control_Control_RegisterWriteDataSource_I ]

`define Control_Control_RegisterWriteAddrSource_I 4
`define Control_Control_RegisterWriteAddrSource_W 1
`define Control_Control_RegisterWriteAddrSource_T(T) T
`define Control_Control_RegisterWriteAddrSource(x) \
	x [ `Control_Control_RegisterWriteAddrSource_I ]

`define Control_Control_MemoryReadEnable_I 3
`define Control_Control_MemoryReadEnable_W 1
`define Control_Control_MemoryReadEnable_T(T) T
`define Control_Control_MemoryReadEnable(x) \
	x [ `Control_Control_MemoryReadEnable_I ]

`define Control_Control_MemoryWriteEnable_I 2
`define Control_Control_MemoryWriteEnable_W 1
`define Control_Control_MemoryWriteEnable_T(T) T
`define Control_Control_MemoryWriteEnable(x) \
	x [ `Control_Control_MemoryWriteEnable_I ]

`define Control_Control_BranchEnable_I 1
`define Control_Control_BranchEnable_W 1
`define Control_Control_BranchEnable_T(T) T
`define Control_Control_BranchEnable(x) \
	x [ `Control_Control_BranchEnable_I ]

`define Control_Control_AluData2Source_I 0
`define Control_Control_AluData2Source_W 1
`define Control_Control_AluData2Source_T(T) T
`define Control_Control_AluData2Source(x) \
	x [ `Control_Control_AluData2Source_I ]


`define Control_Control_W \
	`Control_Control_OpFunc_W + \
	`Control_Control_RegisterWriteDataSource_W + \
	`Control_Control_RegisterWriteAddrSource_W + \
	`Control_Control_MemoryReadEnable_W + \
	`Control_Control_MemoryWriteEnable_W + \
	`Control_Control_BranchEnable_W + \
	`Control_Control_AluData2Source_W
`define Control_Control_T(T) T [`Control_Control_W-1:0]
`define Control_Control_Init(OpFunc, RegisterWriteDataSource , RegisterWriteAddrSource , MemoryReadEnable , MemoryWriteEnable , BranchEnable , AluData2Source) \
	{ `Control_Control_OpFunc_W'(OpFunc) \
	, `Control_Control_RegisterWriteDataSource_W'(RegisterWriteDataSource) \
	, `Control_Control_RegisterWriteAddrSource_W'(RegisterWriteAddrSource) \
	, `Control_Control_MemoryReadEnable_W'(MemoryReadEnable) \
	, `Control_Control_MemoryWriteEnable_W'(MemoryWriteEnable) \
	, `Control_Control_BranchEnable_W'(BranchEnable) \
	, `Control_Control_AluData2Source_W'(AluData2Source) \
	}

`endif

