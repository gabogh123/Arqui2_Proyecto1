/*
Control Unit v2 module 
Date: 07/04/2024
*/
module control_unit_v2 (		
		input  logic [2:0] Opcode,
		input  logic V,
		input  logic [2:0] Funct,
		input  logic [3:0] Rd,

		output logic PCSrc,
		output logic RegWrite,
		output logic MemtoReg,
		output logic MemWrite,
		output logic [2:0] ALUControl,
		output logic Branch,
		output logic ALUSrc,
		output logic [1:0] FlagWrite,
		output logic [1:0] ImmSrc,
		output logic [1:0] RegSrc,
		output logic Stuck /* A added */
	);

    wire wAluOp;

    /* PC Logic */
    pc_logic pc_l (.Rd(Rd),
                   .Branch(Branch),
                   .RegW(RegWrite),
                   .PCS(PCSrc));

    /* Main Decoder */
    main_decoder main_deco (.Opcode(Opcode),
                            .V(V),
                            .Funct(Funct),
                            .Branch(Branch),
                            .MemtoReg(MemtoReg),
                            .MemW(MemWrite),
                            .ALUSrc(ALUSrc),
                            .ImmSrc(ImmSrc),
                            .RegW(RegWrite),
                            .RegSrc(RegSrc),
                            .ALUOp(wAluOp));

    /* ALU Decoder */
    alu_decoder alu_deco (.Opcode(Opcode),
                          .Funct(Funct),
                          .ALUOp(wAluOp),
						  // Flag Write iba siempre a ser 1 ya que siempre se va a escribir *
                          .ALUControl(ALUControl));

	// *
	assign FlagWrite = 2'b11;
	// ** Revisar cuando se revise de donde vendrá el Stuck
	assign Stuck = 1'b0;
	

endmodule
