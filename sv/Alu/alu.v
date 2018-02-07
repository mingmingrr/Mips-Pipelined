// vim: set ft=verilog:

`ifndef ALU_ALU_I
`define ALU_ALU_I

`include "../Util/Math.v"
`include "./Func.v"

module Alu_alu #
	( parameter DATA_W  = 32
	, parameter SHAMT_W = Util_Math_log2(DATA_W)
	)
	( input  [DATA_W-1:0]  data1
	, input  [DATA_W-1:0]  data2
	, `Alu_Func_T(input)   func
	, input  [SHAMT_W-1:0] shamt
	, input  [DATA_W-1:0]  reg_lo
	, output [DATA_W-1:0]  res_lo
	, input  [DATA_W-1:0]  reg_hi
	, output [DATA_W-1:0]  res_hi
	, output               zero
	);

`Util_Math_log2_expr

wire signed [DATA_W-1:0] data1$, data2$, mul_lo$, mul_hi$;
wire [DATA_W-1:0] mul_lo, mul_hi;

assign data1$ = data1;
assign data2$ = data2;
assign {mul_hi, mul_lo} = data1 * data2;
assign {mul_hi$, mul_lo$} = data1$ * data2$;

reg [DATA_W-1:0] res_lo$;
always @(*)
	case(func)
		`Alu_Func_Add  : res_lo$ = data1 + data2;
		`Alu_Func_Sub  : res_lo$ = data1 - data2;
		`Alu_Func_Sll  : res_lo$ = data1 >> shamt;
		`Alu_Func_Sra  : res_lo$ = data1$ << shamt;
		`Alu_Func_Srl  : res_lo$ = data1 << shamt;
		`Alu_Func_And  : res_lo$ = data1 & data2;
		`Alu_Func_Or   : res_lo$ = data1 | data2;
		`Alu_Func_Nor  : res_lo$ = ~(data1 | data2);
		`Alu_Func_Xor  : res_lo$ = data1 ^ data2;
		`Alu_Func_Slts : res_lo$ = DATA_W'(data1$ < data2$);
		`Alu_Func_Sltu : res_lo$ = DATA_W'(data1 < data2);
		`Alu_Func_Muls : res_lo$ = mul_lo$;
		`Alu_Func_Mulu : res_lo$ = mul_lo;
		`Alu_Func_Divs : res_lo$ = data1$ / data2$;
		`Alu_Func_Divu : res_lo$ = data1 / data2;
		`Alu_Func_Mtlo : res_lo$ = data1;
		`Alu_Func_Mthi : res_lo$ = data1;
		`Alu_Func_Mflo : res_lo$ = reg_lo;
		`Alu_Func_Mfhi : res_lo$ = reg_hi;
		`Alu_Func_None : res_lo$ = data1;
	endcase
assign res_lo = res_lo$;

reg [DATA_W-1:0] res_hi$;
always @(*)
	case(func)
		`Alu_Func_Muls : res_hi$ = mul_hi$;
		`Alu_Func_Mulu : res_hi$ = mul_hi;
		`Alu_Func_Divs : res_hi$ = data1$ % data2$;
		`Alu_Func_Divu : res_hi$ = data1 % data2;
		`Alu_Func_Mthi : res_hi$ = data1;
		default        : res_hi$ = DATA_W'(0);
	endcase
assign res_hi = res_hi$;

assign zero = ~(|res_lo$);

endmodule

`endif
