`ifndef MIPS_MIPS_I
`define MIPS_MIPS_I

`include "../Memory/Memory_ram.v"
`include "../Memory/Memory_rom.v"
`include "../Util/Util_Control.v"
`include "../Alu/Alu_hilo.v"
`include "../Opcode/Opcode_OpFunc.v"
`include "../Instruction/Instruction_Parts.v"
`include "../Control/Control_Control.v"

module Mips_mips #
	( parameter FILE = "../../asm/test0.mif"
	, parameter ADDR_L = 64
	)
	( `Util_Control_T(input) ctrl
	);

`Opcode_OpFunc_T(wire) opFunc;
`Alu_Func_T(wire) alu_func;
`Control_Control_T(wire) control;
wire [31:0] instruction;

wire [5:0] ram_addr;
wire [31:0] ram_data;
wire ram_wren;
wire [31:0] ram_out;
Memory_ram #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .DATA_W  (32)
	) GRAM
	( .addr  (ram_addr)
	, .bytes (4'b1100)
	, .data  (ram_data)
	, .wren  (ram_wren)
	, .ctrl  (ctrl)
	, .out   (ram_out)
	);

wire [5:0] rom_addr;
wire [31:0] rom_out;
Memory_rom #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .DATA_W  (32)
	) GROM
	( .addr  (rom_addr)
	, .ctrl  (ctrl)
	, .out   (rom_out)
	);

wire [4:0] reg_rd1_addr ;
reg [4:0] reg_rd1_addr$;
assign reg_rd1_addr = reg_rd1_addr$;
wire [31:0] reg_rd1_data ;
wire [4:0] reg_rd2_addr ;
reg [4:0] reg_rd2_addr$;
assign reg_rd2_addr = reg_rd2_addr$;
wire [31:0] reg_rd2_data ;
wire [4:0] reg_wr_addr  ;
reg [4:0] reg_wr_addr$ ;
assign reg_wr_addr = reg_wr_addr$;
wire [31:0] reg_wr_data  ;
reg [31:0] reg_wr_data$ ;
assign reg_wr_data = reg_wr_data$;
Register_registers #
	( .DATA_W (32)
	, .ADDR_L (32)
	) GREG
	( .ctrl     (ctrl)
	, .rd1_addr (reg_rd1_addr)
	, .rd1_data (reg_rd1_data)
	, .rd2_addr (reg_rd2_addr)
	, .rd2_data (reg_rd2_data)
	, .wr_addr  (reg_wr_addr )
	, .wr_data  (reg_wr_data )
	, .wr_en    (`Control_Control_RegisterWriteEnable(control))
	);

wire [31:0] alu_data1;
wire [31:0] alu_data2;
reg [31:0] alu_data2$;
assign alu_data2 = alu_data2$;
wire [4:0]  alu_shamt;
reg [4:0]  alu_shamt$;
assign alu_shamt = alu_shamt$;
wire [31:0] alu_result;
wire        alu_zero;
Alu_hilo #
	( .DATA_W (32)
	) GALU
	( .ctrl (ctrl)
	, .func   (alu_func)
	, .data1  (alu_data1)
	, .data2  (alu_data2)
	, .shamt  (alu_shamt)
	, .result (alu_result)
	, .zero   (alu_zero)
	);

Opcode_aluFuncDecode GALUDEC
	( .opFunc (opFunc)
	, .func   (alu_func)
	);

Control_generate GCTRLGEN
	( .opFunc   (opFunc)
	, .control  (control)
	);

Opcode_instToOpFunc GITOOF
	( .op     (`Instruction_Parts_Op(instruction))
	, .func   (`Instruction_Parts_Func(instruction))
	, .opfunc (opFunc)
	);

`Pc_Action_T(wire) pc_action;
Pc_control GPCCTRL
	( .control  (control)
	, .zeroflag (alu_zero)
	, .zeroreg  (~(|reg_rd2_data))
	, .action   (pc_action)
	);

wire [31:0] pc_addr;
Pc_pc #
	( .ADDR_W (32)
	) GPC
	( .ctrl (ctrl)
	, .act  (pc_action)
	, .offset (`Instruction_Parts_Imm(instruction))
	, .jump   (`Instruction_Parts_Target(instruction))
	, .addr (pc_addr)
	);

assign rom_addr = pc_addr[7:2];
assign ram_addr = alu_result[7:2];
assign instruction = rom_out;
assign alu_data1 = reg_rd1_data;

wire [4:0] rs, rt, rd;
assign rs = `Instruction_Parts_Rs(instruction);
assign rt = `Instruction_Parts_Rt(instruction);
assign rs = `Instruction_Parts_Rd(instruction);

wire [15:0] immediate;
assign immediate = `Instruction_Parts_Imm(instruction);

always @(*)
	case(`Control_Control_RegisterWriteAddrSource(control))
		`Control_RegisterWriteAddrSource_Rt:
			reg_wr_addr$ = `Instruction_Parts_Rt(instruction);
		`Control_RegisterWriteAddrSource_Rd:
			reg_wr_addr$ = `Instruction_Parts_Rd(instruction);
		`Control_RegisterWriteAddrSource_None:
			reg_wr_addr$ = 5'b0;
		default:
			reg_wr_addr$ = 5'b0;
	endcase
always @(*)
	case(`Control_Control_RegisterWriteDataSource(control))
		`Control_RegisterWriteDataSource_Memory:
			reg_wr_data$ = ram_out;
		`Control_RegisterWriteDataSource_Alu:
			reg_wr_data$ = alu_result;
		default:
			reg_wr_data$ = alu_result;
	endcase
always @(*)
	case(`Control_Control_Register1AddrSource(control))
		`Control_Register1AddrSource_Rs:
			reg_rd1_addr$ = `Instruction_Parts_Rs(instruction);
		`Control_Register1AddrSource_Rt:
			reg_rd1_addr$ = `Instruction_Parts_Rt(instruction);
		`Control_Register1AddrSource_None:
			reg_rd1_addr$ = 5'b0;
		default:
			reg_rd1_addr$ = 5'b0;
	endcase
always @(*)
	case(`Control_Control_Register2AddrSource(control))
		`Control_Register2AddrSource_Rt:
			reg_rd2_addr$ = `Instruction_Parts_Rt(instruction);
		`Control_Register2AddrSource_None:
			reg_rd2_addr$ = 5'b0;
		default:
			reg_rd2_addr$ = 5'b0;
	endcase
always @(*)
	case(`Control_Control_ShamtSource(control))
		`Control_ShamtSource_Shamt:
			alu_shamt$ = `Instruction_Parts_Shamt(instruction);
		`Control_ShamtSource_Const2:
			alu_shamt$ = 5'h2;
		`Control_ShamtSource_Const16:
			alu_shamt$ = 5'h10;
		`Control_ShamtSource_None:
			alu_shamt$ = 5'h0;
		default:
			alu_shamt$ = 5'h0;
	endcase
always @(*)
	case(`Control_Control_AluData2Source(control))
		`Control_AluData2Source_Register:
			alu_data2$ = reg_rd2_data;
		`Control_AluData2Source_ImmediateSigned:
			alu_data2$ = { {16{immediate[15]}}, immediate };
		`Control_AluData2Source_ImmediateUnsigned:
			alu_data2$ = { 16'h0, immediate };
		default:
			alu_data2$ = reg_rd2_data;
	endcase

endmodule

`endif
