module full_adder(
    input  a, b, c,
    output logic sum,carry

);
logic  a1,b1,c1,d1,e ;
xor g1(sum,A,B,Cin);
and g2(a1,A,B);
and g3(b1,A,Cin);
and g4(c1,B,Cin);

or g5(carry, a1, b1, c1);
endmodule
