/*
Condition Checker testbench
Date: 20/03/24
*/

module condition_checker_tb;

	logic [2:0] opcode;
	logic		N;
	logic		Z;
	logic		C;
	logic		V;
	logic		condEx;


	condition_checker uut (.opcode(opcode),
						   .N(N),
						   .Z(Z),
						   .C(C),
						   .V(V),
						   .condEx(condEx));

	initial begin

		$display("condition_checker testbench: \n");

		opcode <= 3'b111;
		Z <= 1'b0;
		N <= 1'b0;
		C <= 1'b0;
		V <= 1'b0;

		$monitor("\nopcode=%b\n", opcode,
                 "N=%b Z=%b C=%b V=%b\n", N, Z, C, V,
                 "condEx=%b", condEx);
	end

	initial begin

		// Testing equal condition
		
		#100
		$display("Equal");
		opcode = 3'b011;
		N = 0;
		Z = 1;
		C = 0;
		V = 0;

		#100

		$monitor("\nopcode=%b\n", opcode,
                 "N=%b Z=%b C=%b V=%b\n", N, Z, C, V,
                 "condEx=%b", condEx);
		
	
		label1: assert (condEx===1)
			else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);
		
		// Testing not equal condition

		#100
		$display("Not Equal 1");
		opcode = 3'b100;
		N = 0;
		Z = 0;
		C = 0;
		V = 0;

		#100

		$monitor("\nopcode=%b\n", opcode,
                 "N=%b Z=%b C=%b V=%b\n", N, Z, C, V,
                 "condEx=%b", condEx);
		
		label2: assert (condEx===1)
			else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		#100
		$display("Not Equal 2");
		opcode = 3'b100;
		N = 1;
		Z = 1;
		C = 1;
		V = 1;

		#100

		$monitor("\nopcode=%b\n", opcode,
                 "N=%b Z=%b C=%b V=%b\n", N, Z, C, V,
                 "condEx=%b", condEx);
		
		label3: assert (condEx===0)
			else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		
		// Testing signed less than condition

		#100

		$display("Signed Less than 1");
		opcode = 3'b110;
		N = 1;
		Z = 0;
		C = 1;
		V = 0;

		#100

		assert ((condEx === 1)) 
		else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		#100

		$display("Signed Less than 2");
		opcode = 3'b110;
		N = 0;
		Z = 1;
		C = 1;
		V = 0;

		#100

		assert ((condEx === 0)) 
		else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		//Testing greater than condition


		 #100

		$display("Signed Greater than 1");
		opcode = 3'b101;
		N = 1;
		Z = 0;
		C = 0;
		V = 1;

			#100

		assert ((condEx === 1)) 
		else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		#100

		$display("Signed Greater than 2");
		opcode = 4'b1100;
		N = 1;
		Z = 1;
		C = 1;
		V = 1;

		#100

		assert ((condEx === 0)) 
		else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		#100

		// Testing Always condition

		#100

		$display("Always 1");
		opcode = 4'b1111;
		N = 0;
		Z = 0;
		C = 0;
		V = 0;

		#100

		assert ((condEx === 1)) 
		else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		#100

		$display("Always");
		opcode = 4'b1111;
		N = 1;
		Z = 1;
		C = 1;
		V = 1;

		#100

		assert ((condEx === 1)) 
		else $error("Failed @ opcode=%b N=%b Z=%b C=%b V=%b", opcode, N, Z, C, V);

		#100;

	end

endmodule
