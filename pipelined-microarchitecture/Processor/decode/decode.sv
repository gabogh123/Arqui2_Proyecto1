/*
Pipeline's Decode Stage
Date: 07/04/24
*/
module decode # (parameter N = 24) (
		input logic clk,
		input logic rst,
		input logic RegWriteW,
		input logic FlushE,
		input logic [3:0] NFlags,
		input logic [N-1:0] InstrD, // instruction for decoding
		input logic [N-1:0] PCPlus8D,
		input logic [N-1:0] ResultW,
		input logic [3:0] WA3W,

		input logic vRegWriteW, // Faltaria traer este, se va a usar el escalar mientras
		input logic [255:0] vResultW, // Viene del result vectorial
		
		output logic PCSrcD,
		output logic PCSrcE,
		output logic RegWriteE,
		output logic MemtoRegE,
		output logic MemWriteE,
		output logic [2:0] ALUControlE,
		output logic ALUSelE,
		output logic BranchE,
		output logic ALUSrcE,

		output logic [1:0] FlagWriteE,
		output logic [2:0] OpcodeE,
		output logic [1:0] SE,
		output logic [3:0] FlagsE,
		output logic [N-1:0] RD1E,
		output logic [N-1:0] RD2E,
		output logic [3:0] WA3E,
		output logic [N-1:0] ExtImmE,
		// output logic [3:0] A3E,
		output logic [3:0] RA1H,
		output logic [3:0] RA2H,
		output logic [3:0] RA1E,
		output logic [3:0] RA2E,
		// output logic Stuck

		output logic vRegWriteE,
		output logic vMemWriteE,
		output logic [255:0] vRD1E,
		output logic [255:0] vRD2E
	);

	/* Instruction */
	logic [2:0] inst_opcode;
	logic [1:0] inst_S;
	logic [3:0] inst_rd;
	logic [3:0] inst_rs;
	logic [3:0] inst_rt;
	logic [2:0] inst_funct;
	logic [19:0] inst_add;
	assign inst_opcode = InstrD[23:21];
	assign inst_S = {InstrD[20], InstrD[0]};
	assign inst_rd = InstrD[19:16];
	assign inst_rs = InstrD[15:12];
	assign inst_rt = InstrD[11:8];
	assign inst_funct = InstrD[3:1];
	assign inst_add = InstrD[19:1];

	/* $pc's address */
	logic [3:0] reg15_address;
	assign reg15_address = 4'b1111;

	logic [3:0] RA1D;
	logic [3:0] RA2D;
	logic [N-1:0] RD1D;
	logic [N-1:0] RD2D;
	logic [N-1:0] ExtImmD;

	/* Vector Register File wires */
	logic [255:0] vRD1D;
	logic [255:0] vRD2D;
	
	logic RegWriteD;
	logic MemtoRegD;
	logic MemWriteD;
	logic [2:0] ALUControlD;
	logic ALUSelD;
	logic BranchD;
	logic ALUSrcD;
	logic [1:0] FlagWriteD;

	logic [1:0] ImmSrcD;
	logic [1:0] RegSrcD;

	logic vRegWriteD;
	logic vMemWriteD;
	

	/* RA1D (A1 from Register File) Mux */ /* A = mux_ra1 */
	mux_2NtoN # (.N(4)) mux_ra1d (.I0(inst_rs),
								  .I1(reg15_address),
								  .rst(rst),
								  .S(RegSrcD[0]),
								  .en(1'b1),
								  .O(RA1D));

	assign RA1H = RA1D;

	/* RA2D (A2 from Register File) Mux */ /* A = mux_ra2 */
	mux_2NtoN # (.N(4)) mux_ra2d (.I0(inst_rt),
								  .I1(inst_rd),
								  .rst(rst),
								  .S(RegSrcD[1]),
								  .en(1'b1),
								  .O(RA2D));

	assign RA2H = RA2D;

	/* Control_Unit */ /* A uses Stuck, but not implemented(?) */
	control_unit_v2 cont_unit (.Opcode(inst_opcode),
							   .S(inst_S),
							   .Func(inst_funct),
							   .Rd(inst_rd),

							   .PCSrc(PCSrcD),
							   .RegWrite(RegWriteD),
							   .MemtoReg(MemtoRegD),
							   .MemWrite(MemWriteD),
							   .ALUControl(ALUControlD),
							   .ALUSel(ALUSelD),
							   .Branch(BranchD),
							   .ALUSrc(ALUSrcD),
							   .FlagWrite(FlagWriteD),
							   .ImmSrc(ImmSrcD),
							   .RegSrc(RegSrcD),
							   .Stuck(Stuck),
							   
							   .vRegWrite(vRegWriteD),
							   .vMemWrite(vMemWriteD));

	/* Register File Scalar */
	register_file # (.N(N)) reg_file_s (.clk(clk),
									  	.rst(rst),
									 	.A1(RA1D),
									  	.A2(RA2D),
									  	.A3(WA3W),
									  	.WD3(ResultW),
									  	.R15(PCPlus8D),
									  	.WE3(RegWriteW),
									  	.RD1(RD1D),
									  	.RD2(RD2D));

	assign WA3E = inst_rd;

	/* Extend */
	extend_v2 # (.N(N)) extender (.A(inst_add),
							      .ImmSrc(ImmSrcD),
						   	      .ExtImm(ExtImmD));


	/* Register File Vector */
	register_file_vector # (.N(256)) reg_file_v (.clk(clk),
												.rst(rst),
												.A1(RA1D),
												.A2(RA2D),
												.A3(WA3W),
												.WD3(vResultW),
												.WE3(vRegWriteW),
												.RD1(vRD1D),
												.RD2(vRD2D));
	
	
	/* Pipeline Register Decode-Execute Stages */ /* A = regde */
	register_DE # (.N(N)) reg_DE (.clk(clk),
								  .rst(rst),
								  .clr(FlushE),

								  .PCSrcD(PCSrcD),
								  .RegWriteD(RegWriteD),
								  .MemtoRegD(MemtoRegD),
								  .MemWriteD(MemWriteD),
								  .ALUControlD(ALUControlD),
								  .ALUSelD(ALUSelD),
								  .BranchD(BranchD),
								  .ALUSrcD(ALUSrcD),
								  .FlagWriteD(FlagWriteD),
								  .OpcodeD(inst_opcode),
								  .SD(inst_S),
								  .NFlags(NFlags),

								  .RD1D(RD1D),
								  .RD2D(RD2D),
								  .ExtImmD(ExtImmD),
								  .A3D(WA3W),
								  .RA1D(RA1D),
								  .RA2D(RA2D),

								  .vRegWriteD(vRegWriteD),
                                  .vMemWriteD(vMemWriteD),
								  .vRD1D(vRD1D),
								  .vRD2D(vRD2D),

								  .PCSrcE(PCSrcE),
								  .RegWriteE(RegWriteE),
								  .MemtoRegE(MemtoRegE),
								  .MemWriteE(MemWriteE),
								  .ALUControlE(ALUControlE),
								  .ALUSelE(ALUSelE),
								  .BranchE(BranchE),
								  .ALUSrcE(ALUSrcE),
								  .FlagWriteE(FlagWriteE),
								  .OpcodeE(OpcodeE),
								  .SE(SE),
								  .FlagsE(FlagsE),

								  .RD1E(RD1E),
								  .RD2E(RD2E),
								  .ExtImmE(ExtImmE),
								  .A3E(A3E),
								  .RA1E(RA1E),
								  .RA2E(RA2E),

								  .vRegWriteE(vRegWriteE),
                                  .vMemWriteE(vMemWriteE),
								  .vRD1E(vRD1E),
								  .vRD2E(vRD2E));

endmodule
