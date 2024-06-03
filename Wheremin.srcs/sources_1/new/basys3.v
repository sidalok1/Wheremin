`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2024 09:29:17 PM
// Design Name: 
// Module Name: basys3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module basys3(
    input clk,
    output JA1,
    input JA2,
    output [3:0] an,
    output [6:0] seg
    );

    wire [1:0] clk_bus;
    wire [15:0] distance;
    wire echo_valid;

    assign echo_valid = ~JA2;

    clocks clk_Module (
        .clk(clk), 
        .clk_100hz(clk_bus[1]), 
        .clk_1Mhz(clk_bus[0])
        );

    HCSR04 ultrasonic_sensor_Module (
        .clk(clk_bus[0]), 
        .echo(JA2),
        .trig(JA1), 
        .dout(distance)
        );

    display disp_Module (
        .disp_clk(clk_bus[1]),
        .din(distance),
        .anodes(an),
        .segment(seg),
        .din_valid(echo_valid)
        );

    
endmodule
