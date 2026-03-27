module multiplier (
    input  logic [3:0] X,
    output logic [6:0] seg_out 
);
    logic [3:0] s0_out, s1_out, P_internal;
    logic carry_dummy;

    // Shifters
    shifter sh0 (.x(X), .shift_amt(2'b01), .y(s0_out));
    shifter sh1 (.x(X), .shift_amt(2'b00), .y(s1_out));

    // Adder (Calculating X*3)
    ripple_carry adder_inst (
        .a(s0_out), 
        .b(s1_out), 
        .c_in(1'b0), 
        .sum(P_internal), 
        .c_out(carry_dummy)
    );

    // Decoder (Displaying X*3)
    seven_seg_decoder display_unit (
        .bin_in(P_internal),
        .seg(seg_out)
    );

endmodule