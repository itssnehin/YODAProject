`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 06/23/2020 01:18:08 AM
// Design Name: 
// Module Name: filter
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


module filter(
    input CLK100MHZ,
    input signed [8:0] current,
    
    input reset,
    input start,
    output signed [8:0] result
    );
    
    reg signed [9:0] sum = 0;
    reg signed [8:0] out = 0;
    
    reg signed [8:0] delay = 0;
    reg signed [8:0] delay2 = 0;
    reg signed [8:0] delay3 = 0; //4-byte moving avg
    
    always@(posedge CLK100MHZ) begin
    
        if(reset == 1) begin
            sum = 0;
            out = 0;
        end
        
        if(start == 1) begin
            sum = current + delay + delay2 + delay3;
            out = sum >> 2; //divide by 4
        end
        
        delay3 = delay2;
        delay2 = delay;
        delay = current;
        
    end
    
    assign result = out;
    
endmodule