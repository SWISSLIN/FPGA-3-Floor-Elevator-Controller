`timescale 1ns / 1ps

module elevator_top (
    input  wire       clk,
    input  wire       reset,

    input  wire       floor1_btn,
    input  wire       floor2_btn,
    input  wire       floor3_btn,

    output wire       floor1_led,
    output wire       floor2_led,
    output wire       floor3_led,

    output wire       up_led,
    output wire       down_led,
    output wire       door_led,

    output wire [6:0] seg,
    output wire [3:0] an
);

    // ----------------------------------------
    // Internal signals
    // ----------------------------------------

    wire tick;

    wire [1:0] current_floor;

    // ----------------------------------------
    // Clock Divider
    // ----------------------------------------

    clock_divider #(
    .CLK_FREQ(100),
    .TICK_FREQ(10)
) clock_divider_inst (
        .clk   (clk),
        .reset (reset),
        .tick  (tick)
    );

    // ----------------------------------------
    // Elevator Controller
    // ----------------------------------------

    elevator_controller elevator_controller_inst (
        .clk           (clk),
        .reset         (reset),
        .tick          (tick),

        .floor1_btn    (floor1_btn),
        .floor2_btn    (floor2_btn),
        .floor3_btn    (floor3_btn),

        .current_floor (current_floor),

        .up_led        (up_led),
        .down_led      (down_led),
        .door_led      (door_led)
    );

    // ----------------------------------------
    // Current Floor LEDs
    // ----------------------------------------

    assign floor1_led = (current_floor == 2'd1);
    assign floor2_led = (current_floor == 2'd2);
    assign floor3_led = (current_floor == 2'd3);

    // ----------------------------------------
    // 7-Segment Display
    // ----------------------------------------

    seven_segment seven_segment_inst (
        .floor (current_floor),
        .seg   (seg),
        .an    (an)
    );

endmodule