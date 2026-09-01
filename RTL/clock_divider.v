`timescale 1ns / 1ps

module clock_divider #(
    parameter integer CLK_FREQ  = 100_000_000,
    parameter integer TICK_FREQ = 1
)(
    input  wire clk,
    input  wire reset,
    output reg  tick
);

    localparam integer COUNT_MAX = CLK_FREQ / TICK_FREQ - 1;

    reg [31:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 32'd0;
            tick    <= 1'b0;
        end
        else begin
            if (counter >= COUNT_MAX) begin
                counter <= 32'd0;
                tick    <= 1'b1;
            end
            else begin
                counter <= counter + 1'b1;
                tick    <= 1'b0;
            end
        end
    end

endmodule