module top_module(
    input  logic clk,          // FPGA clock (100/125 MHz)
    input  logic reset,        // global reset
    input  logic async_sig,          // raw button (async)
    output logic led           // output (1 pulse per press)
);

    logic sync_sig;
    logic pulse;
    logic swt_out;
    logic edge_out;

    // 1. Synchronizer
    synchronizer sync1(
        .async_sig(async_sig),
        .clk(clk),
        .sync_sig(sync_sig)
    );

    // 2. Pulse generator (sampling)
    pulse_gen pg1(
        .clk(clk),
        .reset(reset),
        .pulse(pulse)
    );

    // 3. Debouncer
    debouncer_c db1(
        .pulse(pulse),
        .sync_sig(sync_sig),
        .clk(clk),
        .swt_out(swt_out)
    );

    // 4. Edge detector
    edge_detector ed1(
        .clk(clk),
        .signal_in(swt_out),
        .edge_pulse(edge_out)
    );

    // 5. Example usage → toggle LED on press
    always_ff @(posedge clk) begin
        if (reset)
            led <= 1'b0;
        else if (edge_out)
            led <= ~led;
    end

endmodule