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
    output reg [15:0] dout
    );
    
     reg [15:0] trig_counter;
     reg [15:0] dout_buff [4:0];
     integer i;
     reg [15:0] echo_high;
     reg [15:0] echo_low;
     reg echo_state;

     reg [15:0] pulse_width; 

     reg [1:0] echo_prev;
    
     wire [15:0] avg_echo;

     average dout_averager(
          .data0(dout_buff[0]),
          .data1(dout_buff[1]),
          .data2(dout_buff[2]),
          .data3(dout_buff[3]),
          .data4(dout_buff[4]), 
          .out(avg_echo)
          );

     initial begin
          trig_counter <= 0;
          echo_prev <= 0;
          echo_high <= 0;
          echo_low <= 0;
          dout_buff[0] <= 16'b0;
          dout_buff[1] <= 16'b0;
          dout_buff[2] <= 16'b0;
          dout_buff[3] <= 16'b0;
          dout_buff[4] <= 16'b0;
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
               16'd60_000: begin 
                    trig_counter <= 0;
               end
               default: trig_counter <= trig_counter + 1;
          endcase

          if (echo_prev[0]) begin
               if (!echo_prev[1]) begin
                    pulse_width <= 0;
               end
               else begin
                    pulse_width <= pulse_width + 1;
               end
          end
          else if (echo_prev[1]) begin
               if (pulse_width < 4000) begin
                    for (i = 0; i < 4; i = i + 1) begin
                         dout_buff[i + 1] <= dout_buff[i];
                    end
                    dout_buff[0] <= (pulse_width - 12) / 58;
               end
               dout <= avg_echo;
          end

          /* if (echo && !echo_prev[1]) begin
               echo_high <= trig_counter;
          end

          if (echo_prev[1] && !echo) begin
               echo_low <= trig_counter;
          end */

          echo_prev[0] <= echo;  
          echo_prev[1] <= echo_prev[0];
          
          
     end

     //assign pulse_width = (echo_high - 'd12);

     //assign dout = (pulse_width) * 'd17;
    //mult by 10,000
endmodule

module average(
     input [15:0] data0, data1, data2, data3, data4,
     output [15:0] out
     );

     wire [18:0] sum;

     assign sum = data0 + data1 + data2 + data3 + data4;
     assign out = sum / 'd5;

endmodule
