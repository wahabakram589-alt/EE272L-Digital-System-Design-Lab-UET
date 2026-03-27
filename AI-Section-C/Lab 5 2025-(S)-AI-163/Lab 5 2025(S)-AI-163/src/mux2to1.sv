module mux2to1 (
    input  logic i0, i1, sel,
    output logic y
);
    assign y = sel ? i1 : i0;
endmodule