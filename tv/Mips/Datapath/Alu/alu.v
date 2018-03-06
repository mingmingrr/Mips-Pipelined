`include "Util/Math.v"
`include "Mips/Control/Signal/Alu/Signal/Func.v"
`include "Mips/Datapath/Alu/Status.v"

`define Mips_Datapath_Alu_alu_Data_T(T) T [DATA_W-1:0]

module Mips_Datapath_Alu_alu #
	( parameter DATA_W  = 32
	)
	( `Mips_Control_Signal_Alu_Signal_Func_T (input) func
	, `Mips_Datapath_Alu_alu_Data_T (input)  data1
	, `Mips_Datapath_Alu_alu_Data_T (input)  data2
	, `Mips_Datapath_Alu_alu_Data_T (input)  reg_lo
	, `Mips_Datapath_Alu_alu_Data_T (input)  reg_hi
	, `Mips_Datapath_Alu_alu_Data_T (output) res_lo
	, `Mips_Datapath_Alu_alu_Data_T (output) res_hi
	, `Mips_Datapath_Alu_Status_T   (output) status
	);

`Util_Math_log2_expr

`Mips_Datapath_Alu_alu_Data_T (wire signed) data1$  , data2$  ;
`Mips_Datapath_Alu_alu_Data_T (wire signed) mul_lo$ , mul_hi$ ;
`Mips_Datapath_Alu_alu_Data_T (wire)        mul_lo  , mul_hi  ;
wire [Util_Math_log2(DATA_W)-1:0] shamt;

assign data1$ = data1;
assign data2$ = data2;
assign {mul_hi, mul_lo} = data1 * data2;
assign {mul_hi$, mul_lo$} = data1$ * data2$;
assign shamt = data2[Util_Math_log2(DATA_W)-1:0];

`Mips_Datapath_Alu_alu_Data_T(reg) res_lo$;
always @(*)
	case(func)
		`Mips_Control_Signal_Alu_Signal_Func_Add  : res_lo$ =          data1   +   data2  ;
		`Mips_Control_Signal_Alu_Signal_Func_Sub  : res_lo$ =          data1   -   data2  ;
		`Mips_Control_Signal_Alu_Signal_Func_Sll  : res_lo$ =          data1   <<  shamt  ;
		`Mips_Control_Signal_Alu_Signal_Func_Sra  : res_lo$ =          data1$  >>> shamt  ;
		`Mips_Control_Signal_Alu_Signal_Func_Srl  : res_lo$ =          data1   >>  shamt  ;
		`Mips_Control_Signal_Alu_Signal_Func_And  : res_lo$ =          data1   &   data2  ;
		`Mips_Control_Signal_Alu_Signal_Func_Or   : res_lo$ =          data1   |   data2  ;
		`Mips_Control_Signal_Alu_Signal_Func_Nor  : res_lo$ = ~(       data1   |   data2  );
		`Mips_Control_Signal_Alu_Signal_Func_Xor  : res_lo$ =          data1   ^   data2  ;
		`Mips_Control_Signal_Alu_Signal_Func_Slts : res_lo$ = DATA_W'( data1$  <   data2$ );
		`Mips_Control_Signal_Alu_Signal_Func_Sltu : res_lo$ = DATA_W'( data1   <   data2  );
		`Mips_Control_Signal_Alu_Signal_Func_Muls : res_lo$ =          mul_lo$ ;
		`Mips_Control_Signal_Alu_Signal_Func_Mulu : res_lo$ =          mul_lo  ;
		// `Mips_Control_Signal_Alu_Signal_Func_Divs : res_lo$ =          data1$  /  data2$  ;
		// `Mips_Control_Signal_Alu_Signal_Func_Divu : res_lo$ =          data1   /  data2   ;
		`Mips_Control_Signal_Alu_Signal_Func_Mtlo : res_lo$ =          data1   ;
		`Mips_Control_Signal_Alu_Signal_Func_Mthi : res_lo$ =          data1   ;
		`Mips_Control_Signal_Alu_Signal_Func_Mflo : res_lo$ =          reg_lo  ;
		`Mips_Control_Signal_Alu_Signal_Func_Mfhi : res_lo$ =          reg_hi  ;
		default                      : res_lo$ =          data1   ;
	endcase
assign res_lo = res_lo$;

`Mips_Datapath_Alu_alu_Data_T(reg) res_hi$;
always @(*)
	case(func)
		`Mips_Control_Signal_Alu_Signal_Func_Muls : res_hi$ = mul_hi$;
		`Mips_Control_Signal_Alu_Signal_Func_Mulu : res_hi$ = mul_hi;
		// `Mips_Control_Signal_Alu_Signal_Func_Divs : res_hi$ = data1$ % data2$;
		// `Mips_Control_Signal_Alu_Signal_Func_Divu : res_hi$ = data1 % data2;
		`Mips_Control_Signal_Alu_Signal_Func_Mthi : res_hi$ = data1;
		default                      : res_hi$ = DATA_W'(0);
	endcase
assign res_hi = res_hi$;

wire zero;
assign zero = ~(|res_lo$);
wire less;
assign less = data1 < data2;
wire equal;
assign equal = data1 == data2;

assign status = `Mips_Datapath_Alu_Status_Pack_Defaults;

endmodule

`undef Mips_Datapath_Alu_alu_Data_T
