/*
Address Generator
*/
module address_generator(
		input logic [31:0] address,
		output logic [31:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15
	);		

	assign a0 = address;
	assign a1 = address + 1;
	assign a2 = address + 2;
	assign a3 = address + 3;
	assign a4 = address + 4;
	assign a5 = address + 5;
	assign a6 = address + 6;
	assign a7 = address + 7;
	assign a8 = address + 8;
	assign a9 = address + 9;
	assign a10 = address + 10;
	assign a11 = address + 11;
	assign a12 = address + 12;
	assign a13 = address + 13;
	assign a14 = address + 14;
	assign a15 = address + 15;

endmodule
