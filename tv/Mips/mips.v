`ifndef MIPS_MIPS_I
`define MIPS_MIPS_I

`include "../Data/Control.v"
`include "../Data/Memory/ram.v"
`include "../Data/Memory/rom.v"
`include "../Mips/Alu/hilo.v"
`include "../Mips/Alu/Func.v"
`include "../Mips/Alu/hilo.v"
`include "../Mips/Pc/pc.v"
`include "../Mips/Pc/control.v"
`include "../Mips/Instruction/Format/IFormat.v"
`include "../Mips/Instruction/Format/JFormat.v"
`include "../Mips/Instruction/Format/RFormat.v"
`include "../Mips/Instruction/OpFunc/OpFunc.v"
`include "../Mips/Instruction/OpFunc/aluFuncDecode.v"
`include "../Mips/Instruction/OpFunc/instToOpFunc.v"
`include "../Mips/Control/Control.v"
`include "../Mips/Control/generate.v"
`include "../Mips/Register/registers.v"

module Mips_mips #
	( parameter FILE = "../../asm/test0.mif"
	, parameter ADDR_L = 64
	)
	( `Data_Control_T(input) ctrl
	);

`Mips_Instruction_OpFunc_OpFunc_T(wire) opFunc;
`Mips_Alu_Func_T(wire) alu_func;
`Mips_Control_Control_T(wire) control;
wire [31:0] instruction;

wire [5:0] ram_addr;
wire [31:0] ram_data;
wire ram_wren;
wire [31:0] ram_out;
Data_Memory_ram #
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
Data_Memory_rom #
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
Mips_Register_registers #
	( .DATA_W (32)
	, .ADDR_L (32)
	) GREG
	( .ctrl    (ctrl)
	, .rd1Addr (reg_rd1_addr)
	, .rd1Data (reg_rd1_data)
	, .rd2Addr (reg_rd2_addr)
	, .rd2Data (reg_rd2_data)
	,  .wrAddr (reg_wr_addr )
	,  .wrData (reg_wr_data )
	,  .wrEnable (`Mips_Control_Control_RegisterWriteEnable(control))
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
Mips_Alu_hilo #
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

Mips_Instruction_OpFunc_aluFuncDecode GALUDEC
	( .opFunc (opFunc)
	, .func   (alu_func)
	);

Mips_Control_generate GCTRLGEN
	( .opFunc   (opFunc)
	, .control  (control)
	);

Mips_Instruction_OpFunc_instToOpFunc GITOOF
	( .op     (`Mips_Instruction_Format_RFormat_Op(instruction))
	, .func   (`Mips_Instruction_Format_RFormat_Func(instruction))
	, .opFunc (opFunc)
	);

`Mips_Pc_Action_T(wire) pc_action;
Mips_Pc_control GPCCTRL
	( .control  (control)
	, .zeroflag (alu_zero)
	, .zeroreg  (~(|reg_rd2_data))
	, .action   (pc_action)
	);

wire [31:0] pc_addr;
Mips_Pc_pc #
	( .ADDR_W (32)
	) GPC
	( .ctrl (ctrl)
	, .act  (pc_action)
	, .offset (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .jump   (`Mips_Instruction_Format_JFormat_Target(instruction))
	, .addr (pc_addr)
	);

assign rom_addr = pc_addr[7:2];
assign ram_addr = alu_result[7:2];
assign instruction = rom_out;
assign alu_data1 = reg_rd1_data;

wire [4:0] rs, rt, rd;
assign rs = `Mips_Instruction_Format_RFormat_Rs(instruction);
assign rt = `Mips_Instruction_Format_RFormat_Rt(instruction);
assign rs = `Mips_Instruction_Format_RFormat_Rd(instruction);

wire [15:0] immediate;
assign immediate = `Mips_Instruction_Format_IFormat_Imm(instruction);

always @(*)
	case(`Mips_Control_Control_RegisterWriteAddrSource(control))
		`Mips_Control_Signal_RegisterWriteAddrSource_Rt:
			reg_wr_addr$ = `Mips_Instruction_Format_RFormat_Rt(instruction);
		`Mips_Control_Signal_RegisterWriteAddrSource_Rd:
			reg_wr_addr$ = `Mips_Instruction_Format_RFormat_Rd(instruction);
		`Mips_Control_Signal_RegisterWriteAddrSource_None:
			reg_wr_addr$ = 5'b0;
		default:
			reg_wr_addr$ = 5'b0;
	endcase
always @(*)
	case(`Mips_Control_Control_RegisterWriteDataSource(control))
		`Mips_Control_Signal_RegisterWriteDataSource_Memory:
			reg_wr_data$ = ram_out;
		`Mips_Control_Signal_RegisterWriteDataSource_Alu:
			reg_wr_data$ = alu_result;
		default:
			reg_wr_data$ = alu_result;
	endcase
always @(*)
	case(`Mips_Control_Control_Register1AddrSource(control))
		`Mips_Control_Signal_Register1AddrSource_Rs:
			reg_rd1_addr$ = `Mips_Instruction_Format_RFormat_Rs(instruction);
		`Mips_Control_Signal_Register1AddrSource_Rt:
			reg_rd1_addr$ = `Mips_Instruction_Format_RFormat_Rt(instruction);
		`Mips_Control_Signal_Register1AddrSource_None:
			reg_rd1_addr$ = 5'b0;
		default:
			reg_rd1_addr$ = 5'b0;
	endcase
always @(*)
	case(`Mips_Control_Control_Register2AddrSource(control))
		`Mips_Control_Signal_Register2AddrSource_Rt:
			reg_rd2_addr$ = `Mips_Instruction_Format_RFormat_Rt(instruction);
		`Mips_Control_Signal_Register2AddrSource_None:
			reg_rd2_addr$ = 5'b0;
		default:
			reg_rd2_addr$ = 5'b0;
	endcase
always @(*)
	case(`Mips_Control_Control_ShamtSource(control))
		`Mips_Control_Signal_ShamtSource_Shamt:
			alu_shamt$ = `Mips_Instruction_Format_RFormat_Shamt(instruction);
		`Mips_Control_Signal_ShamtSource_Const2:
			alu_shamt$ = 5'h2;
		`Mips_Control_Signal_ShamtSource_Const16:
			alu_shamt$ = 5'h10;
		`Mips_Control_Signal_ShamtSource_None:
			alu_shamt$ = 5'h0;
		default:
			alu_shamt$ = 5'h0;
	endcase
always @(*)
	case(`Mips_Control_Control_AluData2Source(control))
		`Mips_Control_Signal_AluData2Source_Register:
			alu_data2$ = reg_rd2_data;
		`Mips_Control_Signal_AluData2Source_ImmediateSigned:
			alu_data2$ = { {16{immediate[15]}}, immediate };
		`Mips_Control_Signal_AluData2Source_ImmediateUnsigned:
			alu_data2$ = { 16'h0, immediate };
		default:
			alu_data2$ = reg_rd2_data;
	endcase

endmodule

`endif
