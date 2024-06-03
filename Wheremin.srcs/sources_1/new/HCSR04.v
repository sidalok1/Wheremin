`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 11:37:14 AM
// Design Name: 
// Module Name: HCSR04
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


module HCSR04(
    input echo,
    input clk,
    output reg trig,
    output [7:0] dout
    );
    
    reg [15:0] trig_counter;
    
    reg [7:0] echo_counter; 
    
    initial begin
        trig_counter <= 0;
        echo_counter <= 0;
    end
    
    always @ (posedge clk) begin
    
        case (trig_counter)
            16'd0: begin
                 trig <= 0;
                 trig_counter <= trig_counter + 1;
                 end
            16'd200: begin
                 trig <= 1;
                 trig_counter <= trig_counter + 1;
                 end
            16'd1200: begin
                 trig <= 0;
                 trig_counter <= trig_counter + 1;
                 end
            16'd6_000_000: trig_counter <= 0;
            default: trig_counter <= trig_counter + 1;
         endcase
 
    end
    
endmodule
