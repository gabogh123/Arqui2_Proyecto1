module vectmem(input logic clk,we,
				input logic [31:0] a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15, 
				input logic [255:0]wd,
				output logic [255:0] rd
				// output logic [15:0] RAMout[2047:0]
				);
				
	logic [15:0] RAM[2047:0];	

	//assign RAMout = RAM;

initial $readmemh("G:/Documentos/S2024/Arqui/MemoriaVectorial/imemory.memh",RAM);


	always_ff @(posedge clk) begin
		if (we) begin 
			RAM[a] <= wd[15:0];
			RAM[a1] <= wd[31:16];
			RAM[a2] <= wd[47:32];
			RAM[a3] <= wd[63:48];
			RAM[a4] <= wd[79:64];
			RAM[a5] <= wd[95:80];
			RAM[a6] <= wd[111:96];
			RAM[a7] <= wd[127:112];
			RAM[a8] <= wd[143:128];
			RAM[a9] <= wd[159:144];
			RAM[a10] <= wd[175:160];
			RAM[a11] <= wd[191:176];
			RAM[a12] <= wd[207:192];
			RAM[a13] <= wd[223:208];
			RAM[a14] <= wd[239:224];
			RAM[a15] <= wd[255:240];
		end
	end


assign	 rd[15:0] = RAM[a];
assign	 rd[31:16] = RAM[a1];
assign	 rd[47:32] = RAM[a2];	
assign	 rd[63:48] = RAM[a3];	
assign	 rd[79:64] = RAM[a4];
assign	 rd[95:80] = RAM[a5];	
assign	 rd[111:96] = RAM[a6];	
assign	 rd[127:112] = RAM[a7];
assign	 rd[143:128] = RAM[a8];	
assign	 rd[159:144] = RAM[a9];	
assign	 rd[175:160] = RAM[a10];	
assign	 rd[191:176] = RAM[a11];	
assign	 rd[207:192] = RAM[a12];	
assign	 rd[223:208] = RAM[a13];
assign	 rd[239:224] = RAM[a14];	
assign	 rd[255:240] = RAM[a15];	

endmodule