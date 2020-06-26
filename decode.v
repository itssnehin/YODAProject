`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2020 05:29:33 PM
// Design Name: 
// Module Name: decode
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

module decode(
    input CLK100MHZ,
    input encode, // do 1-bit decoded at a time
    input reset,
    input start,
    output signed [8:0] result
    );
    

    reg [7:0] delay = 0;  //prevoius output value, need to update delay in main after each 

    reg signed [8:0] data = 0;
    always@(posedge CLK100MHZ) begin
            if (reset == 1) begin
                data = 0;

            end
            
            else if(start == 1) begin

                if(encode == 1'b1) begin
                    data = delay + 20;
                end
                if(encode == 1'b0) begin
                    // decrement
                    if(delay > 5) begin
                        data = delay - 20;
                    end
                end
            end
            
            
            delay = data;
    end
    
    assign result = data;
    
       
endmodule