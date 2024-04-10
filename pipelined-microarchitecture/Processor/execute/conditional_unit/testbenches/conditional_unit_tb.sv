/*
Condition Logic testbench 
Date: 20/03/24
*/

module conditional_unit_tb;

    logic clk;
    logic rst;

    logic [2:0] Opcode;
    logic 		V;
    logic [3:0] ALUFlags;
    // logic [1:0] FlagW;

    logic		PCS;
	logic		RegW;
	logic		MemW;

	logic		PCSrc;
	logic		RegWrite;
	logic		MemWrite;

    logic FlagWrite;
    logic CondEx;
    logic [3:0] Flags;

    conditional_unit uut (.clk(clk),
                            .rst(rst),
                            .Opcode(Opcode),
                            .V(V),
                            .ALUFlags(ALUFlags),
                            //.FlagW(FlagW),
                            .PCS(PCS),
                            .RegW(RegW),
                            .MemW(MemW),
                            .PCSrc(PCSrc),
                            .RegWrite(RegWrite),
                            .MemWrite(MemWrite)
                            );

    initial begin
        $display("Conditional_logic testbench :\n");

        clk <= 0;
        rst <= 0;

        Opcode <= 3'b000;
        ALUFlags <= 4'b0000;

        // FlagW <= 2'b00;
        PCS <= 1'b0;
        RegW <= 1'b0;
        MemW <= 1'b0;
    

    	$monitor("Control_unit's Processor Inputs:       ",
             "Opcode=%b ",                 Opcode,
             "ALUFlags=%b\n",              ALUFlags,
             "Control_unit_decoder's Inputs:         ",
             //"FlagW=%b ",                  FlagW,
             "PCS=%b ",                    PCS,
             "RegW=%b ",                   RegW,
             "MemW=%b ",                   MemW,
             "Internal Signals:                      ",
             "FlagWrite=%b ",              uut.FlagWrite,
             "CondEx=%b ",                 uut.CondEx,
             "Flags=%b\n",                 uut.Flags,
             "Control_unit's Processor Outputs:      ",
             "PCSrc=%b ",                 PCSrc,
             "RegWrite=%b ",              RegWrite,
             "MemWrite=%b\n",             MemWrite);
    end

    always begin

        #50 clk = !clk;
        FlagWrite = uut.FlagWrite;
        CondEx = uut.CondEx;
        Flags = uut.Flags;
    end

    initial begin

        #100

        rst = 1;

        #100

        rst = 0;

        #100

         $display("Opcode: unconditional, no flags");
        Opcode <= 3'b110;
        ALUFlags <= 4'b0000;

        // FlagW <= 2'b00;
        PCS <= 1'b1;
        RegW <= 1'b1;
        MemW <= 1'b0;
        
         #100

        $display("Opcode: unconditional, N=0 Z=1 C=0 V=0");
        Opcode <= 4'b110;
        ALUFlags <= 4'b0100;

        // FlagW <= 2'b11;
        PCS <= 1'b1;
        RegW <= 1'b1;
        MemW <= 1'b0;

        #100

        $display("Opcode: EQ, last flags: N=0 Z=1 C=0 V=0");
        Opcode <= 3'b011;
        ALUFlags <= 4'b0000;

        // FlagW <= 2'b11;
        PCS <= 1'b1;
        RegW <= 1'b1;
        MemW <= 1'b1;

        #50

        assert((CondEx === 1) & (PCSrc === 1) & (RegWrite === 1) & (MemWrite === 1))
        else $error("Failed @ Opcode=%b ALUFlags=%b", Opcode, ALUFlags);

        #100

        $display("Opcode: EQ, last flags N=0 Z=0 C=0 V=0");
        Opcode <= 3'b011;
        ALUFlags <= 4'b1111;

        // FlagW <= 2'b00;
        PCS <= 1'b1;
        RegW <= 1'b1;
        MemW <= 1'b0;

        #50

        assert((CondEx === 0) & (PCSrc === 0) & (RegWrite === 0) & (MemWrite === 0))
        else $error("Failed @ Opcode=%b ALUFlags=%b", Opcode, Flags);

        #100;
    end

    initial
	#1000 $finish;
    
endmodule
