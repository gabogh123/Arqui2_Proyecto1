/*
RAM Vector
*/
module ram_vector (
		input  logic [31:0]  address,
		input  logic 		 clock,
		input  logic [255:0] data,
		input  logic 		 wren,
		
		output logic [255:0] q
	);

	logic [31:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;

	address_generator add_gen (address,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15);

	vector_memory vec_mem (clock,wren,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,data,q);

endmodule
