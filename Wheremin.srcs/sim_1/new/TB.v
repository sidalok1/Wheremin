`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2024 07:20:44 PM
// Design Name: 
// Module Name: TB
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


module TB();
    
    reg sysclk;
    wire [7:0] dac_input;
    
    basys3 UUT(
        .clk(sysclk),
        .JC(dac_input)
        );
    
    initial begin
    
    sysclk <= 0;
    
    /*
    Due to ultrasonic sensor requiring physical world interaction, testing of said module was done without testbench.
    For the sine generator however, a 440*256 hz clock was given from the clock module to check for correct output.
    */

    forever begin
        #5 sysclk = ~sysclk;
    end
    
    end
endmodule
