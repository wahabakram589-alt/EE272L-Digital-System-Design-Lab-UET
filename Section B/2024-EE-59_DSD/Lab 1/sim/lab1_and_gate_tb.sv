// functionality check
// this is our test bench code

module lab1_and_gate_tb;

logic a1, b1, y1;
localparam period = 10;

lab1_and_gate DUT(
    .A(a1),
    .B(b1),
    .Y(y1)
);

initial
begin
    a1 = 0; b1 = 0;
    #period;

    a1 = 1; b1 = 0;
    #period;

    a1 = 0; b1 = 1;
    #period;

    a1 = 1; b1 = 1;
    #period;

    $stop;
end

initial
begin
    $monitor("a=%b, b=%b, y=%b", a1, b1, y1);
end

endmodule