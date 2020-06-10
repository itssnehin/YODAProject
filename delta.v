`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2020 12:12:40
// Design Name: 
// Module Name: delta
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


module delta(
    input CLK100MHZ,
    input [7:0]in,in1,in2,in3,in4,in5,in6,in7,
    output reg[7:0]out
    );
    //input array
    reg [7:0] in_reg [7:0];
    
    //bin2bcd values
    reg [7:0] bin;
    wire [3:0] h;
    wire [3:0] t;
    wire [3:0] o;
        
    //calling modules to convert to bcd
    bin2bcd d(bin,h,t,o);    

    //output
    reg [7:0] out_reg = 8'b0;
    integer i=0;
    reg [13:0]delay = 14'd0;
    reg [13:0] answer = 14'd0;
    reg [13:0] diff = 14'd0;
    always@(posedge(CLK100MHZ))begin 
        in_reg[0] <= in;
        in_reg[1] <= in1;
        in_reg[2] <= in2;
        in_reg[3] <= in3;
        in_reg[4] <= in4;
        in_reg[5] <= in5;
        in_reg[6] <= in6;
        in_reg[7] <= in7;
        
        for(i=0; i<8; i=i+1)begin 
            bin = in_reg[i];
            answer = (h*100)+(t*10)+(o*1);
            diff = answer - delay;
            if(diff >= delay)begin 
              out_reg[i] = 1'b1;
            end
            else begin 
              out_reg[i] = 1'b0;
            end
            delay = diff;
            //out_reg[5] <= 1'b1;
        end
       // i=i+1;
       // if(i==8)begin i<=0; end
        
        out[0] = out_reg[0];
        out[1] = out_reg[1];
        out[2] = out_reg[2];
        out[3] = out_reg[3];
        out[4] = out_reg[4];
        out[5] = out_reg[5];
        out[6] = out_reg[6];
        out[7] = out_reg[7];
    end
    
endmodule
