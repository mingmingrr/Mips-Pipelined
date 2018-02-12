`ifndef PC_ACTION_M
`define PC_ACTION_M

`define Pc_Action_T(T) T [`Pc_Action_W-1:0]
`define Pc_Action_W 2
`define Pc_Action_L 4

`define Pc_Action_None   `Pc_Action_W'(0)
`define Pc_Action_Inc    `Pc_Action_W'(1)
`define Pc_Action_Offset `Pc_Action_W'(2)
`define Pc_Action_Jump   `Pc_Action_W'(3)

`endif

