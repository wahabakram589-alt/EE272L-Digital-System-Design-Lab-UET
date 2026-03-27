module multiplier_tb();
   
    logic [3:0] X;
    logic [6:0] seg; 

    multiplier DUT (
        .X(X),
        .seg_out(seg)
    );

    initial begin 

        $display("Time\t Input(X) \t Segments(abcdefg)");

        X = 4'd0; #10; $display("%0t\t %d \t\t %b", $time, X, seg);
        X = 4'd1; #10; $display("%0t\t %d \t\t %b", $time, X, seg);
        X = 4'd2; #10; $display("%0t\t %d \t\t %b", $time, X, seg);
        X = 4'd3; #10; $display("%0t\t %d \t\t %b", $time, X, seg);
        X = 4'd4; #10; $display("%0t\t %d \t\t %b", $time, X, seg);
        X = 4'd5; #10; $display("%0t\t %d \t\t %b", $time, X, seg);

        $display("Simulation Finished!");
        $stop; 
    end
endmodule