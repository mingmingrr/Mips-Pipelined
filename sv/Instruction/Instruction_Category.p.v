`ifndef INSTRUCTION_CATEGORY_M
`define INSTRUCTION_CATEGORY_M

$(makeBitset("Instruction_Category",
	"RShift RShiftV RJump RHilo RLong RComp RLogic RArith Comp Logic Arith Shift Jump Branch Load Store Other".split(' ')))

`endif
