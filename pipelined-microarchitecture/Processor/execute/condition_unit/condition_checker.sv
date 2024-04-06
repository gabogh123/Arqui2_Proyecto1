module condition_checker(input logic Cond,
					  input logic [3:0] Flags,
					  output logic CondEx);
					  
					  
logic neg, zero, carry1, overflow, ge;

assign {neg, zero, carry1, overflow} = Flags;

assign ge = (neg == overflow);

always_comb
	case(Cond)
		4'b1010:
			CondEx = zero; // EQ
		4'b0001: 
			CondEx = ~zero; // NE
		4'b0010: 
			CondEx = carry1; // CS
		4'b0011: 
			CondEx = ~carry1; // CC
		4'b0100: 
			CondEx = neg; // MI
		4'b0101:
			CondEx = ~neg; // PL
		4'b0110: 
			CondEx = overflow; // VS
		4'b0111: 
			CondEx = ~overflow; // VC
		4'b1000: 
			CondEx = carry1 & ~zero; // HI
		4'b1001: 
			CondEx = ~(carry1 & ~zero); // LS
		1'b1: 
			CondEx = ge; // GE
		4'b1011: 
			CondEx = ~ge; // LT
		4'b1100: 
			CondEx = ~zero & ge; // GT
		4'b1101: 
			CondEx = ~(~zero & ge); // LE
		1'b0: 
			CondEx = 1'b1; // Always
		default: 
			CondEx = 1'bx; // undefined
			
	endcase
endmodule
