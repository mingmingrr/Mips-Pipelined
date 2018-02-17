`ifndef INSTRUCTION_PARTS_M
`define INSTRUCTION_PARTS_M

`define Instruction_Parts_Op_I 26
`define Instruction_Parts_Op_W 6
`define Instruction_Parts_Op_T(T) \
	T [`Instruction_Parts_Op_W-1:0]
`define Instruction_Parts_Op(x) \
	x \
		[`Instruction_Parts_Op_W \
		+ `Instruction_Parts_Op_I - 1 \
		: `Instruction_Parts_Op_I ]

`define Instruction_Parts_Rs_I 21
`define Instruction_Parts_Rs_W 5
`define Instruction_Parts_Rs_T(T) \
	T [`Instruction_Parts_Rs_W-1:0]
`define Instruction_Parts_Rs(x) \
	x \
		[`Instruction_Parts_Rs_W \
		+ `Instruction_Parts_Rs_I - 1 \
		: `Instruction_Parts_Rs_I ]

`define Instruction_Parts_Rt_I 16
`define Instruction_Parts_Rt_W 5
`define Instruction_Parts_Rt_T(T) \
	T [`Instruction_Parts_Rt_W-1:0]
`define Instruction_Parts_Rt(x) \
	x \
		[`Instruction_Parts_Rt_W \
		+ `Instruction_Parts_Rt_I - 1 \
		: `Instruction_Parts_Rt_I ]

`define Instruction_Parts_Rd_I 11
`define Instruction_Parts_Rd_W 5
`define Instruction_Parts_Rd_T(T) \
	T [`Instruction_Parts_Rd_W-1:0]
`define Instruction_Parts_Rd(x) \
	x \
		[`Instruction_Parts_Rd_W \
		+ `Instruction_Parts_Rd_I - 1 \
		: `Instruction_Parts_Rd_I ]

`define Instruction_Parts_Shamt_I 6
`define Instruction_Parts_Shamt_W 5
`define Instruction_Parts_Shamt_T(T) \
	T [`Instruction_Parts_Shamt_W-1:0]
`define Instruction_Parts_Shamt(x) \
	x \
		[`Instruction_Parts_Shamt_W \
		+ `Instruction_Parts_Shamt_I - 1 \
		: `Instruction_Parts_Shamt_I ]

`define Instruction_Parts_Func_I 0
`define Instruction_Parts_Func_W 6
`define Instruction_Parts_Func_T(T) \
	T [`Instruction_Parts_Func_W-1:0]
`define Instruction_Parts_Func(x) \
	x \
		[`Instruction_Parts_Func_W \
		+ `Instruction_Parts_Func_I - 1 \
		: `Instruction_Parts_Func_I ]

`define Instruction_Parts_Imm_I 0
`define Instruction_Parts_Imm_W 16
`define Instruction_Parts_Imm_T(T) \
	T [`Instruction_Parts_Imm_W-1:0]
`define Instruction_Parts_Imm(x) \
	x \
		[`Instruction_Parts_Imm_W \
		+ `Instruction_Parts_Imm_I - 1 \
		: `Instruction_Parts_Imm_I ]

`define Instruction_Parts_Target_I 0
`define Instruction_Parts_Target_W 26
`define Instruction_Parts_Target_T(T) \
	T [`Instruction_Parts_Target_W-1:0]
`define Instruction_Parts_Target(x) \
	x \
		[`Instruction_Parts_Target_W \
		+ `Instruction_Parts_Target_I - 1 \
		: `Instruction_Parts_Target_I]

`endif

