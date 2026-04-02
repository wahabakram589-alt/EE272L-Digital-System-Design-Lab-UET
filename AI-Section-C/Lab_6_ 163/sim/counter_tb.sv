/*
    Testbench for counter module
    Tests both wrap and saturated modes
*/
module counter_tb;

    logic       clk;
    logic       reset;
    logic       mode;
    logic [3:0] count;

    // Instantiate DUT
    counter UUT (
        .clk   (clk),
        .reset (reset),
        .mode  (mode),
        .count (count)
    );

    // 10ns clock period
    localparam PERIOD = 10;
    initial clk = 0;
    always #(PERIOD/2) clk = ~clk;

    initial begin
        $monitor("time=%0t | mode=%b | reset=%b | count=%0d",
                  $time, mode, reset, count);

        // Apply reset
        reset = 1; mode = 0;
        #20;
        reset = 0;

        // ---- WRAP MODE (mode=0) ----
        // Count past 15 to verify wrap-around
        mode = 0;
        repeat(20) @(posedge clk);

        // ---- Reset and switch to SATURATED MODE (mode=1) ----
        reset = 1;
        #20;
        reset = 0;
        mode = 1;

        // Count past 15 to verify saturation at 15
        repeat(20) @(posedge clk);

        $stop;
    end

endmodule
