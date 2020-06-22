`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2020 07:01:56 PM
// Design Name: 
// Module Name: decode_tb
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


module decode_tb(
    input CLK100MHZ
    );
    reg [0:7] encode;
    reg signed [7:0] delay;
    wire signed [7:0] out;
    reg reset;
    reg start;
    reg [4:0] counter;
    
    always@(posedge CLK100MHZ) begin
        
    end
    
    decode uut (
        .CLK100MHZ(CLK100MHZ),
        .encode(encode),
        .reset(reset),
        .start(start),
        .delay(delay),
        .result(out)
    );
    
    initial begin
        start = 0;
        reset = 1;
        
        encode <= 8'b11101010;
        delay <= 8'd0;
        counter <= 0;
        #100
        reset = 0;
        start = 1;   
    end
    
    always@(negedge CLK100MHZ) begin
        delay = out;
    end   
    
endmodule
