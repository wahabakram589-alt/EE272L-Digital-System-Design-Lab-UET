module full_adder(
    input  logic A,
    input  logic B,
    input  logic Cin,
    output logic Sum,
    output logic Cout

);


logic g2,h2,i2;

xor (Sum, A,B, Cin);


and (g2, A,B);
and (h2, A, Cin);
and (i2, B, Cin);

or (Cout, g2, h2, i2);


endmodule