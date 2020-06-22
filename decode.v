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
    input [0:7] encode, // do 8-bit decoded at a time
    input reset,
    input start,
    input signed [7:0] delay,  //prevoius output value, need to update delay in main after each 
    output signed [7:0] result
    );
    
    reg [2:0] i = 0;
    reg val;
    reg [7:0] data = 0;
    always@(posedge CLK100MHZ) begin
            if (reset == 1) begin
                data = 0;
                i = 0;

            end
            
            else if(start == 1) begin
                val = encode[i];
                if(val == 1'b1) begin
                  //increment
                    data = delay + 10;
                end
                if(val == 1'b0) begin
                    // decrement
                    data = delay - 10;
                end
            end
            
            i = i + 1;           
            
            $display("clk  start    i    val       data    delay");
            $monitor("%b    %b    %01d       %b        %04d    %04d", CLK100MHZ,start,i,val, data, delay);
    end
    
    assign result = data;
    
    
    
    
endmodule
