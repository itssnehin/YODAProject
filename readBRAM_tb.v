`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2020 14:26:50
// Design Name: 
// Module Name: readBRAM_tb
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





module readBRAM_tb();
// a very simple tb to just read the values from the LUT_8byte_decimal.coe file 

reg CLK100MHZ = 0;
// Memory IO
reg ena = 0;
reg wea = 0;            // not writing so can be low
reg [7:0] addra=0;
reg [7:0] dina=0;      //We're not putting data in, so we can leave this unassigned
wire [7:0] douta;

blk_mem_gen_0 BRAM_DUT(
  .clka(CLK100MHZ),     // input wire clka
  .ena(ena),            // input wire ena               // ena = read enable
  .wea(wea),            // input wire [0 : 0] wea       // wea = write enble
  .addra(addra),        // input wire [7 : 0] addra
  .dina(dina),          // input wire [7 : 0] dina
  .douta(douta)         // output wire [7 : 0] douta
  );
  
task readData;
    begin
        addra <= addra + 1;
    end
endtask


initial begin
    // intialize inputs
    CLK100MHZ = 0;
    addra = 0;
    
    #100;
    ena <= 1;       // read enable high
end

always #5 CLK100MHZ = ~CLK100MHZ;

always @ (posedge CLK100MHZ) begin
    readData;       // read the data from the LUT
end

endmodule
