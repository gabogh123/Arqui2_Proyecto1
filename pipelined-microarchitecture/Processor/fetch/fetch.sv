/*
Pipeline's Fetch Stage
Date: 06/04/24
*/
module fetch # (parameter N = 24) (
		input  logic clk,
		input  logic rst,
		input  logic [N-1:0] ResultW,
		input  logic [N-1:0] ALUResultE,
		input  logic PCSrcW,
		input  logic BranchTakenE,
		input  logic StallF,
		input  logic StallD,
		input  logic FlushD,
		input  logic [N-1:0] instruction, /* Input from Memory */

		output logic [N-1:0] PCF, /* Output to Memory */ //A = PCout / L = PCF / RG = pc_address
		output logic [N-1:0] InstrD,
		output logic [N-1:0] InstrD_vector,
		output logic [N-1:0] PCPlus8D
	);

	/* wiring */
	logic [N-1:0] PCPlus4F;
	logic [N-1:0] PCJump;
	logic [N-1:0] NPC; // A = PCNext / L = PC' / RG = next_pc_address
	logic [N-1:0] InstrF; // A = Inst / L = InstrF / RG = instruction
	logic [N-1:0] InstrF_vector;

	
	/* PC from Result Mux */ /* A = mux_pc4 */
	mux_2NtoN # (.N(N)) mux_PCfromResult (.I0(PCPlus4F),
										  .I1(ResultW),
										  .rst(rst),
										  .S(PCSrcW),
										  .en(1'b1),
										  .O(PCJump));
	
	/* PC from ALU Mux */ /* A = mux_pcnext */
	mux_2NtoN # (.N(N)) mux_PCfromALU (.I0(PCJump),
									   .I1(ALUResultE),
									   .rst(rst),
									   .S(BranchTakenE),
									   .en(1'b1),
									   .O(NPC));
		
	/* PC Register */
	register_v2 # (.N(N)) program_counter (.clk(clk),
										   .rst(rst),
										   .en(StallF),
										   .D(NPC),
										   .Q(PCF));
	
	/* PCPlus4_Adder */ /* A = PCout + 4 */
	single_adder # (.N(N)) pc_plus_4_adder (.A(PCF),
									  		.B(24'b01),	// 1 because of instruction memory's address convention
									  		.Y(PCPlus4F));
	
	/* PCPlus8D goes into Register File in next stage */
	assign PCPlus8D = PCPlus4F;
	
	// MemInst MI (PCout, Inst);
	// Instruction Memory va a ir en el modulo de Memory instanciado en el top
	
	/* Selects the scalar datapath or vector datapath */ /* A = InstSelector */
	datapath_selector # (.N(N)) data_select (.instruction(instruction),
										   	 .scalar_datapath_instruction(InstrF),
										   	 .vector_datapath_instruction(InstrF_vector));

	/* Pipeline Register Fetch-Decode Stages */ /* A = regfd */
	register_FD # (.N(N)) reg_FD (.clk(clk),
								  .rst(rst),
								  .en(StallD),
								  .clr(FlushD),
								  .InstrF(InstrF),
								  .InstrF_vector(InstrF_vector),
								  .InstrD(InstrD),
								  .InstrD_vector(InstrD_vector));

endmodule
