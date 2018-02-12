module Instruction_parts #
	( INST_W   = 32
	, OP_W     = 6
	, OP_I     = 26
	, RS_W     = 5
	, RS_I     = 21
	, RT_W     = 5
	, RT_I     = 16
	, RD_W     = 5
	, RD_I     = 11
	, SHAMT_W  = 5
	, SHAMT_I  = 6
	, FUNC_W   = 6
	, FUNC_I   = 0
	, IMM_W    = 16
	, IMM_I    = 0
	, TARGET_W = 26
	, TARGET_I = 0
	)
	( input  [INST_W-1:0]   inst
	, output [OP_W-1:0]     op
	, output [RS_W-1:0]     rs
	, output [RT_W-1:0]     rt
	, output [RD_W-1:0]     rd
	, output [SHAMT_W-1:0]  shamt
	, output [FUNC_W-1:0]   func
	, output [IMM_W-1:0]    imm
	, output [TARGET_W-1:0] target
	);








