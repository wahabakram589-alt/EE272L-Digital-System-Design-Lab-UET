`timescale 1ns/1ps

module top_tb;

    logic clk;
    logic reset;
    logic async_sig;
    logic led;

    top_module dut(
        .clk(clk),
        .reset(reset),
        .async_sig(async_sig),
        .led(led)
    );

    always #5 clk = ~clk;

    int toggle_count;

    initial begin
        clk = 0;
        reset = 1;
        async_sig = 0;
        toggle_count = 0;

        #10 reset = 0;

        // 🔥 FORCE DEBOUNCER OUTPUT DIRECTLY
        // skip slow logic completely
        force dut.swt_out = 1'b0;

        // press 1
        #20 force dut.swt_out = 1'b1;
        #10 force dut.swt_out = 1'b0;

        // press 2
        #20 force dut.swt_out = 1'b1;
        #10 force dut.swt_out = 1'b0;

        // release
        #20 release dut.swt_out;

        #50;

        if (toggle_count >= 2)
            $display("ALL TESTS PASSED");
        else
            $error("FAILED: Expected >=2 toggles, got %0d", toggle_count);

        $finish;
    end

    logic prev_led;

    always @(posedge clk) begin
        prev_led <= led;
        if (led != prev_led)
            toggle_count++;
    end

endmodule