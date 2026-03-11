module top_adder_decoder (
    input  logic [3:0] sw_A,    // 4 switches for Input A
    input  logic [3:0] sw_B,    // 4 switches for Input B
    input  logic       btn_cin, // Button or switch for Carry-In
    output logic [6:0] display_sum,  // Pins for the Sum display
    output logic [6:0] display_cout  // Pins for the Carry display
);

    // 1. Create internal "wires" to connect the modules
    logic [3:0] sum_result;
    logic       carry_out_result;

    // 2. Instantiate the Ripple Carry Adder
    // This performs: sw_A + sw_B + btn_cin = {carry_out_result, sum_result}
    ripple_carry_adder my_adder (
        .a(sw_A),
        .b(sw_B),
        .cin(btn_cin),
        .sum(sum_result),
        .cout(carry_out_result)
    );

    // 3. Instantiate Decoder 1 for the SUM (Units)
    seven_seg_decoder units_digit (
        .hex(sum_result),       // Connects the 4-bit sum result
        .seg(display_sum)       // Connects to physical pins
    );

    // 4. Instantiate Decoder 2 for the CARRY (Tens)
    // Since cout is only 1 bit, we pad it with 0s: {0,0,0,cout}
    seven_seg_decoder carry_digit (
        .hex({3'b000, carry_out_result}), 
        .seg(display_cout)
    );

endmodule