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
    
    reg [7:0] data;
    reg [7:0] data1;
    reg [7:0] data2;
    //reg [0:7] encode_reg;
    reg signed [7:0] delay;
    wire signed [7:0] out;
    wire [0:7] encoded;
    reg reset;
    reg start;
    reg [4:0] counter;
    reg signed [7:0] delay2;
    reg signed [7:0] delay3;
    wire signed [7:0] avg;
    //reg [31:0] message;
    reg [7:0] delay_input;
    
    
    encode enc(
        .CLK100MHZ(CLK100MHZ),
        .data(data),
        .delay(delay_input),
        .start(start),
        .reset(reset),
        .out(bit_out),
        .encoded(encoded)    
    );
    
    
    
    decode uut (
        .CLK100MHZ(CLK100MHZ),
        .encode(encode),
        .reset(reset),
        .start(start),
        .delay(delay),
        .result(out)
    );
    
    filter test (
        .CLK100MHZ(CLK100MHZ),
        .reset(reset),
        .start(start),
        .current(out),
        .delay(delay),
        .delay2(delay2),
        .delay3(delay3),
        .result(avg)
    );
    
    initial begin
        start = 0;
        reset = 1;
        delay <= 8'd0;
        delay2 <= 8'd0;
        delay3 <= 8'd0;
        counter <= 0;
        //message = 32'b11111010000000000101111111111010;
        data = 0;
        data1 = 20;
        data2 = 0;
        #100
        reset = 0;
        start = 1;   
    end
    
    always@(negedge CLK100MHZ) begin
        
        delay3 = delay2;
        delay2 = delay;
        delay = out;
       
        delay_input = data;
        data = data1;
        data1 = data2;
    end   
    
endmodule
