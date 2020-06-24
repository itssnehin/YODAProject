`timescale 1ns / 1ps

module top_tb();

reg CLK100MHZ = 0;
reg start = 0;
reg reset = 0;
wire signed [7:0] decode_result;
wire signed [7:0] value;
wire encoded_bit;
wire signed [7:0] result;

top uut (
    .CLK100MHZ(CLK100MHZ),
    .start(start),
    .reset(reset),
    .val(value),
    .decode_out(decode_result),
    .encoded_bit(encoded_bit),
    .filtered(result)
);

initial begin
    reset = 1;
    #100
    reset = 0;
    #100
    start = 1;    
end

always #5 CLK100MHZ = ~CLK100MHZ;

endmodule
