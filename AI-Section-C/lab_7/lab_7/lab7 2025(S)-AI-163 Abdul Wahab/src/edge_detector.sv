module edge_detector(
    input  logic clk,        // same clock domain
    input  logic signal_in,      // debounced signal (swt_out)
    output logic edge_pulse      // 1-cycle output pulse
);

    logic prev_sig;              // stores previous value of signal_in

    // Flip-Flop to store previous state
    always_ff @(posedge clk) begin
        prev_sig <= signal_in;
    end

    // rising edge detection
    // edge occurs when:
    // current = 1 AND previous = 0
    and a1(edge_pulse, signal_in, ~prev_sig);

endmodule