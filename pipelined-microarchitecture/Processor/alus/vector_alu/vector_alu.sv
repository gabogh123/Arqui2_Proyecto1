/*
ALU vectorial parametrizable para N
Date: 7/04/24
HACER TESTBENCH
*/
`timescale 1 ps / 100 fs
module vector_alu #(parameter N = 24)(
        input [N-1:0]           A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,
        input [N-1:0]           B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,
        input [2:0]             ALUControl,

        output [N-1:0]          result1,result2,result3,result4,result5,result6,result7,result8,
                                result9,result10,result11,result12,result13,result14,result15,result16,
        output [3:0]            flags
);

alus #(N) vector_alu1(.A(A1),
                      .B(B1),
                      .ALUControl(ALUControl),
                      .result(result1),
                      .flags(flags)
);

alus #(N) vector_alu2(.A(A2),
                      .B(B2),
                      .ALUControl(ALUControl),
                      .result(result2),
                      .flags(flags)
);

alus #(N) vector_alu3(.A(A3),
                      .B(B3),
                      .ALUControl(ALUControl),
                      .result(result3),
                      .flags(flags)
);

alus #(N) vector_alu4(.A(A4),
                      .B(B4),
                      .ALUControl(ALUControl),
                      .result(result4),
                      .flags(flags)
);

alus #(N) vector_alu5(.A(A5),
                      .B(B5),
                      .ALUControl(ALUControl),
                      .result(result5),
                      .flags(flags)
);

alus #(N) vector_alu6(.A(A6),
                      .B(B6),
                      .ALUControl(ALUControl),
                      .result(result6),
                      .flags(flags)
);

alus #(N) vector_alu7(.A(A7),
                      .B(B7),
                      .ALUControl(ALUControl),
                      .result(result7),
                      .flags(flags)
);

alus #(N) vector_alu8(.A(A8),
                      .B(B8),
                      .ALUControl(ALUControl),
                      .result(result8),
                      .flags(flags)
);

alus #(N) vector_alu9(.A(A9),
                      .B(B9),
                      .ALUControl(ALUControl),
                      .result(result9),
                      .flags(flags)
);

alus #(N) vector_alu10(.A(A10),
                       .B(B10),
                       .ALUControl(ALUControl),
                       .result(result10),
                       .flags(flags)
);

alus #(N) vector_alu11(.A(A11),
                       .B(B11),
                       .ALUControl(ALUControl),
                       .result(result11),
                       .flags(flags)
);

alus #(N) vector_alu12(.A(A12),
                       .B(B12),
                       .ALUControl(ALUControl),
                       .result(result12),
                       .flags(flags)
);

alus #(N) vector_alu13(.A(A13),
                       .B(B13),
                       .ALUControl(ALUControl),
                       .result(result13),
                       .flags(flags)
                      );

alus #(N) vector_alu14(.A(A14),
                       .B(B14),
                       .ALUControl(ALUControl),
                       .result(result14),
                       .flags(flags)
);

alus #(N) vector_alu15(.A(A15),
                       .B(B15),
                       .ALUControl(ALUControl),
                       .result(result15),
                       .flags(flags)
);

alus #(N) vector_alu16(.A(A16),
                       .B(B16),
                       .ALUControl(ALUControl),
                       .result(result16),
                       .flags(flags)
);

endmodule
