// Modulo extend para obtener señal ImmSrc

module extend()(

		input [2:0] Opcode,
		input Vec,

		output [1:0] ImmSrc
);

assign ov = {Opcode,Vec}

if(Opcode == 3'b000) //Instrucciones tipo R

	assign ImmSrc = 2'bXX;

else

	begin
		
		if(ov=4'b1111) //branch

			assign ImmSrc = 2'b01;

		else

			assign ImmSrc = 2'b00;
	end
