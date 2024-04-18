/*
fir_filter (Top Module) testbench
Date: 09/04/24
*/
module fir_filter_tb;

	timeunit 1ps;
	timeprecision 1ps;

	parameter N = 24;

	logic	                clk;
	logic	                rst;
	logic	                pwr;
	logic	                dbg;
	logic	                stp;
	logic	                out;

	/* internal signals */
	// Fetch
	logic PCSrcW;
	logic BranchTakenE;
	logic [N-1:0] NPC;
	logic [N-1:0] PCF;
	logic [N-1:0] InstrF;
	// Decode
	// -> Instruction
	logic [N-1:0] InstrD;
	logic [2:0] OpcodeD;
	logic [1:0] SD;
	logic [2:0] FuncD;
	logic [3:0] Rd;
	logic [3:0] Rs;
	logic [3:0] Rt;
	logic [3:0] ShamtD;
	// -> Register File
	logic [1:0] RegSrcD;
	logic [3:0] RA1D;
	logic [3:0] RA2D;
	logic [3:0] A3;
	logic [N-1:0] WD3;
	logic [N-1:0] R15;
	// -> Registers
	logic [N-1:0] e0_reg;
	logic [N-1:0] e1_reg;
	logic [N-1:0] e2_reg;
	logic [N-1:0] e3_reg;
	logic [N-1:0] e4_reg;
	logic [N-1:0] e5_reg;
	logic [N-1:0] e6_reg;
	logic [N-1:0] pc_reg;
	// -> RegFile data
	logic RegWriteW;
	logic [N-1:0] RD1;
	logic [N-1:0] RD2;
	// -> Extend
	logic ImmSrcD;
	logic [N-1:0] ExtImmD;

	// Execute
	logic [1:0] ForwardAE;
	logic [N-1:0] SrcAE;
	logic [1:0] ForwardBE;
	logic [N-1:0] WriteDataE;
	logic [N-1:0] SrcBE;
	logic [2:0] ALUControlE;
	logic ALUSelE;
	logic [N-1:0] ALUResult_nfp;
	logic [N-1:0] ALUResult_wfp;
	logic [N-1:0] ALUResultE;
	logic [3:0] ALUFlags_nfp;
	logic [3:0] ALUFlags_wfp;
	logic [3:0] ALUFlags;

	// Memory
	logic [N-1:0] ReadData_scalar;
	logic MemWrite_scalar;
	logic [N-1:0] ALUResult_scalar;
	logic [N-1:0] WriteData_scalar;

	// Writeback
	logic MemtoRegW;
	logic [N-1:0] ALUOutW;
	logic [N-1:0] ReadDataW;

	// Hazard Unit


	/* fir_filter instance */
	fir_filter uut (.clk(clk),
					.rst(rst),
					.pwr(pwr),
					.dbg(dbg),
					.stp(stp),
					.out(out));

	// Initialize inputs

	initial begin
		$display("fir_filter testbench:\n");

		clk = 0;
		rst = 1;
		pwr = 1;
		dbg = 1;
		stp = 1;

	/*
		$monitor("*** Fetch Signals: ***\n",
				"PC Address\n",
					"next_pc_address = %b (%h)\n", next_pc_address, next_pc_address,
				
					"Funct = %b (%h)\n", Funct, Funct,
				"Registers\n",
					"Result = %b (%h)\n", Result, Result);*/
	end

	always begin
		#50 clk = !clk;
		// Fetch
		PCSrcW = uut.asip.fetch_stage.PCSrcW;
		BranchTakenE = uut.asip.fetch_stage.BranchTakenE; 
		NPC = uut.asip.fetch_stage.NPC;
		PCF = uut.asip.fetch_stage.PCF;
		InstrF = uut.asip.fetch_stage.instruction;
		
		// Decode
		// -> Instruction
		InstrD = uut.asip.sDecode.InstrD;
		OpcodeD = uut.asip.sDecode.inst_opcode;
		SD = uut.asip.sDecode.inst_S;
		FuncD = uut.asip.sDecode.inst_funct;
		Rd = uut.asip.sDecode.inst_rd;
		Rs = uut.asip.sDecode.inst_rs;
		Rt = uut.asip.sDecode.inst_rt;
		ShamtD = InstrD[7:4];
		// -> Register File
		RegSrcD = uut.asip.sDecode.RegSrcD;
		RA1D = uut.asip.sDecode.RA1D;
		RA2D = uut.asip.sDecode.RA2D;
		A3 = uut.asip.sDecode.WA3W;
		WD3 = uut.asip.sDecode.ResultW;
		R15 = uut.asip.sDecode.PCPlus8D;
		// -> Registers
		e0_reg = uut.asip.sDecode.reg_file_s.reg_array[8];
		e1_reg = uut.asip.sDecode.reg_file_s.reg_array[9];
		e2_reg = uut.asip.sDecode.reg_file_s.reg_array[10];
		e3_reg = uut.asip.sDecode.reg_file_s.reg_array[11];
		e4_reg = uut.asip.sDecode.reg_file_s.reg_array[12];
		e5_reg = uut.asip.sDecode.reg_file_s.reg_array[13];
		e6_reg = uut.asip.sDecode.reg_file_s.reg_array[14];
		pc_reg = uut.asip.sDecode.reg_file_s.reg_array[15];
		// -> RegFile data
		RegWriteW = uut.asip.sDecode.RegWriteW;
		RD1 = uut.asip.sDecode.RD1D;
		RD2 = uut.asip.sDecode.RD2D;
		// -> Extend
		ImmSrcD = uut.asip.sDecode.ImmSrcD;
		ExtImmD = uut.asip.sDecode.ExtImmD;
		// Execute
		ForwardAE = uut.asip.sExecute.ForwardAE;
		SrcAE = uut.asip.sExecute.SrcAE;
		ForwardBE = uut.asip.sExecute.ForwardBE;
		WriteDataE = uut.asip.sExecute.WriteDataE;
		SrcBE = uut.asip.sExecute.SrcBE;
		ALUControlE = uut.asip.sExecute.ALUControlE;
		ALUControlE = uut.asip.sExecute.ALUControlE;
		ALUSelE = uut.asip.sExecute.ALUSelE;
		ALUResult_nfp = uut.asip.sExecute.ALUResult_nfp;
		ALUResult_wfp = uut.asip.sExecute.ALUResult_wfp;
		ALUResultE = uut.asip.sExecute.ALUResultE;
		ALUFlags_nfp = uut.asip.sExecute.ALUFlags_nfp;
		ALUFlags_wfp = uut.asip.sExecute.ALUFlags_wfp;
		ALUFlags = uut.asip.sExecute.ALUFlags;
		// Memory
		ReadData_scalar = uut.full_memory.read_data_scalar;
		MemWrite_scalar = uut.full_memory.MemWrite_scalar;
		ALUResult_scalar = uut.full_memory.data_address_scalar;
		WriteData_scalar = uut.full_memory.write_data_scalar;
		//Writeback
		MemtoRegW = uut.asip.wMemtoRegW;
		ALUOutW = uut.asip.wALUOutW;
		ReadDataW = uut.asip.wReadDataW;
	end

	initial	begin

		#100


		pwr <= 0;
		rst <= 0;

		#200
		
		pwr <= 1;
		rst <= 1;

		#200;

		// rst = 1;

		// #100;

	end

	initial
	#4000 $finish;                                 

endmodule
