`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2024 09:15:09 PM
// Design Name: 
// Module Name: clocks
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


module clocks(
    input clk,
    output reg clk_100hz,
    output reg clk_1Mhz,
    input [7:0] freq_mod, // distance data from ultrasonic sensor
    output reg freq
    );

    reg [31:0] counter;
    reg [24:0] freq_counter;
    
    wire [24:0] target;
    
    //assign target = 227272/(((68/freq_mod)) * 256 * 2);

    assign target = 7 * freq_mod;

    initial begin
        counter <= 0;
        clk_100hz <= 0;
        clk_1Mhz <= 0;
        freq <= 0;
        freq_counter <= 0;
    end


    always @ (posedge clk) begin
        if (counter == 'd500_000) counter <= 32'b0;
        else begin
            counter <= counter + 1;
            if (counter % 'd50 == 0)
                clk_1Mhz <= ~clk_1Mhz;
//            if (counter % 'd1000 == 0)
//                freq <= ~freq;
            if (counter % 'd250_000 == 0)
                clk_100hz <= ~clk_100hz;
                     
        end
        if (freq_counter >= target) begin
            freq_counter <= 0;
            freq <= ~freq;
        end else freq_counter <= freq_counter + 1;
        
    end
endmodule
