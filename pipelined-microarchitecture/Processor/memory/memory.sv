module memory (input logic clk, clock_img,
					input logic PCSrcM, RegWriteM, MemtoRegM, MemWriteM,
					input logic [31:0] ALUResultM, WriteDataM,
					input logic [2:0] WA3M,
					input logic [15:0] ImgAddr,
					input logic PCSrcMV, RegWriteMV, MemtoRegMV, MemWriteMV,
					input logic [255:0] ALUResultMV, WriteDataMV,
					input logic [2:0] WA3MV,
					input logic [15:0] ImgAddrV,
					output logic PCSrcW, RegWriteW, MemtoRegW,
					output logic [31:0] ReadDataW, ALUOutW, ALUOutM, ImgData,
					output logic [2:0] WA3W,
					output logic PCSrcWV, RegWriteWV, MemtoRegWV,
					output logic [255:0] ReadDataWV, ALUOutWV, ALUOutMV, ImgDataV,
					output logic [2:0] WA3WV);

	logic [31:0] MemOut;
	
	logic wren_b;
	logic [31:0] data_b;
	assign wren_b = 0;
	assign data_b = 32'b0;
	
	
	//Aqui va la RAM lol
	
	

endmodule