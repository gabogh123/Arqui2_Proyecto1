/*
ALU Decoder testbench 
Date: 20/03/24
*/

module alu_decoder_tb;

    logic [2:0] Opcode;
	logic [2:0]	Funct;
	logic		ALUOp;
    logic [2:0]	ALUControl;

    /* alu_decoder instance */
    alu_decoder uut (.Opcode(Opcode),
                     .Funct(Funct),
                     .ALUOp(ALUOp),
                     .ALUControl(ALUControl));

    initial begin
        $display("alu_deocder testbench:\n");

        Opcode <= 3'b000;
        Funct <= 3'b000;
        ALUOp <= 1'b0;

    	$monitor("\nOpcode=%b ", Opcode,
                 "Funct=%b ", Funct,
                 "ALUOp=%b ", ALUOp,
                 "ALUControl=%b\n", ALUControl);
    end

    initial begin

        #100

        $display("\n\nType R's:\n");

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        ALUOp <= 1'b1;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Funct <= 3'b001;

        #50

        assert((ALUControl === 3'b001))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        ALUOp <= 1'b0;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Funct <= 3'b010;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        ALUOp <= 1'b1;

        #50

        assert((ALUControl === 3'b010))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Funct <= 3'b011;

        #50

        assert((ALUControl === 3'b011))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Funct <= 3'b111;

        #50

        assert((ALUControl === 3'b111))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        $display("\n\nInmediates's:\n");
        Opcode <= 3'b100;
        Funct <= 3'b000;
        ALUOp <= 1'b0;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        ALUOp <= 1'b1;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Opcode <= 3'b101;

        #50

        assert((ALUControl === 3'b001))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Opcode <= 3'b110;

        #50

        assert((ALUControl === 3'b010))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        $display("\n\nOpcode not implemented:\n");
        Opcode <= 3'b001;
        Funct <= 3'b000;
        ALUOp <= 1'b0;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Opcode <= 3'b001;
        ALUOp <= 1'b1;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Opcode <= 3'b010;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        Opcode <= 3'b011;

        #50

        assert((ALUControl === 3'b000))
        else $error("Failed @ Opcode=%b, Funct=%b, ALUOp=%b", Opcode, Funct, ALUOp);

        #50

        #100;
    end

    initial
	#2000 $finish;
    
endmodule
