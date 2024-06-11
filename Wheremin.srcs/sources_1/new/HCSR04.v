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
    output reg [7:0] dout
    );
    
     reg [15:0] trig_counter;
     reg [15:0] dout_buff [4:0];
     integer i;
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
          dout_buff[0] <= 16'b0;
          dout_buff[1] <= 16'b0;
          dout_buff[2] <= 16'b0;
          dout_buff[3] <= 16'b0;
          dout_buff[4] <= 16'b0;
     end
     
     always @ (posedge clk) begin
          //Read HC-SR04 doc for more information
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
               //increment from zero upon reaching rising edge
               if (!echo_prev[1]) begin
                    pulse_width <= 0;
               end
               else begin
                    pulse_width <= pulse_width + 1;
               end
          end
          //On falling edge
          else if (echo_prev[1]) begin
               /*
               When a pulse from the ultrasonic sensor is not deflected back at the sensor, a large value is registered (likely
               due to the pulse needing to bounce off multiple surfaces to return to sensor). Practically, values over 4000, which
               correspond to around 70cm should be considered noise, as an impractically large flat surface area would be needed to
               reliably bounce a signal back to the module (also requiring the user to move their hand more than 70cm is not great)
               */
               if (pulse_width < 4000) begin
                    //Shift register for averaging over past 5 samples
                    for (i = 0; i < 4; i = i + 1) begin
                         dout_buff[i + 1] <= dout_buff[i];
                    end
                    dout_buff[0] <= (pulse_width - 12) / 58;
                    //Multiple equations were given by HC-SR04 documentation, not all of them correct. Much trial and error was needed for this equation
               end
               dout <= (avg_echo);
               //Averaging sensor values between past 5 samples (about 300 ms) strikes good balance between being robust to noise and being responsive to input
          end

          echo_prev[0] <= echo;  
          echo_prev[1] <= echo_prev[0];

     end     
endmodule

//Combinational circuit for average of five values.
module average(
     input [15:0] data0, data1, data2, data3, data4,
     output [15:0] out
     );

     wire [18:0] sum;

     assign sum = data0 + data1 + data2 + data3 + data4;
     assign out = sum / 'd5;

endmodule
