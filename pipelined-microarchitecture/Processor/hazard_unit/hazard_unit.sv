/*
Hazard Unit module
Data: 06/10/24
*/
module hazard_unit(
		input  logic [2:0] RA1E,
		input  logic [2:0] RA2E,
		input  logic [2:0] WA3M,
		input  logic [2:0] WA3W,
		input  logic [2:0] RA1D,
		input  logic [2:0] RA2D,
		input  logic [2:0] WA3E,
		input  logic RegWriteM,
		input  logic RegWriteW,
		input  logic MemtoRegE,
		input  logic PCSrcD,
		input  logic PCSrcE,
		input  logic PCSrcM,
		input  logic PCSrcW,
		input  logic BranchTakenE,
		
		output logic [1:0] ForwardAE,
		output logic [1:0] ForwardBE,
		output logic StallF,
		output logic StallD,
		output logic FlushE,
		output logic FlushD
	);

	logic Match_12D_E;
	logic LDRstall;
	logic PCWrPendingF;

	// Forward memory
	assign Match_12D_E = ((RA1D == WA3E) || (RA2D == WA3E));

	assign LDRstall = Match_12D_E && MemtoRegE;
	
	assign PCWrPendingF = PCSrcD || PCSrcE || PCSrcM;
	assign StallD = LDRstall;
	assign StallF = LDRstall || PCWrPendingF;
	assign FlushE = LDRstall || BranchTakenE;
	assign FlushD = PCWrPendingF || PCSrcW || BranchTakenE;

	always_comb  begin

		//Forward register A
		if(RA1E == WA3M && RegWriteM) begin
		ForwardAE = 2'b10;
		end

		else if(RA1E == WA3W && RegWriteW) begin
		ForwardAE = 2'b01;
		end

		else begin
		ForwardAE = 2'b00;
		end


		// Forward register B
		if (RA2E == WA3M && RegWriteM) begin
		ForwardBE = 2'b10 ;
		end

		else if (RA2E == WA3W && RegWriteW) begin
		ForwardBE = 2'b01;
		end

		else begin
		ForwardBE = 2'b00;
		end

	end

endmodule
