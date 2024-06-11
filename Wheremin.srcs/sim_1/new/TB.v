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


module TB(

    );
    
    reg sysclk;
    wire [7:0] dac_input;
    
    //integer i;
    
    basys3 UUT(
        .clk(sysclk),
        .JC(dac_input)
        );
    
    initial begin
    
    sysclk <= 0;
    
    forever begin
        #5 sysclk = ~sysclk;
    end
    
    end
endmodule
