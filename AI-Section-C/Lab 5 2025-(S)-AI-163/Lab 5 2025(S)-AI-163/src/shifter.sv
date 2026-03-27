module shifter (
    input  logic [3:0] x,
    input  logic [1:0] shift_amt,
    output logic [3:0] y
);
    logic [3:0] L1;

    // Layer 1 (Controlled by S1 - Shift by 2)
    mux2to1 m1_0 (.i0(x[0]), .i1(1'b0), .sel(shift_amt[1]), .y(L1[0]));
    mux2to1 m1_1 (.i0(x[1]), .i1(1'b0), .sel(shift_amt[1]), .y(L1[1]));
    mux2to1 m1_2 (.i0(x[2]), .i1(x[0]), .sel(shift_amt[1]), .y(L1[2]));
    mux2to1 m1_3 (.i0(x[3]), .i1(x[1]), .sel(shift_amt[1]), .y(L1[3]));

    // Layer 2 (Controlled by S0 - Shift by 1)
    mux2to1 m0_0 (.i0(L1[0]), .i1(1'b0),  .sel(shift_amt[0]), .y(y[0]));
    mux2to1 m0_1 (.i0(L1[1]), .i1(L1[0]), .sel(shift_amt[0]), .y(y[1]));
    mux2to1 m0_2 (.i0(L1[2]), .i1(L1[1]), .sel(shift_amt[0]), .y(y[2]));
    mux2to1 m0_3 (.i0(L1[3]), .i1(L1[2]), .sel(shift_amt[0]), .y(y[3]));
endmodule