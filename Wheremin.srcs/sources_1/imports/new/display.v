`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 12:08:26 AM
// Design Name: 
// Module Name: display
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


module display(
    input disp_clk, 
    input [7:0] din, 
    output reg [3:0] anodes,
    output [6:0] segment,
    input din_valid // While echo pulse is being recieved (width uknown) last valid measurement is kept
    );
    
    
    reg [15:0] num;
    reg [1:0] cnt;
    reg [3:0] currentNum;
    
    DecimalDecoder decode(.bin(currentNum), .cathodes(segment));
    
    initial begin
        cnt = 2'b00;
        num = 16'b0;
    end

    always @ (posedge disp_clk) begin 
        cnt <= cnt + 1;

        if (din_valid) num <= din;
        //num <= din;


        case (cnt)
            2'b00: begin
                anodes <= 4'b1110;
                currentNum <= (((num % 1000) % 100) % 10);
            end
            2'b01: begin
                anodes <= 4'b1101;
                currentNum <= ((num % 1000) % 100) / 10;
            end
            2'b10: begin
                anodes <= 4'b1011;
                currentNum <= (num % 1000) / 100;
            end
            2'b11: begin
                anodes <= 4'b0111;
                currentNum <= num / 1000;
            end
        endcase
    end
    
endmodule

module DecimalDecoder(bin, cathodes);
    input [3:0] bin;
    
    output reg [6:0] cathodes;
    
    always @ (*) begin
        case(bin)
            4'd1: cathodes = 7'b1111001;
            4'd2: cathodes = 7'b0100100;
            4'd3: cathodes = 7'b0110000;
            4'd4: cathodes = 7'b0011001;
            4'd5: cathodes = 7'b0010010;
            4'd6: cathodes = 7'b0000010;
            4'd7: cathodes = 7'b1111000;
            4'd8: cathodes = 7'b0000000;
            4'd9: cathodes = 7'b0011000;
            default: cathodes = 7'b1000000;
        endcase
    end
endmodule 