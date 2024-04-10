/*
Test Bench para modulo extend 
*/

module extend_v2_tb;

parameter  N = 24;

reg [18:0] A;
reg [1:0] ImmSrc;

wire [N-1:0] ExtImm;

extend_v2 #(#) uut(.A(A),
                   .ImmSrc(ImmSrc),
                   .ExtImm(ExtImm));


initial  begin
    $display("Extend module testbench")

    A <= 18'b0;
    ImmSrc <= 2'b00;

    $monitor("A=%b ImmSrc=%b\n", A, ImmSrc,
             "ExtImm=%b\n", ExtImm);
end

initial begin

    #100
    A <= 18'b1;
    ImmSrc <= 2'b00;

    $monitor("A=%b ImmSrc=%b\n", A, ImmSrc,
             "ExtImm=%b\n", ExtImm);

    #100

end

initial begin

    #100
    A <= 18'b1;
    ImmSrc <= 2'b01;

    $monitor("A=%b ImmSrc=%b\n", A, ImmSrc,
             "ExtImm=%b\n", ExtImm);

    #100

end

initial begin

    #100
    A <= 18'b1;
    ImmSrc <= 2'b11;

    $monitor("A=%b ImmSrc=%b\n", A, ImmSrc,
             "ExtImm=%b\n", ExtImm);

    #100

end

endmodule