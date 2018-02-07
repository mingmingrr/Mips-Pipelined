// vim: set ft=verilog:

`ifndef UTIL_VECTOR_M
`define UTIL_VECTOR_M

`define util_vector_chain(PK_WIDTH,PK_DEPTH,PK_SRC,PK_DEST, BLOCK_ID, GEN_VAR) \
	genvar GEN_VAR; \
	generate \
		for(GEN_VAR=0; GEN_VAR<(PK_DEPTH); GEN_VAR=GEN_VAR+1) begin: BLOCK_ID \
			assign PK_DEST[((PK_WIDTH)*GEN_VAR+((PK_WIDTH)-1)):((PK_WIDTH)*GEN_VAR)] = \
				PK_SRC[GEN_VAR][((PK_WIDTH)-1):0]; \
		end \
	endgenerate

`define util_vector_unchain(PK_WIDTH,PK_DEPTH,PK_DEST,PK_SRC, BLOCK_ID, GEN_VAR) \
	genvar GEN_VAR; \
	generate \
		for(GEN_VAR=0; GEN_VAR<(PK_DEPTH); GEN_VAR=GEN_VAR+1) begin: BLOCK_ID \
			assign PK_DEST[GEN_VAR][((PK_WIDTH)-1):0] = \
				PK_SRC[((PK_WIDTH)*GEN_VAR+(PK_WIDTH-1)):((PK_WIDTH)*GEN_VAR)]; \
		end \
	endgenerate

`endif
