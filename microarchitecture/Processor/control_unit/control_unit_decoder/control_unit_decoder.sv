/*
Decoder del Control Unit
Diseño basado en la figura 7.16 (b) del libro
Digital Design and Computer Architecture ARM Editon
de Sarah L. Harries & David Money Harries.
Date: 20/03/24
*/
module control_unit_decoder(
    	input  logic [2:0]     Opcode,
		input  logic                V,
		input  logic [2:0]      Funct,
        input  logic [3:0]         Rd,      // instruction[19:16]

        output logic              PCS,
        output logic             RegW,
        output logic             MemW,
        output logic         MemtoReg,
        output logic           ALUSrc,
        output logic [1:0]     ImmSrc,
        output logic [2:0] ALUControl
    );

    wire wBranch;
    wire wAluOp;

    /* PC Logic */ /* tb done */
    pc_logic pc_l (.Rd(Rd),
                   .Branch(wBranch),
                   .RegW(RegW),
                   .PCS(PCS));

    /* Main Decoder */ /* tb */
    main_decoder main_deco (.Opcode(Opcode),
                            .V(V),
                            .Funct(Funct),
                            .Branch(wBranch),
                            .MemtoReg(MemtoReg),
                            .MemW(MemW),
                            .ALUSrc(ALUSrc),
                            .ImmSrc(ImmSrc),
                            .RegW(RegW),
                            .ALUOp(wAluOp));

    /* ALU Decoder */ /* tb done */
    alu_decoder alu_deco (.Opcode(Opcode),
                          .Funct(Funct),
                          .ALUOp(wAluOp),
                          .ALUControl(ALUControl));

endmodule
