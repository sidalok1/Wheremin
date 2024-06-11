`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2024 10:59:31 AM
// Design Name: 
// Module Name: DAC
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

module DAC(
        input DAC_clk, 
        
        output [9:0] DAC_data
        );

// let's create a 16 bits free-running binary counter
reg [15:0] cnt;

always @(posedge DAC_clk) cnt <= cnt + 16'h1;

assign DAC_data = cnt[10] ? ~cnt[9:0] : cnt[9:0];
  
endmodule
