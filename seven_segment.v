`timescale 1ns / 1ps

module seven_segment (
    input  wire [1:0] floor,
    output reg  [6:0] seg,
    output wire [3:0] an
);

    // Enable only the right-most 7-segment digit.
    // Active-low digit enable.
    assign an = 4'b1110;

    // Active-low 7-segment encoding
    //
    //        a
    //       ---
    //    f |   | b
    //       -g-
    //    e |   | c
    //       ---
    //        d

    always @(*) begin

        case (floor)

            2'd1:
                seg = 7'b1111001;  // 1

            2'd2:
                seg = 7'b0100100;  // 2

            2'd3:
                seg = 7'b0110000;  // 3

            default:
                seg = 7'b1111111;  // blank

        endcase

    end

endmodule