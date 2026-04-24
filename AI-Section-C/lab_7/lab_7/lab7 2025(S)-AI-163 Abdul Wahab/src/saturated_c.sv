module saturated_c(
    input  logic clk,          // inc time period clock signal
    input  logic reset,            // 0 means output can change at +ve edge, 1 means output= 0 
    input  logic enable,           // NEW: controls when counter should increment
    output logic [3:0] counter     // output to be displayed on 7 seg, with the help of decoder in top module
);

    logic [3:0] next_count;    // counter for final decision after comparator stage.
    logic [3:0] inc_count;     // counter after adding 1 
    logic sel_at_max;          // for selecting next step (should I add 1 or stay(for 'at 15'))
    logic c1, c2, c3;          // carries for 4 bit addition

    // 4-bit incrementer
    full_adder fa0(
        .A   (counter[0]),
        .B   (1'b1),
        .Cin (1'b0),
        .Sum (inc_count[0]),
        .Cout(c1)
    );

    full_adder fa1(
        .A   (counter[1]),
        .B   (1'b0),
        .Cin (c1),
        .Sum (inc_count[1]),
        .Cout(c2)
    );

    full_adder fa2(
        .A   (counter[2]),
        .B   (1'b0),
        .Cin (c2),
        .Sum (inc_count[2]),
        .Cout(c3)
    );

    full_adder fa3(
        .A   (counter[3]),
        .B   (1'b0),
        .Cin (c3),
        .Sum (inc_count[3]),
        .Cout()
    );

    // comparator for checking when counter = 15 (4'b1111)
    // AND is '1' only when all bits are '1'
    and(sel_at_max, counter[3], counter[2], counter[1], counter[0]);

    // select incremented value or stay / holding at 15
    // if not max(15), sel_at_max = 0 → next_counter = inc_counter
    // if max(15), sel_at_max = 1 → hold previous value
    mux2to1 m0(.x(inc_count[0]), .y(counter[0]), .sel(sel_at_max), .z(next_count[0]));  
    mux2to1 m1(.x(inc_count[1]), .y(counter[1]), .sel(sel_at_max), .z(next_count[1]));   
    mux2to1 m2(.x(inc_count[2]), .y(counter[2]), .sel(sel_at_max), .z(next_count[2]));  
    mux2to1 m3(.x(inc_count[3]), .y(counter[3]), .sel(sel_at_max), .z(next_count[3])); 

    // Flip-Flop (updates on +ve edge of clk_out)
    always_ff @(posedge clk) begin
        if (reset)
            counter <= 4'd0;          // reset condition
        else if (enable)
            counter <= next_count;    // increment only when enable = 1
        else
            counter <= counter;       // hold value when enable = 0
    end

endmodule