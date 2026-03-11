module seven_seg_decoder (
    input  logic [3:0] hex, // 4-bit input (0-F)
    output logic [6:0] seg  // seg[6]=A, [5]=B, [4]=C, [3]=D, [2]=E, [1]=F, [0]=G
);

    // Internal wires using a, b, c, d
    // a is MSB (hex[3]), d is LSB (hex[0])
    logic a, b, c, d;
    assign {a, b, c, d} = hex;



    // Segment A (seg[6])
    assign seg[6] = (~a & ~b & ~c &  d) | // 1
                    (~a &  b & ~c & ~d) | // 4
                    ( a & ~b &  c &  d) | // B
                    ( a &  b & ~c & ~d) | // C
                    ( a &  b & ~c &  d) | // D
                    ( a &  b &  c & ~d) | // E
                    ( a &  b &  c &  d);  // F

    // Segment B (seg[5])
    assign seg[5] = (~a &  b & ~c &  d) | // 5
                    (~a &  b &  c & ~d) | // 6
                    ( a & ~b &  c &  d) | // B
                    ( a &  b & ~c & ~d) | // C
                    ( a &  b &  c & ~d) | // E
                    ( a &  b &  c &  d);  // F

    // Segment C (seg[4])
    assign seg[4] = (~a & ~b &  c & ~d) | // 2
                    ( a &  b & ~c & ~d) | // C
                    ( a &  b &  c & ~d) | // E
                    ( a &  b &  c &  d);  // F

    // Segment D (seg[3])
    assign seg[3] = (~a & ~b & ~c &  d) | // 1
                    (~a &  b & ~c & ~d) | // 4
                    (~a &  b &  c &  d) | // 7
                    ( a & ~b &  c & ~d) | // A
                    ( a &  b &  c &  d);  // F

    // Segment E (seg[2])
    assign seg[2] = (~a & ~b & ~c &  d) | // 1
                    (~a & ~b &  c &  d) | // 3
                    (~a &  b & ~c & ~d) | // 4
                    (~a &  b & ~c &  d) | // 5
                    (~a &  b &  c &  d) | // 7
                    ( a & ~b & ~c &  d);  // 9

    // Segment F (seg[1])
    assign seg[1] = (~a & ~b & ~c &  d) | // 1
                    (~a & ~b &  c & ~d) | // 2
                    (~a & ~b &  c &  d) | // 3
                    (~a &  b &  c &  d) | // 7
                    ( a &  b & ~c &  d);  // D

    // Segment G (seg[0])
    assign seg[0] = (~a & ~b & ~c & ~d) | // 0
                    (~a & ~b & ~c &  d) | // 1
                    (~a &  b &  c &  d) | // 7
                    ( a &  b & ~c & ~d);  // C

endmodule