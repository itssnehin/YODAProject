`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2020 22:01:38
// Design Name: 
// Module Name: encode
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


module encode(
    input CLK100MHZ,
    input [7:0] data,
    input step,
    output reg out
    );
    
    
    reg [13:0] delay = 0;
    reg [13:0] sum;
    
    bin2bcd b(data,sum);
    integer i=0;
    always@(posedge CLK100MHZ)begin 
        if(i<8)begin
            if(sum >= delay)begin 
                out = 1'b1;
                delay = delay + out*step;
            end
            else begin 
                out = 1'b0;
                delay = delay + (-1)*step;
            end
        end
    end
endmodule
