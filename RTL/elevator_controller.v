`timescale 1ns / 1ps

module elevator_controller (
    input  wire       clk,
    input  wire       reset,
    input  wire       tick,

    input  wire       floor1_btn,
    input  wire       floor2_btn,
    input  wire       floor3_btn,

    output reg [1:0]  current_floor,
    output reg        up_led,
    output reg        down_led,
    output reg        door_led
);

    // Elevator states
    localparam IDLE      = 2'b00;
    localparam MOVE_UP   = 2'b01;
    localparam MOVE_DOWN = 2'b10;
    localparam DOOR_OPEN = 2'b11;

    reg [1:0] state;
    reg [1:0] target_floor;

    // Used to prevent a continuously pressed button
    // from repeatedly requesting the elevator.
    reg floor1_prev;
    reg floor2_prev;
    reg floor3_prev;

    reg [1:0] door_count;

    wire floor1_pressed;
    wire floor2_pressed;
    wire floor3_pressed;

    assign floor1_pressed = floor1_btn & ~floor1_prev;
    assign floor2_pressed = floor2_btn & ~floor2_prev;
    assign floor3_pressed = floor3_btn & ~floor3_prev;

    // Button history
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            floor1_prev <= 1'b0;
            floor2_prev <= 1'b0;
            floor3_prev <= 1'b0;
        end
        else begin
            floor1_prev <= floor1_btn;
            floor2_prev <= floor2_btn;
            floor3_prev <= floor3_btn;
        end
    end

    // Main elevator FSM
    always @(posedge clk or posedge reset) begin

        if (reset) begin
            state         <= IDLE;
            current_floor <= 2'd1;
            target_floor  <= 2'd1;
            door_count    <= 2'd0;

            up_led        <= 1'b0;
            down_led      <= 1'b0;
            door_led      <= 1'b0;
        end

        else begin

            case (state)

                // --------------------------------
                // IDLE
                // --------------------------------
                IDLE: begin

                    up_led   <= 1'b0;
                    down_led <= 1'b0;
                    door_led <= 1'b0;

                    // Floor 1 button
                    if (floor1_pressed) begin
                        target_floor <= 2'd1;

                        if (current_floor > 2'd1)
                            state <= MOVE_DOWN;
                        else
                            state <= DOOR_OPEN;
                    end

                    // Floor 2 button
                    else if (floor2_pressed) begin
                        target_floor <= 2'd2;

                        if (current_floor < 2'd2)
                            state <= MOVE_UP;
                        else if (current_floor > 2'd2)
                            state <= MOVE_DOWN;
                        else
                            state <= DOOR_OPEN;
                    end

                    // Floor 3 button
                    else if (floor3_pressed) begin
                        target_floor <= 2'd3;

                        if (current_floor < 2'd3)
                            state <= MOVE_UP;
                        else
                            state <= DOOR_OPEN;
                    end
                end


                // --------------------------------
                // MOVE UP
                // --------------------------------
                MOVE_UP: begin

                    up_led   <= 1'b1;
                    down_led <= 1'b0;
                    door_led <= 1'b0;

                    if (tick) begin

                        if (current_floor < target_floor) begin
                            current_floor <= current_floor + 1'b1;
                        end

                        else begin
                            state <= DOOR_OPEN;
                            door_count <= 2'd0;
                        end
                    end
                end


                // --------------------------------
                // MOVE DOWN
                // --------------------------------
                MOVE_DOWN: begin

                    up_led   <= 1'b0;
                    down_led <= 1'b1;
                    door_led <= 1'b0;

                    if (tick) begin

                        if (current_floor > target_floor) begin
                            current_floor <= current_floor - 1'b1;
                        end

                        else begin
                            state <= DOOR_OPEN;
                            door_count <= 2'd0;
                        end
                    end
                end


                // --------------------------------
                // DOOR OPEN
                // --------------------------------
                DOOR_OPEN: begin

                    up_led   <= 1'b0;
                    down_led <= 1'b0;
                    door_led <= 1'b1;

                    if (tick) begin

                        if (door_count < 2'd2) begin
                            door_count <= door_count + 1'b1;
                        end

                        else begin
                            door_count <= 2'd0;
                            state <= IDLE;
                        end
                    end
                end


                // --------------------------------
                // DEFAULT
                // --------------------------------
                default: begin
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule