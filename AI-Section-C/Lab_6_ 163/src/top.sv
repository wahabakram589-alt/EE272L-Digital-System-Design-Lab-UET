/*
    Top Module - Wrap and Saturated Counters
    - Wrap counter   : displayed on 7-segment display (AN0)
    - Saturated counter : displayed on LEDs [3:0]
    - mode  (SW0)  : 0 = wrap, 1 = saturated (applies to both counters)
    - reset (BTNC) : active-high reset
*/
module top
(
    input  logic       clk,       // 100 MHz board clock
    input  logic       reset,     // BTNC
    input  logic       mode,      // SW0: 0=wrap, 1=saturated
    output logic [6:0] seg,       // 7-segment cathodes
    output logic [7:0] an,        // 7-segment anodes
    output logic [3:0] led        // LEDs show saturated counter
);

    // Internal wires
    logic        clk_slow;
    logic [3:0]  wrap_count;
    logic [3:0]  sat_count;

    // Frequency divider: 100MHz -> ~1.5Hz
    freq_divider fd0 (
        .clk    (clk),
        .reset  (reset),
        .clk_out(clk_slow)
    );

    // Wrap counter (mode=0 hardwired) -> 7-segment display
    counter wrap_ctr (
        .clk   (clk_slow),
        .reset (reset),
        .mode  (1'b0),
        .count (wrap_count)
    );

    // Saturated counter (mode=1 hardwired) -> LEDs
    counter sat_ctr (
        .clk   (clk_slow),
        .reset (reset),
        .mode  (1'b1),
        .count (sat_count)
    );

    // Decoder: show wrap counter on 7-segment display
    decoder dec0 (
        .in  (wrap_count),
        .seg (seg),
        .an  (an)
    );

    // Saturated counter on LEDs
    assign led = sat_count;

endmodule
