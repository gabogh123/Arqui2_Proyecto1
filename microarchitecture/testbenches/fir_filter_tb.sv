/*
fir_filter (Top Module) testbench
Date: 20/03/24
MODIFICAR
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

    // PC Adresses
	logic await;
	logic pc_enable;
    logic [N-1:0] next_pc_address;
    logic [N-1:0] pc_address;       //instruction_address from memory

    // Instruction
    logic [N-1:0] instruction;
    logic [2:0] Opcode;
    logic       V;
    logic [3:0] Rd;
    logic [3:0] Rs;
    logic [3:0] Rt;
    logic [2:0] Funct;
   //  logic [11:0] InstImmediate;
    logic [19:0] InstAddress;

    // Registers
    logic [N-1:0] e0_reg;
    logic [N-1:0] e1_reg;
    logic [N-1:0] e2_reg;
    logic [N-1:0] e3_reg;
    logic [N-1:0] e4_reg;
    logic [N-1:0] e5_reg;
    logic [N-1:0] e6_reg;
    logic [N-1:0] pc_reg;

    // Control Signals
    logic PCS;
    logic RegW;
    logic MemW;
    logic CondEx;
    logic PCSrc;
    logic MemWrite;
    logic RegWrite;
    logic MemtoReg;
    logic next_PCSrc;
    logic next_RegWrite;
    logic next_MemWrite;
    logic [1:0] ImmSrc;
    logic ALUSrc;
    logic [2:0] ALUControl;

    // Extend
    logic [N-1:0] ExtImm;

    // ALU
    logic [N-1:0] alu_SrcA;
    logic [N-1:0] alu_SrcB;
    logic [4:0] shamt;
    logic [3:0]   ALUFlags;
    logic [N-1:0] alu_scalar_result;

    // Memory
   //  logic InstructionMemRead;
   //  logic ScalarMemRead;
    logic [N-1:0] write_scalar_data;
    logic [N-1:0] scalar_data_read;

    // Result
    logic [N-1:0] Result;
    

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
		// rst = x;
		pwr = 1;
		dbg = 1;
		stp = 1;

        $monitor("*** Processor Signals: ***\n",
                 "PC Address\n",
                    "next_pc_address = %b (%h)\n", next_pc_address, next_pc_address,
                    "pc_address = %b (%h)\n", pc_address, pc_address,
                 "Instruction\n",
                    "instruction = %b (%h)\n", instruction, instruction,
                    "Opcode = %b (%h)\n", Opcode, Opcode,
                    "V = %b (%h)\n", V, V,
                    "Rd = %b (%h)\n", Rd, Rd,
                    "Rs = %b (%h)\n", Rs, Rs,
                    "Rt = %b (%h)\n", Rt, Rt,
                    "Funct = %b (%h)\n", Funct, Funct,
                    //"InstImmediate = %b (%h)\n", InstImmediate, InstImmediate,
                    "InstAddress = %b (%h)\n", InstAddress, InstAddress,
                 "Registers\n",
                    "e0_reg = %b (%h)\n", e0_reg, e0_reg,
                    "e1_reg = %b (%h)\n", e1_reg, e1_reg,
                    "e2_reg = %b (%h)\n", e2_reg, e2_reg,
                    "e3_reg = %b (%h)\n", e3_reg, e3_reg,
                    "e4_reg = %b (%h)\n", e4_reg, e4_reg,
                    "e5_reg = %b (%h)\n", e5_reg, e5_reg,
                    "e6_reg = %b (%h)\n", e6_reg, e6_reg,
                    "pc_reg = %b (%h)\n", pc_reg, pc_reg,
                 "Control Unit\n",
                    "PCSrc = %b (%h)\n", PCSrc, PCSrc,
                    "MemtoReg = %b (%h)\n", MemtoReg, MemtoReg,
                    "MemWrite = %b (%h)\n", MemWrite, MemWrite,
                    "ALUControl = %b (%h)\n", ALUControl, ALUControl,
                    "ALUSrc = %b (%h)\n", ALUSrc, ALUSrc,
                    "ImmSrc = %b (%h)\n", ImmSrc, ImmSrc,
                    "RegWrite = %b (%h)\n", RegWrite, RegWrite,
                 "Extend\n",
                    "ExtImm = %b (%h)\n", ExtImm, ExtImm,
                 "ALU\n",
                    "alu_SrcA = %b\n", alu_SrcA,
                    "alu_SrcB = %b\n", alu_SrcB,
                    "shamt = %b (%h)\n", shamt, shamt,
                    "ALUFlags = %b (%h)\n", ALUFlags, ALUFlags,
                    "alu_scalar_result = %b (%h)\n", alu_scalar_result, alu_scalar_result,
                 "Memory\n",
                  //   "InstructionMemRead = %b \n", InstructionMemRead,
                  //   "ScalarMemRead = %b \n", ScalarMemRead,
                    "write_scalar_data = %b (%h)\n", write_scalar_data, write_scalar_data,
                    "scalar_data_read = %b (%h)\n", scalar_data_read, scalar_data_read,
                 "Result\n",
                    "Result = %b (%h)\n", Result, Result);
   end

   always begin
   	  #50 clk = !clk;
      // PC Address
	  await = uut.asip.await;
	  pc_enable = uut.asip.pc_enable;
      next_pc_address = uut.asip.next_pc_address;
      pc_address = uut.pc_address;
      // Instruction
      instruction = uut.asip.instruction;
      Opcode = uut.asip.Opcode;
      V = uut.asip.V;
      Rd = uut.asip.Rd;
      Rs = uut.asip.Rs;
      Rt = uut.asip.Rt;
      Funct = uut.asip.Funct;
      //InstImmediate = uut.asip.InstImmediate;
      InstAddress = uut.asip.InstAddress;
      //Registers
      e0_reg = uut.asip.reg_file.reg_array[8];
      e1_reg = uut.asip.reg_file.reg_array[9];
      e2_reg = uut.asip.reg_file.reg_array[10];
      e3_reg = uut.asip.reg_file.reg_array[11];
      e4_reg = uut.asip.reg_file.reg_array[12];
      e5_reg = uut.asip.reg_file.reg_array[13];
      e6_reg = uut.asip.reg_file.reg_array[14];
      pc_reg = uut.asip.reg_file.reg_array[15];
      // Control Unit
      PCS = uut.asip.cont_unit.PCS;
      RegW = uut.asip.cont_unit.RegW;
      MemW = uut.asip.cont_unit.MemW;
      CondEx = uut.asip.cont_unit.cond_logic.CondEx;
      PCSrc = uut.asip.PCSrc;
      MemWrite = uut.asip.MemWrite;
      RegWrite = uut.asip.RegWrite;
      MemtoReg = uut.asip.MemtoReg;
      next_PCSrc = uut.asip.cont_unit.cond_logic.next_PCSrc;
      next_MemWrite = uut.asip.cont_unit.cond_logic.next_MemWrite;
      next_RegWrite = uut.asip.cont_unit.cond_logic.next_RegWrite;
      ImmSrc = uut.asip.ImmSrc;
      ALUSrc = uut.asip.ALUSrc;
      ALUControl = uut.asip.ALUControl;
      // Extend
      ExtImm = uut.asip.ExtImm;
      // ALU
      alu_SrcA = uut.asip.SrcA;
      alu_SrcB = uut.asip.SrcB;
      shamt = uut.asip.alu_scalar.shamt;
      ALUFlags = uut.asip.ALUFlags;
      alu_scalar_result = uut.asip.alu_scalar_result;
      // Memory
   //   InstructionMemRead = uut.full_memory.InstructionMemRead; 
   //   ScalarMemRead = uut.full_memory.ScalarMemRead;
      write_scalar_data = uut.asip.data_addr_2; 
      scalar_data_read = uut.asip.read_scalar_data;
      // Result
      Result = uut.asip.Result;
   end

   initial	begin

      #200

      //$display("Instruction read, no data read, no data write\n");

      pwr <= 0;

      #300
      
      pwr <= 1;
      // rst <= 0;

      #300;

      // rst = 1;

      // #100;

   // Done

   end

   initial
   #3000 $finish;                                 

endmodule
