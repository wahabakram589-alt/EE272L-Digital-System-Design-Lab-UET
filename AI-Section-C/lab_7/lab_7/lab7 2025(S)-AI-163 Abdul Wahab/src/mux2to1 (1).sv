module mux2to1 (
    input  logic x, y,
    input  logic sel,
    output logic z
);

always_comb begin
    if (sel == 0)
        z = x;
    else
        z = y;
end

endmodule