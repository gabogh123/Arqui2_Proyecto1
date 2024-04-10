/*
Main Decoder testbench 
Date: 20/03/24
*/

module main_decoder_tb;

    logic [2:0] Opcode;
	logic		V;
	logic [2:0]	Funct;


	logic		Branch;
	logic		MemtoReg;
	logic		MemW;
	logic		ALUSrc;
    logic [1:0]	ImmSrc;
	logic		RegW;
	logic		ALUOp;

    /* main_decoder instance */
    main_decoder main_deco (.Opcode(Opcode),
                            .V(V),
                            .Funct(Funct),
                            .Branch(Branch),
                            .MemtoReg(MemtoReg),
                            .MemW(MemW),
                            .ALUSrc(ALUSrc),
                            .ImmSrc(ImmSrc),
                            .RegW(RegW),
                            .ALUOp(ALUOp));

    initial begin
        $display("main_decoder testbench:\n");

        Opcode <= 3'b000;
        V <= 1'b0;
        Funct <= 3'b000;

    	$monitor("\nOpcode=%b ", Opcode,
                 "V=%b ", V,
                 "Funct=%b \n", Funct,
                 
                 "Branch=%b", Branch,
                 "MemtoReg=%b", MemtoReg,
                 "MemW=%b", MemW,
                 "ALUSrc=%b", ALUSrc,
                 "ImmSrc=%b", ImmSrc,
                 "RegW=%b", RegW,
                 "ALUOp=%b\n", ALUOp);
    end

    initial begin

        #50

        $display("\n\nType R's:\n");

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b0) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Funct <= 3'b001;

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b0) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Funct <= 3'b010;

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b0) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Funct <= 3'b011;

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b0) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Funct <= 3'b111;

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b0) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        $display("\n\nType I's:\n");

        #50

        Opcode <= 3'b100;
        V <= 1'b1;
        Funct <= 3'b000; // XXX

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b101;
        Funct <= 3'b110; // XXX

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b110;
        Funct <= 3'b011; // XXX

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b1))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b001;   // str
        Funct <= 3'b111; // XXX

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b1) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b010;   // ldr
        Funct <= 3'b000; // XXX

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b1) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b1) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        $display("\n\nBranches Type I's:\n");

        #50

        Opcode <= 3'b111;
        V <= 1'b0;
        Funct <= 3'b001; // XXX

        #50

        assert((Branch === 1'b1) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b100;
        Funct <= 3'b010; // XXX

        #50

        assert((Branch === 1'b1) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b101;
        Funct <= 3'b101; // XXX

        #50

        assert((Branch === 1'b1) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b110;
        Funct <= 3'b011; // XXX

        #50

        assert((Branch === 1'b1) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b00) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        $display("\n\nBranch Type J:\n");

        #50

        Opcode <= 3'b111;
        V <= 1'b1;
        Funct <= 3'b000; // XXX

        #50

        assert((Branch === 1'b1) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b1) & (ImmSrc === 2'b01) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        Opcode <= 3'b011;
        V <= 1'b0;  // X
        Funct <= 3'b101; // XXX

        #50

        assert((Branch === 1'b0) & (MemtoReg === 1'b0) & (MemW === 1'b0) & 
               (ALUSrc === 1'b0) & (ImmSrc === 2'b00) & (RegW === 1'b0) & (ALUOp === 1'b0))
        else $error("Failed @ Opcode=%b, V=%b, Funct=%b", Opcode, V, Funct);

        #50

        #100;

    end

    initial
	#2000 $finish;
    
endmodule
