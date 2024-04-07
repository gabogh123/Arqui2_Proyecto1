/*
Processor Module
Date: 07/04/24
*/
module pipelined_processor # (parameter N = 24) (
        input  logic			clk,
		input  logic			rst,
		input  logic			en,

        input  logic [N-1:0] instruction,       // RD from instruction memory
        input  logic [N-1:0] read_scalar_data,  // RD from data memory

        output logic [N-1:0] pc_address,        // to A from instruction memory
        output logic MemWrite,                  // ScalarMemWrite from Data memory
        output logic [N-1:0] alu_scalar_result, // to A from, data memory
        output logic [N-1:0] write_scalar_data  // to WD (write_scalar_data) from data memory
    );

    /* wires */

    wire [N-1:0] next_pc_address;

    wire         PCSrc;

	wire [N-1:0] PCPlus4;
	wire [N-1:0] PCPlus8;

	wire		 RegWrite;
	wire  [1:0]	 ImmSrc;
	wire     	 ALUSrc;
	wire  [2:0]  ALUControl;
	wire 		 MemtoReg;

    wire [N-1:0] data_addr_2;

	wire [N-1:0] SrcA;
	wire [N-1:0] SrcB;

	wire [N-1:0] ExtImm;

	wire  [3:0]	 ALUFlags;
    wire [N-1:0] ALUResult;

	wire [N-1:0] Result;


    /* Instructions */

    logic [2:0] Opcode;
    logic       V;

    logic [3:0] Rd;
    logic [3:0] Rs;
    logic [3:0] Rt;

    logic [4:0] Shamt;
    logic [2:0] Funct;

    logic [11:0] InstImmediate;
    logic [19:0] InstAddress;

    assign Opcode = instruction[23:21];
    assign V = instruction[20];

    assign Rd = instruction[19:16];
    assign Rs = instruction[15:12];
    assign Rt = instruction[11:8];

    //assign Shamt = instruction[7:3];
    assign Funct = instruction[2:0];
    
    //assign InstImmediate = instruction[11:0];
    assign InstAddress = instruction[19:0];


    /* module's instances */

    /* PC_MUX */
	mux_2NtoN # (.N(N)) pc_mux (.I0(PCPlus4),
								.I1(Result),
								.rst(rst),
								.S(PCSrc),
								.enable(1'b1),
								.O(next_pc_address));

	logic await;

	counter # (.MAX_VALUE(2)) wait_count (.clk(clk),
										  .rst(rst),
										  .count(await));

	logic pc_enable;

	always @ (posedge clk) begin
		if (await)
			pc_enable = 1;
	end

    /* PC Register */ /* tb ready */
	register_v2 # (.N(N)) program_counter (.clk(clk),
										   .rst(rst),
										   .D(next_pc_address),
										   .en(en & pc_enable),
										   .Q(pc_address));

    /* PCPlus4_Adder */
	single_adder # (.N(N)) pc_plus_4_adder (.A(pc_address),
									  		.B(24'b01),
									  		.Y(PCPlus4));

    /* Control_Unit */ // HACER TESTBENCHES
	control_unit cont_unit (.clk(clk),
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

    /* PCPlus8_Adder */
	single_adder # (.N(N)) pc_plus_8_adder (.A(PCPlus4),
									  		.B(24'b10),
									  		.Y(PCPlus8));

    /* Register File */ //HACER TESTBENCH
	register_file  # (.N(N)) reg_file (.clk(clk),
							.rst(rst),
							.reg_write_data(Result),
							.reg_read_addr_1(Rs),
							.reg_read_addr_2(Rt),
							.reg_write_dest(Rd),
							.reg_write_en(RegWrite),
                            .reg_write_r15(PCPlus8),
							.reg_read_data_1(SrcA),
							.reg_read_data_2(data_addr_2));

    /* Write to WD on Data Memory */
    assign write_scalar_data = data_addr_2;

    /* Extend */
	extend # (.N(N)) extender (.A(InstAddress),
							   .ImmSrc(ImmSrc),
						   	   .ExtImm(ExtImm));

    /* ALUSrcB_MUX */
	mux_2NtoN # (.N(N)) src_b_mux (.I0(data_addr_2),
								   .I1(ExtImm),
								   .rst(rst),
								   .S(ALUSrc),
								   .enable(1'b1),
								   .O(SrcB));

    /* ALU Scalar */ // HACER TESTBENCH
	alu # (.N(N)) alu_scalar (.A(SrcA),
                              .B(SrcB),
                              .ALUControl(ALUControl),
                              .result(alu_scalar_result),
                              .flags(ALUFlags));

    /* Data_MUX */
    mux_2NtoN # (.N(N)) data_mux (.I0(alu_scalar_result),
                                  .I1(read_scalar_data),
                                  .rst(rst),
                                  .S(MemtoReg),
                                  .enable(1'b1),
                                  .O(Result));

endmodule
