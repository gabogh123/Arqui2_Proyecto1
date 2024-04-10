/*
Modulo para instancias alu escalar normal y de punto fijo
Date: 7/04/24
HACER TESTBENCH 
*/

`timescale 1 ps / 100 fs

module alus #(parameter N = 24)(
        input [N-1:0]           A,
        input [N-1:0]           B,
        input [2:0]    ALUControl,

        output [N-1:0]     result,
        output [3:0]        flags
);

alu #(N) scalar_alu(.A(A),
                    .B(B),
                    .ALUControl(ALUControl),
                    .result(result),
                    .flags(flags)
);

alu #(N) scalar_alu_fp(.A(A),
                       .B(B),
                       .ALUControl(ALUControl),
                       .result(result),
                       .flags(flags)
);

endmodule