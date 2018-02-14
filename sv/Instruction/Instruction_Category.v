`ifndef INSTRUCTION_CATEGORY_M
`define INSTRUCTION_CATEGORY_M

`define Instruction_Category_RShift_W 1
`define Instruction_Category_RShift_I 0
`define Instruction_Category_RShift_T(T) T
`define Instruction_Category_RShift(x) \
	x [ `Instruction_Category_RShift_I ]
`define Instruction_Category_RShift_V \
	`Instruction_Category_W'(1)

`define Instruction_Category_RShiftV_W 1
`define Instruction_Category_RShiftV_I 1
`define Instruction_Category_RShiftV_T(T) T
`define Instruction_Category_RShiftV(x) \
	x [ `Instruction_Category_RShiftV_I ]
`define Instruction_Category_RShiftV_V \
	`Instruction_Category_W'(2)

`define Instruction_Category_RJump_W 1
`define Instruction_Category_RJump_I 2
`define Instruction_Category_RJump_T(T) T
`define Instruction_Category_RJump(x) \
	x [ `Instruction_Category_RJump_I ]
`define Instruction_Category_RJump_V \
	`Instruction_Category_W'(4)

`define Instruction_Category_RHilo_W 1
`define Instruction_Category_RHilo_I 3
`define Instruction_Category_RHilo_T(T) T
`define Instruction_Category_RHilo(x) \
	x [ `Instruction_Category_RHilo_I ]
`define Instruction_Category_RHilo_V \
	`Instruction_Category_W'(8)

`define Instruction_Category_RLong_W 1
`define Instruction_Category_RLong_I 4
`define Instruction_Category_RLong_T(T) T
`define Instruction_Category_RLong(x) \
	x [ `Instruction_Category_RLong_I ]
`define Instruction_Category_RLong_V \
	`Instruction_Category_W'(16)

`define Instruction_Category_RComp_W 1
`define Instruction_Category_RComp_I 5
`define Instruction_Category_RComp_T(T) T
`define Instruction_Category_RComp(x) \
	x [ `Instruction_Category_RComp_I ]
`define Instruction_Category_RComp_V \
	`Instruction_Category_W'(32)

`define Instruction_Category_RLogic_W 1
`define Instruction_Category_RLogic_I 6
`define Instruction_Category_RLogic_T(T) T
`define Instruction_Category_RLogic(x) \
	x [ `Instruction_Category_RLogic_I ]
`define Instruction_Category_RLogic_V \
	`Instruction_Category_W'(64)

`define Instruction_Category_RArith_W 1
`define Instruction_Category_RArith_I 7
`define Instruction_Category_RArith_T(T) T
`define Instruction_Category_RArith(x) \
	x [ `Instruction_Category_RArith_I ]
`define Instruction_Category_RArith_V \
	`Instruction_Category_W'(128)

`define Instruction_Category_Comp_W 1
`define Instruction_Category_Comp_I 8
`define Instruction_Category_Comp_T(T) T
`define Instruction_Category_Comp(x) \
	x [ `Instruction_Category_Comp_I ]
`define Instruction_Category_Comp_V \
	`Instruction_Category_W'(256)

`define Instruction_Category_Logic_W 1
`define Instruction_Category_Logic_I 9
`define Instruction_Category_Logic_T(T) T
`define Instruction_Category_Logic(x) \
	x [ `Instruction_Category_Logic_I ]
`define Instruction_Category_Logic_V \
	`Instruction_Category_W'(512)

`define Instruction_Category_Arith_W 1
`define Instruction_Category_Arith_I 10
`define Instruction_Category_Arith_T(T) T
`define Instruction_Category_Arith(x) \
	x [ `Instruction_Category_Arith_I ]
`define Instruction_Category_Arith_V \
	`Instruction_Category_W'(1024)

`define Instruction_Category_Shift_W 1
`define Instruction_Category_Shift_I 11
`define Instruction_Category_Shift_T(T) T
`define Instruction_Category_Shift(x) \
	x [ `Instruction_Category_Shift_I ]
`define Instruction_Category_Shift_V \
	`Instruction_Category_W'(2048)

`define Instruction_Category_Jump_W 1
`define Instruction_Category_Jump_I 12
`define Instruction_Category_Jump_T(T) T
`define Instruction_Category_Jump(x) \
	x [ `Instruction_Category_Jump_I ]
`define Instruction_Category_Jump_V \
	`Instruction_Category_W'(4096)

`define Instruction_Category_Branch_W 1
`define Instruction_Category_Branch_I 13
`define Instruction_Category_Branch_T(T) T
`define Instruction_Category_Branch(x) \
	x [ `Instruction_Category_Branch_I ]
`define Instruction_Category_Branch_V \
	`Instruction_Category_W'(8192)

`define Instruction_Category_Load_W 1
`define Instruction_Category_Load_I 14
`define Instruction_Category_Load_T(T) T
`define Instruction_Category_Load(x) \
	x [ `Instruction_Category_Load_I ]
`define Instruction_Category_Load_V \
	`Instruction_Category_W'(16384)

`define Instruction_Category_Store_W 1
`define Instruction_Category_Store_I 15
`define Instruction_Category_Store_T(T) T
`define Instruction_Category_Store(x) \
	x [ `Instruction_Category_Store_I ]
`define Instruction_Category_Store_V \
	`Instruction_Category_W'(32768)

`define Instruction_Category_Other_W 1
`define Instruction_Category_Other_I 16
`define Instruction_Category_Other_T(T) T
`define Instruction_Category_Other(x) \
	x [ `Instruction_Category_Other_I ]
`define Instruction_Category_Other_V \
	`Instruction_Category_W'(65536)

`define Instruction_Category_L 17
`define Instruction_Category_W 16
`define Instruction_Category_T(T) T [`Instruction_Category_W-1:0]

`endif
