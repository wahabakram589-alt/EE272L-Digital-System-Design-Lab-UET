

module wrap_c(
    input  logic clk,
    input  logic reset,
    output logic [15:0] count   // CHANGED: 4-bit -> 16-bit, because 65000 needs 16 bits
);

    logic [15:0] next_c;        // CHANGED: 4-bit -> 16-bit
    logic [15:0] max_count = 16'd64999; // CHANGED: 65000 cycles means count 0..64999

    always_ff @(posedge clk) begin
        if (reset)
            count <= 16'd0;     // CHANGED: width updated
        else if (count == max_count)
            count <= 16'd0;     // CHANGED: wrap at 64999 so the period is exactly 65000 cycles
        else
            count <= count + 1;  // CHANGED: simpler counter logic for large width
    end

endmodule
