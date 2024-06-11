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
    output JB1,
    input JB2,
    output [3:0] an,
    output [6:0] seg,
    output [7:0] JC,
    output JB3
    );

    wire [1:0] clk_bus;
    wire [15:0] distance;
    wire echo_valid;
    wire freq;

    assign echo_valid = ~JB2;
    
    assign JB3 = clk_bus[1];
    
    clocks clk_Module (
        .clk(clk), 
        .clk_100hz(clk_bus[1]), 
        .clk_1Mhz(clk_bus[0]),
        .tuning_word(distance),
        .freq(freq)
        );

    HCSR04 ultrasonic_sensor_Module (
        .clk(clk_bus[0]), 
        .echo(JB2),
        .trig(JB1), 
        .dout(distance)
        );

    display disp_Module (
        .disp_clk(clk_bus[1]),
        .din(distance),
        .anodes(an),
        .segment(seg),
        .din_valid(echo_valid)
        );
    
    Sine_Generator virtual_oscillator(
        .freq(freq),
        .sine(JC)
        );
    
endmodule
