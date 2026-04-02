/*
    Testbench for top module
    Verifies seg[6:0] and an[7:0] outputs alongside led[3:0]

    IMPORTANT: The freq_divider divides 100MHz by 2^26 (~67M cycles per tick).
    To make simulation feasible, we modify the approach:
    - We directly force the internal slow clock of freq_divider using
      a force statement so we don't have to wait 67M cycles.
    - This lets us see seg and an changing in a reasonable sim time.
*/
module top_tb;

    logic        clk;
    logic        reset;
    logic        mode;
    logic [6:0]  seg;
    logic [7:0]  an;
    logic [3:0]  led;

    // Instantiate top module
    top UUT (
        .clk   (clk),
        .reset (reset),
        .mode  (mode),
        .seg   (seg),
        .an    (an),
        .led   (led)
    );

    // 10ns board clock
    localparam PERIOD = 10;
    initial clk = 0;
    always #(PERIOD/2) clk = ~clk;

    // Force the internal slow clock directly to bypass freq_divider delay
    // This makes clk_slow toggle every 50ns instead of every 671ms
    initial begin
        force UUT.clk_slow = 0;
        forever #50 force UUT.clk_slow = ~UUT.clk_slow;
    end

    initial begin
        $monitor("time=%0t | reset=%b | mode=%b | led=%b | seg=%b | an=%b",
                  $time, reset, mode, led, seg, an);

        // Apply reset
        reset = 1; mode = 0;
        #20;
        reset = 0;

        // ---- WRAP MODE (mode=0) ----
        // Run through all 16 values (0 to F) and wrap back
        mode = 0;
        repeat(20) @(posedge UUT.clk_slow);

        // ---- Reset then SATURATED MODE (mode=1) ----
        reset = 1;
        #20;
        reset = 0;
        mode = 1;

        // Run past 15 to confirm saturation
        repeat(20) @(posedge UUT.clk_slow);

        $stop;
    end

endmodule