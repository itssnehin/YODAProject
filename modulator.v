`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2020 11:57:20
// Design Name: 
// Module Name: modulator
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


module modulator(
    input CLK100MHZ,
    input BTNL,
    output reg[7:0] LED
);
reg [7:0]in[7:0]; 
wire[7:0]out;
wire Button;
Debounce bounce(CLK100MHZ,BTNL,Button);
delta d(CLK100MHZ,in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7],out);

 /*bin2bcd values
    reg [7:0] bin;
    wire [3:0] h;
    wire [3:0] t;
    wire [3:0] o;
        
    //calling modules to convert to bcd
    bin2bcd d2(bin,h,t,o);    
*/
integer i;
    reg [13:0]delay = 14'd0;
    reg [13:0] answer = 14'd0;
    reg [13:0] diff = 14'd0;
always @ (posedge CLK100MHZ)begin 
   if(Button)begin
        in[0] <= "00000000";
        in[1] <= "10011101";
        in[2] <= "10110101";
        in[3] <= "01110110";
        in[4] <= "10100110";
        in[5] <= "10110101";
        in[6] <= "10111101";
        in[7] <= "01110101";
    end
     /* for(i=0; i<8; i=i+1)begin 
           bin <= in[i];
           answer <= (h*100)+(t*10)+(o*1);
           diff <= answer - delay;
           if(diff >= delay)begin 
              out[i] <= 1'b1;
           end
           else begin 
              out[i] <= 1'b0;
           end
           delay <= diff;
        end
    end*/
      LED[0] <= out[0];
      LED[1] <= 1'b1;
      LED[2] <= 1'b0;
      LED[3] <= 1'b0;
      LED[4] <= out[4];
      LED[5] <= out[5];
      LED[6] <= out[6];
      LED[7] <= out[7];            
end

endmodule
