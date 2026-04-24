module debouncer_c(
    input logic pulse,
    input logic sync_sig,
    input logic clk,
    output logic swt_out
);

logic enable;
logic reset;
logic [3:0] counter_sc;

not n1(reset, sync_sig);
and a1(enable, pulse, sync_sig);

saturated_c sc(
    .clk(clk),
    .reset(reset),
    .enable(enable),     // ✅ now used properly
    .counter(counter_sc)
);

assign swt_out = (counter_sc == 4'd15);

endmodule