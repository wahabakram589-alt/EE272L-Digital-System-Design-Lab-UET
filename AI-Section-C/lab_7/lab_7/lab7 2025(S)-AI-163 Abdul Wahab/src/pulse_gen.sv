module pulse_gen #(
    parameter SAMPLE_MAX = 16'd64999   // default for FPGA (65000 cycles)
)(
    input  logic clk,
    input  logic reset,
    output logic pulse
);

logic [15:0] curr_counter;          
logic [15:0] samp_cmax = SAMPLE_MAX;   // CHANGED: now parameterized

// using wrap counter
wrap_c wc(clk, reset, curr_counter);

// pulse is high for one clock when count reaches terminal value
assign pulse = (curr_counter == samp_cmax);

endmodule