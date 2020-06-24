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
    input start,
    input reset,
    output reg out
   );
   
   reg [7:0] delay = 0;
   
   always@(posedge CLK100MHZ) begin
       
       if (reset == 1) begin
            out = 0;
       end
       if(reset == 0 && start == 1) begin
            
            if (data >= delay) begin
                out <= 1;
            end
            if (data < delay) begin
                out <= 0;
            end
            $monitor("%03d    %03d    %b", data, delay, out);
            
            delay = data;
            
       end
       
        
   end
    
    
endmodule
