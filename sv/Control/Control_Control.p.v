`ifndef CONTROL_CONTROL_M
`define CONTROL_CONTROL_M

`include "../Pc/Pc_Action.v"
`include "../Opcode/Opcode_OpFunc.v"
`include "../Control/Control_AluData2Source.v"
`include "../Control/Control_Register1AddrSource.v"
`include "../Control/Control_Register2AddrSource.v"
`include "../Control/Control_RegisterWriteAddrSource.v"
`include "../Control/Control_RegisterWriteDataSource.v"
`include "../Control/Control_ShamtSource.v"

$(makeStruct(
"Control_Control", [
("OpFunc"                  , "`Opcode_OpFunc_W"),
("RegisterWriteDataSource" , "`Control_RegisterWriteDataSource_W"),
("RegisterWriteAddrSource" , "`Control_RegisterWriteAddrSource_W"),
("MemoryWriteEnable"       , "1"),
("PcAction"                , "`Pc_Action_W"),
("AluData2Source"          , "`Control_AluData2Source_W"),
("ShamtSource"             , "`Control_ShamtSource_W"),
("Register1AddrSource"     , "`Control_Register1AddrSource_W"),
("Register2AddrSource"     , "`Control_Register2AddrSource_W"),
]))

`endif

