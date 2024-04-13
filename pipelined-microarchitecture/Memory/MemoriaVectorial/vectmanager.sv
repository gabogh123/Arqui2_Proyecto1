module vectmanager(input logic clk,we,
						 input logic [31:0] a,
						 input logic [255:0]wd,
						 output logic [255:0] rd

);

logic [31:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;

addressgen gen(a,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15);

vectmem mem(clk,we,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,wd,rd);


endmodule