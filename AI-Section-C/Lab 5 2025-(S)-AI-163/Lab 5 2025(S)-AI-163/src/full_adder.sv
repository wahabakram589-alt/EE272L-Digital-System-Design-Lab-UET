module full_adder (
    input logic a, b, c,    
    output logic sum, carry
);
    logic w1, w2, w3;
    xor g1 (sum, a, b, c);
    and a1 (w1, a, b);
    and a2 (w2, b, c);
    and a3 (w3, a, c);
    or  o1 (carry, w1, w2, w3);
endmodule

module ripple_carry (
    input  logic [3:0] a, b,
    input  logic c_in,
    output logic [3:0] sum,
    output logic c_out
);
    logic c1, c2, c3;

    full_adder FA0 (a[0], b[0], c_in, sum[0], c1);
    full_adder FA1 (a[1], b[1], c1,   sum[1], c2);
    full_adder FA2 (a[2], b[2], c2,   sum[2], c3);
    full_adder FA3 (a[3], b[3], c3,   sum[3], c_out);
endmodule