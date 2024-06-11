`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2024 11:19:58 AM
// Design Name: 
// Module Name: Sine_Generator
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


module Sine_Generator (
    input freq,     // From phase accumulator in clock module. Changes how fast phase register is read through
    output reg [7:0] sine  // 8-bit output representing sine value
);

    // Define a phase register for sine values
    reg [7:0] sin_values [0:255];
    reg [7:0] phase; // 8-bit input representing phase (0 to 255)

    // Precompute sine values and store them in the phase register
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            // Calculate sine value for each phase angle
            sin_values[i] = 127 * ($sin(i * ((2 * 3.14159) / 256)) + 1);
        end
        phase = 0;
    end

    // Output the sine value corresponding to the input phase
    always @(posedge freq) begin
        phase <= phase + 1;
        sine <= sin_values[phase];
    end

endmodule