`timescale 1ns / 1ps

module elevator_tb;

    reg clk;
    reg reset;

    reg floor1_btn;
    reg floor2_btn;
    reg floor3_btn;

    wire floor1_led;
    wire floor2_led;
    wire floor3_led;

    wire up_led;
    wire down_led;
    wire door_led;

    wire [6:0] seg;
    wire [3:0] an;

    // ----------------------------------------
    // DUT
    // ----------------------------------------

    elevator_top uut (
        .clk          (clk),
        .reset        (reset),

        .floor1_btn   (floor1_btn),
        .floor2_btn   (floor2_btn),
        .floor3_btn   (floor3_btn),

        .floor1_led   (floor1_led),
        .floor2_led   (floor2_led),
        .floor3_led   (floor3_led),

        .up_led       (up_led),
        .down_led     (down_led),
        .door_led     (door_led),

        .seg          (seg),
        .an           (an)
    );

    // ----------------------------------------
    // Clock
    // ----------------------------------------

    always #5 clk = ~clk;

    // ----------------------------------------
    // Test sequence
    // ----------------------------------------

    initial begin

        clk = 0;
        reset = 1;

        floor1_btn = 0;
        floor2_btn = 0;
        floor3_btn = 0;

        // Reset
        #100;
        reset = 0;

        // ====================================
        // TEST 1: Floor 1 -> Floor 3
        // ====================================

        #100;

        floor3_btn = 1;
        #20;
        floor3_btn = 0;

        // Wait for Floor 3 + door
        #1000;

        // ====================================
        // TEST 2: Floor 3 -> Floor 1
        // ====================================

        floor1_btn = 1;
        #20;
        floor1_btn = 0;

        // Wait for Floor 1 + door
        #1000;

        // ====================================
        // TEST 3: Floor 1 -> Floor 2
        // ====================================

        floor2_btn = 1;
        #20;
        floor2_btn = 0;

        // Wait for Floor 2 + door
        #700;

        $finish;

    end

endmodule
