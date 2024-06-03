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
    output wire [15:0] dout
    );
    
     reg [15:0] trig_counter;
     //wire [15:0] trig_pulse;
     reg [15:0] echo_high;
     reg [15:0] echo_low;

     wire [7:0] pulse_width; 

     reg [1:0] echo_prev;
    


     initial begin
          trig_counter <= 0;
          echo_prev <= 0;
          echo_high <= 0;
          echo_low <= 0;
     end
     
     always @ (posedge clk) begin
     
          case (trig_counter)
               16'd0: begin
                    trig <= 0;
                    trig_counter <= trig_counter + 1;
                    end
               16'd2: begin
                    trig <= 1;
                    trig_counter <= trig_counter + 1;
                    end
               16'd12: begin
                    trig <= 0;
                    trig_counter <= trig_counter + 1;
                    end
               16'd60000: trig_counter <= 0;
               default: trig_counter <= trig_counter + 1;
          endcase

          /* if (echo_prev[0]) begin
               if (!echo_prev[1]) begin
                    pulse_width <= 0;
               end
               else begin
                    pulse_width <= pulse_width + 1;
               end
          end
          else if (echo_prev[1]) begin
               dout <= (pulse_width - 12) / 58;
          end */

          if (echo_prev[0] && !echo_prev[1]) begin
               echo_high <= trig_counter;
          end

          if (echo_prev[1] && !echo_prev[0]) begin
               echo_low <= trig_counter;
          end

          echo_prev[0] <= echo;  
          echo_prev[1] <= echo_prev[0];
          
          
     end

     assign pulse_width = echo_low - echo_high;

     assign dout = (pulse_width / 2) * (343);

endmodule
