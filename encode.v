`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2020 02:08:59 PM
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
    input [7:0] delay,
    input start,
    input reset,
    output reg out,
    output reg [0:7] encoded
   );
   
   always@(posedge CLK100MHZ) begin
       
       if (reset == 1) begin
            out = 0;
            encoded = 0;
       end
       else if(reset == 0 && start == 1) begin
            if (data >= delay) begin
                out = 1;
            end
            else begin
                out = 0;
            end
            
            encoded = encoded << 1;
            encoded = encoded + out;
       
       end
       
        
   end
    
    
endmodule
