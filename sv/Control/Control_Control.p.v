`ifndef CONTROL_CONTROL_M
`define CONTROL_CONTROL_M

`include "../Pc/Pc_Action.v"
`include "../Opcode/Opcode_OpFunc.v"

$(__import__("imp").load_source("MS", "../../py/vstruct.py").makeStruct(
"Control_Control", [
("OpFunc"                  , "`Opcode_OpFunc_W"),
("RegisterWriteDataSource" , "1"),
("RegisterWriteAddrSource" , "1"),
("MemoryReadEnable"        , "1"),
("MemoryWriteEnable"       , "1"),
("PcAction"                , "`Pc_Action_W"),
("AluData2Source"          , "1"),
]))

`endif

