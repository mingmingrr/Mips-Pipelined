`include "Mips/Type/Word.v"
`include "Mips/Instruction/Format/IFormat.v"
`include "Mips/Control/IfId/Signal/Immediate/Control.v"
`include "Mips/Control/IfId/Signal/Immediate/Signal/Extend.v"
`include "Mips/Control/IfId/Signal/Immediate/Signal/Shift.v"

module Mips_Datapath_Immediate_extendShift
	( `Mips_Instruction_Format_IFormat_Imm_T   (input ) immIn
	, `Mips_Control_IfId_Signal_Immediate_Control_T (input ) control
	, `Mips_Type_Word_T                        (output) immOut
	);

`Mips_Type_Word_T (reg) extended;
always @(*)
	case(`Mips_Control_IfId_Signal_Immediate_Control_Extend(control))
		`Mips_Control_IfId_Signal_Immediate_Signal_Extend_Unsigned : extended = {16'h0, immIn};
		`Mips_Control_IfId_Signal_Immediate_Signal_Extend_Signed   : extended = {{16{immIn[15]}}, immIn};
		default                                               : extended = {{16{immIn[15]}}, immIn};
	endcase

`Mips_Type_Word_T (reg) extendShifted;
always @(*)
	case(`Mips_Control_IfId_Signal_Immediate_Control_Shift(control))
		`Mips_Control_IfId_Signal_Immediate_Signal_Shift_None   : extendShifted = extended;
		`Mips_Control_IfId_Signal_Immediate_Signal_Shift_Left2  : extendShifted = extended << 2;
		`Mips_Control_IfId_Signal_Immediate_Signal_Shift_Left16 : extendShifted = extended << 16;
		default                                            : extendShifted = extended;
	endcase

assign immOut = extendShifted;

endmodule
