`include "Mips/Type/Word.v"
`include "Mips/Instruction/Format/IFormat.v"

`include "Mips/Control/Signal/Alu/Control.v"
`include "Mips/Control/Signal/Alu/Signal/ImmExtend.v"
`include "Mips/Control/Signal/Alu/Signal/ImmShift.v"

module Mips_Datapath_Alu_immediate
	( `Mips_Instruction_Format_IFormat_Imm_T  (input) immIn
	, `Mips_Control_Signal_Alu_Control_T (input) control
	, `Mips_Type_Word_T                       (output) immOut
	);

`Mips_Type_Word_T (reg) extended;
always @(*)
	case(`Mips_Control_Signal_Alu_Control_ImmExtend(control))
		`Mips_Control_Signal_Alu_Signal_ImmExtend_Unsigned : extended = {16'h0, immIn};
		`Mips_Control_Signal_Alu_Signal_ImmExtend_Signed   : extended = {{16{immIn[15]}}, immIn};
		default                                                 : extended = {{16{immIn[15]}}, immIn};
	endcase

`Mips_Type_Word_T (reg) extendShifted;
always @(*)
	case(`Mips_Control_Signal_Alu_Control_ImmShift(control))
		`Mips_Control_Signal_Alu_Signal_ImmShift_None   : extendShifted = extended;
		`Mips_Control_Signal_Alu_Signal_ImmShift_Left2  : extendShifted = extended << 2;
		`Mips_Control_Signal_Alu_Signal_ImmShift_Left16 : extendShifted = extended << 16;
		default                                              : extendShifted = extended;
	endcase

assign immOut = extendShifted;

endmodule
