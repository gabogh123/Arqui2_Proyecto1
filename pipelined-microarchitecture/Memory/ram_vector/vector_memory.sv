/*
Vector Memory
*/
module vector_memory(
		input  logic clk,
		input  logic wren,
		input  logic [31:0] a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15, 
		input  logic [255:0] write_data,
		
		output logic [255:0] read_data
	);
				
	logic [15:0] RAM [31:0];	

	initial $readmemh("../../Memory/ram_vector/ram_vector.txt", RAM);

	always_ff @ (posedge clk) begin
		if (wren) begin 
			RAM[a] <= write_data[15:0];
			RAM[a1] <= write_data[31:16];
			RAM[a2] <= write_data[47:32];
			RAM[a3] <= write_data[63:48];
			RAM[a4] <= write_data[79:64];
			RAM[a5] <= write_data[95:80];
			RAM[a6] <= write_data[111:96];
			RAM[a7] <= write_data[127:112];
			RAM[a8] <= write_data[143:128];
			RAM[a9] <= write_data[159:144];
			RAM[a10] <= write_data[175:160];
			RAM[a11] <= write_data[191:176];
			RAM[a12] <= write_data[207:192];
			RAM[a13] <= write_data[223:208];
			RAM[a14] <= write_data[239:224];
			RAM[a15] <= write_data[255:240];
		end
	end

	assign read_data[15:0] = RAM[a];
	assign read_data[31:16] = RAM[a1];
	assign read_data[47:32] = RAM[a2];	
	assign read_data[63:48] = RAM[a3];	
	assign read_data[79:64] = RAM[a4];
	assign read_data[95:80] = RAM[a5];	
	assign read_data[111:96] = RAM[a6];	
	assign read_data[127:112] = RAM[a7];
	assign read_data[143:128] = RAM[a8];	
	assign read_data[159:144] = RAM[a9];	
	assign read_data[175:160] = RAM[a10];	
	assign read_data[191:176] = RAM[a11];	
	assign read_data[207:192] = RAM[a12];	
	assign read_data[223:208] = RAM[a13];
	assign read_data[239:224] = RAM[a14];	
	assign read_data[255:240] = RAM[a15];	

endmodule
