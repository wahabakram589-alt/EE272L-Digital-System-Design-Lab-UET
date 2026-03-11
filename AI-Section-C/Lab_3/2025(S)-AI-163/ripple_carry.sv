/*
  Module: ripple_carry
  Description: Cascades three 1-bit Full Adders to create a 3-bit Ripple Carry Adder.
*/
module ripple_carry (
    input  logic [2:0] a,      
    input  logic [2:0] b,      
    input  logic       c_in,   
    output logic [2:0] sum,    
    output logic       c_out   
);

    // Internal wires to propagate the carry 
    wire c1, c2;

    // Stage 0: 
    full_adder FA0 (
        .a(a[0]),
        .b(b[0]),
        .c(c_in),
        .sum(sum[0]),
        .carry(c1)
    );

    // Stage 
    full_adder FA1 (
        .a(a[1]),
        .b(b[1]),
        .c(c1),
        .sum(sum[1]),
        .carry(c2)
    );

    // Stage 2: MSB 
    full_adder FA2 (
        .a(a[2]),
        .b(b[2]),
        .c(c2),
        .sum(sum[2]),
        .carry(c_out)
    );

endmodule