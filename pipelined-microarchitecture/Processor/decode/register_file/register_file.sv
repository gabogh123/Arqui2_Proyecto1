/*
Register File for N bits
Date: 16/03/24
*/
`timescale 1 ps / 100 fs
module register_file # (parameter N = 24) (
		input  logic         clk,
		input  logic         rst,
		input  logic [3:0]   A1,      // reg_read_addr_1
		input  logic [3:0]   A2,      // reg_read_addr_2
		input  logic [3:0]   A3,      // reg_write_dest address
		input  logic [N-1:0] WD3,     // reg_write_data data
		input  logic [N-1:0] R15,     // reg_write_r15
		input  logic         WE3,     // reg_write_en

		output logic [N-1:0] RD1,     // reg_read_data_1
		output logic [N-1:0] RD2      // reg_read_data_2 
	);

	logic [N-1:0] reg_array [15:0];

	always @ (posedge clk or posedge rst) begin

		if(rst) begin  
			reg_array[0]  <= 24'h00000;  // zero
			reg_array[1]  <= 24'hDE000;  // sp
			reg_array[2]  <= 24'h0;      // lr
			reg_array[3]  <= 24'h0;      // cpsr
			reg_array[4]  <= 24'h0;      // r0
			reg_array[5]  <= 24'h0;      // r1
			reg_array[6]  <= 24'h0;      // r2
			reg_array[7]  <= 24'h0;      // r3
			reg_array[8]  <= 24'h0;      // e0
			reg_array[9]  <= 24'h0;      // e1
			reg_array[10] <= 24'h0;      // e2
			reg_array[11] <= 24'h0;      // e3
			reg_array[12] <= 24'h0;      // e4
			reg_array[13] <= 24'h0;      // e5
			reg_array[14] <= 24'h0;      // e6
			reg_array[15] <= 24'h0;      // pc       
		end
		else begin  
			if(WE3) begin  
				reg_array[A3] <= WD3; 
				reg_array[15] = R15; /* Writes PCPlus8 on reg 15 always */
			end  
		end
		
	end 

	assign RD1 = (A1 == 0) ? 24'b0 : reg_array[A1]; // if reg == $zero -> return 0 
	assign RD2 = (A2 == 0) ? 24'b0 : reg_array[A2]; // if reg == $zero -> return 0 

endmodule
