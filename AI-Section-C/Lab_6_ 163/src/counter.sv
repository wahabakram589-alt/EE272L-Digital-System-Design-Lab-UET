/*
    4-bit Configurable Counter
    mode = 0 : Wrap counter   (counts 0 -> 15 -> 0 -> ...)
    mode = 1 : Saturated counter (counts 0 -> 15, holds at 15)
*/
module counter
(
    input  logic       clk,
    input  logic       reset,
    input  logic       mode,
    output logic [3:0] count
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end
        else begin
            if (mode == 1'b0) begin
                // Wrap mode: overflow naturally wraps to 0
                count <= count + 1;
            end
            else begin
                // Saturated mode: hold at max value 15
                if (count == 4'b1111)
                    count <= 4'b1111;
                else
                    count <= count + 1;
            end
        end
    end

endmodule
