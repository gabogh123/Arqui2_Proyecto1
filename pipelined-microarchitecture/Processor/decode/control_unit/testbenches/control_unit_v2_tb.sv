/*
control_unit testbench
Date: 20/03/24
TERMINAR
*/
module control_unit_v2_tb;

    timeunit 1ps;
    timeprecision 1ps;

	logic	      clk;
	logic	      rst;

    logic [2:0] Opcode;
    logic       V;
    logic [2:0] Funct;

    logic [3:0] Rd;

    logic [3:0] ALUFlags;
    logic       PCSrc;
    logic       MemtoReg;
    logic       MemWrite;
	logic [2:0] ALUControl;
	logic       ALUSrc;
	logic [1:0] ImmSrc;
    logic       RegWrite;

    /* internal signals */

    logic RegW;
    logic MemW;

    logic Branch;

	control_unit_v2 uut (.clk(clk),
                        .rst(rst),
                        .Opcode(Opcode),
                        .V(V),
                        .Funct(Funct),
                        .Rd(Rd),
                        .ALUFlags(ALUFlags),
                        .PCSrc(PCSrc),
                        .MemtoReg(MemtoReg),
                        .MemWrite(MemWrite),
                        .ALUControl(ALUControl),
                        .ALUSrc(ALUSrc),
                        .ImmSrc(ImmSrc),
                        .RegWrite(RegWrite));
	// Initialize inputs

    initial begin
		$display("control_unit testbench:\n");

		clk = 0;
		rst = 0;
		Opcode = 3'b000;
		V = 1'b0;
        Funct = 3'b000;
        Rd = 4'b000;
        ALUFlags = 4'b0000;
        
        
        $monitor("Control Unit:\n",
                 "Opcode = %b | ", Opcode,
                 "V = %b | ", V,
                 "Funct = %b | ", Funct,
                 "Rd = %b (%h) \n", Rd, Rd,
                // "ALUFlags = %b \n", ALUFlags,
                 "PCSrc = %b\n", PCSrc,
                 "Branch = %b\n", Branch,
                 "MemtoReg = %b\n", MemtoReg,
                 "MemWrite = %b\n", MemWrite,
                 "MemW = %b\n", MemW,
                 "ALUControl = %b\n", ALUControl,
                 "ALUSrc = %b\n", ALUSrc,
                 "ImmSrc = %b\n", ImmSrc,
                 "RegW = %b\n", RegW,
                 "RegWrite = %b\n", RegWrite);
    end

    always begin
		#50 clk = !clk;
        RegW = uut.RegW;
        MemW = uut.MemW;
        Branch = uut.decoder.wBranch;

    end

    initial	begin

        #100

        rst = 1;

        #100

        rst = 0;

        #100

        $display("\nInstruction: add\n");
        Opcode = 3'b000;
		V = 1'b0;
        Funct = 3'b000;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: sub\n");
        Opcode = 3'b000;
		V = 1'b0;
        Funct = 3'b001;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: mul\n");
        Opcode = 3'b000;
		V = 1'b0;
        Funct = 3'b010;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: addi\n");
        Opcode = 3'b100;
		V = 1'b1;
        Funct = 3'b000;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: subi\n");
        Opcode = 3'b101;
		V = 1'b1;
        Funct = 3'b001;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: muli\n");
        Opcode = 3'b110;
		V = 1'b1;
        Funct = 3'b010;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: sll\n");
        Opcode = 3'b000;
		V = 1'b0;
        Funct = 3'b011;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: slr\n");
        Opcode = 3'b000;
		V = 1'b0;
        Funct = 3'b111;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: str\n");
        Opcode = 3'b001;
		V = 1'b0;
        Funct = 3'b100;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: ldr\n");
        Opcode = 3'b010;
		V = 1'b0;
        Funct = 3'b100;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: beq\n");
        Opcode = 3'b111;
		V = 1'b0;
        Funct = 3'b111;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: bnq\n");
        Opcode = 3'b100;
		V = 1'b0;
        Funct = 3'b011;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: bgt\n");
        Opcode = 3'b101;
		V = 1'b0;
        Funct = 3'b111;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: blt\n");
        Opcode = 3'b110;
		V = 1'b0;
        Funct = 3'b110;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;

        #100

        $display("\nInstruction: b\n");
        Opcode = 3'b111;
		V = 1'b1;
        Funct = 3'b101;
        Rd = 4'b1000;
        ALUFlags = 4'b0000;


        #100;

		// Done

    end

    initial
	#1900 $finish;                                 

endmodule
