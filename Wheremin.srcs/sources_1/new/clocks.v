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
    output reg clk_1Mhz
    );

    reg [31:0] counter;

    initial begin
        counter <= 0;
        clk_100hz <= 0;
        clk_1Mhz <= 0;
    end


    always @ (posedge clk) begin
        if (counter == 'd500_000) counter <= 32'b0;
        else begin
            counter <= counter + 1;
            if (counter % 'd50 == 0)
                clk_1Mhz <= ~clk_1Mhz;
            if (counter % 'd250_000 == 0)
                clk_100hz <= ~clk_100hz;
        end
    end
endmodule
