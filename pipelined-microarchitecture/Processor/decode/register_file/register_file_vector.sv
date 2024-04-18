/*
Register File Vector for N (256) bits
Date: 17/04/24
*/
`timescale 1 ps / 100 fs
module register_file_vector # (parameter N = 256) (
		input  logic         clk,
		input  logic         rst,
		input  logic [3:0]   A1,      // reg_read_addr_1
		input  logic [3:0]   A2,      // reg_read_addr_2
		input  logic [3:0]   A3,      // reg_write_dest address
		input  logic [N-1:0] WD3,     // reg_write_data data
		input  logic         WE3,     // reg_write_en

		output logic [N-1:0] RD1,     // reg_read_data_1
		output logic [N-1:0] RD2      // reg_read_data_2
	);

	logic [N-1:0] reg_array [7:0];

	always @ (posedge clk or posedge rst) begin

		if(rst) begin
			reg_array[0] <= 256'h0;
			reg_array[1] <= 256'h0;
			reg_array[2] <= 256'h0;
			reg_array[3] <= 256'h0;
			reg_array[4] <= 256'h0;
			reg_array[5] <= 256'h0;
			reg_array[6] <= 256'h0;
			reg_array[7] <= 256'h0;
		end
		else begin
			if(WE3) begin
				reg_array[A3] <= WD3;
			end
		end
	end

    assign RD1 = reg_array[A1];
    assign RD2 = reg_array[A2];

endmodule
