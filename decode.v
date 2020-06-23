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
    input signed [7:0] delay,  //prevoius output value, need to update delay in main after each 
    output signed [7:0] result
    );
    


    reg [7:0] data = 0;
    always@(posedge CLK100MHZ) begin
            if (reset == 1) begin
                data = 0;

            end
            
            else if(start == 1) begin

                if(encode == 1'b1) begin
                  //increment
                    data = delay + 10;
                end
                if(encode == 1'b0) begin
                    // decrement
                    data = delay - 10;
                end
            end
    end
    
    assign result = data;
    
    
    
    
endmodule
