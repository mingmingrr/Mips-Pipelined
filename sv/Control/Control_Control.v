`ifndef CONTROL_CONTROL_M
`define CONTROL_CONTROL_M

`include "../Pc/Pc_Action.v"
`include "../Opcode/Opcode_OpFunc.v"
`include "../Control/Control_AluData2Source.v"
`include "../Control/Control_Register1AddrSource.v"
`include "../Control/Control_Register2AddrSource.v"
`include "../Control/Control_RegisterWriteAddrSource.v"
`include "../Control/Control_RegisterWriteDataSource.v"
`include "../Control/Control_ShamtSource.v"

`define Control_Control_OpFunc_W `Opcode_OpFunc_W
`define Control_Control_OpFunc_I 0
`define Control_Control_OpFunc_T(T) \
	T [ `Control_Control_OpFunc_W - 1 : 0 ]
`define Control_Control_OpFunc(x) \
	x \
	[ `Control_Control_OpFunc_I \
	+ `Control_Control_OpFunc_W - 1 \
	:`Control_Control_OpFunc_I ]

`define Control_Control_RegisterWriteDataSource_W `Control_RegisterWriteDataSource_W
`define Control_Control_RegisterWriteDataSource_I \
	`Control_Control_OpFunc_W + \
	`Control_Control_OpFunc_I
`define Control_Control_RegisterWriteDataSource_T(T) \
	T [ `Control_Control_RegisterWriteDataSource_W - 1 : 0 ]
`define Control_Control_RegisterWriteDataSource(x) \
	x \
	[ `Control_Control_RegisterWriteDataSource_I \
	+ `Control_Control_RegisterWriteDataSource_W - 1 \
	:`Control_Control_RegisterWriteDataSource_I ]

`define Control_Control_RegisterWriteAddrSource_W `Control_RegisterWriteAddrSource_W
`define Control_Control_RegisterWriteAddrSource_I \
	`Control_Control_RegisterWriteDataSource_W + \
	`Control_Control_RegisterWriteDataSource_I
`define Control_Control_RegisterWriteAddrSource_T(T) \
	T [ `Control_Control_RegisterWriteAddrSource_W - 1 : 0 ]
`define Control_Control_RegisterWriteAddrSource(x) \
	x \
	[ `Control_Control_RegisterWriteAddrSource_I \
	+ `Control_Control_RegisterWriteAddrSource_W - 1 \
	:`Control_Control_RegisterWriteAddrSource_I ]

`define Control_Control_MemoryWriteEnable_W 1
`define Control_Control_MemoryWriteEnable_I \
	`Control_Control_RegisterWriteAddrSource_W + \
	`Control_Control_RegisterWriteAddrSource_I
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

`define Control_Control_AluData2Source_W `Control_AluData2Source_W
`define Control_Control_AluData2Source_I \
	`Control_Control_PcAction_W + \
	`Control_Control_PcAction_I
`define Control_Control_AluData2Source_T(T) \
	T [ `Control_Control_AluData2Source_W - 1 : 0 ]
`define Control_Control_AluData2Source(x) \
	x \
	[ `Control_Control_AluData2Source_I \
	+ `Control_Control_AluData2Source_W - 1 \
	:`Control_Control_AluData2Source_I ]

`define Control_Control_ShamtSource_W `Control_ShamtSource_W
`define Control_Control_ShamtSource_I \
	`Control_Control_AluData2Source_W + \
	`Control_Control_AluData2Source_I
`define Control_Control_ShamtSource_T(T) \
	T [ `Control_Control_ShamtSource_W - 1 : 0 ]
`define Control_Control_ShamtSource(x) \
	x \
	[ `Control_Control_ShamtSource_I \
	+ `Control_Control_ShamtSource_W - 1 \
	:`Control_Control_ShamtSource_I ]

`define Control_Control_Register1AddrSource_W `Control_Register1AddrSource_W
`define Control_Control_Register1AddrSource_I \
	`Control_Control_ShamtSource_W + \
	`Control_Control_ShamtSource_I
`define Control_Control_Register1AddrSource_T(T) \
	T [ `Control_Control_Register1AddrSource_W - 1 : 0 ]
`define Control_Control_Register1AddrSource(x) \
	x \
	[ `Control_Control_Register1AddrSource_I \
	+ `Control_Control_Register1AddrSource_W - 1 \
	:`Control_Control_Register1AddrSource_I ]

`define Control_Control_Register2AddrSource_W `Control_Register2AddrSource_W
`define Control_Control_Register2AddrSource_I \
	`Control_Control_Register1AddrSource_W + \
	`Control_Control_Register1AddrSource_I
`define Control_Control_Register2AddrSource_T(T) \
	T [ `Control_Control_Register2AddrSource_W - 1 : 0 ]
`define Control_Control_Register2AddrSource(x) \
	x \
	[ `Control_Control_Register2AddrSource_I \
	+ `Control_Control_Register2AddrSource_W - 1 \
	:`Control_Control_Register2AddrSource_I ]

`define Control_Control_W \
	`Opcode_OpFunc_W + \
	`Control_RegisterWriteDataSource_W + \
	`Control_RegisterWriteAddrSource_W + \
	1 + \
	`Pc_Action_W + \
	`Control_AluData2Source_W + \
	`Control_ShamtSource_W + \
	`Control_Register1AddrSource_W + \
	`Control_Register2AddrSource_W
`define Control_Control_T(T) T [`Control_Control_W-1:0]
`define Control_Control_Init(OpFunc, RegisterWriteDataSource, RegisterWriteAddrSource, MemoryWriteEnable, PcAction, AluData2Source, ShamtSource, Register1AddrSource, Register2AddrSource) { \
	`Control_Control_OpFunc_W'(OpFunc), \
	`Control_Control_RegisterWriteDataSource_W'(RegisterWriteDataSource), \
	`Control_Control_RegisterWriteAddrSource_W'(RegisterWriteAddrSource), \
	`Control_Control_MemoryWriteEnable_W'(MemoryWriteEnable), \
	`Control_Control_PcAction_W'(PcAction), \
	`Control_Control_AluData2Source_W'(AluData2Source), \
	`Control_Control_ShamtSource_W'(ShamtSource), \
	`Control_Control_Register1AddrSource_W'(Register1AddrSource), \
	`Control_Control_Register2AddrSource_W'(Register2AddrSource) \
	}
`define Control_Control_Init_Defaults \
	`Control_Control_Init(opFunc, registerWriteDataSource, registerWriteAddrSource, memoryWriteEnable, pcAction, aluData2Source, shamtSource, register1AddrSource, register2AddrSource)

`endif

