`timescale 1ns / 1ps

module top(
    input CLK100MHZ, // clk
    input start, // start btn
    input reset, // reset btn
    output [7:0] val, // value from memory
    output encoded_bit, // encoded bit
    output signed [7:0] decode_out,
    output signed [7:0] filtered // filtered decoded result
    );
    
    // ------------ stuff for BRAM ------------------------------
    reg ena = 0;
    reg wea = 0;            // not writing so can be low
    reg [3:0] addra=0;
    reg [7:0] dina=0;      //We're not putting data in, so we can leave this unassigned
    wire [7:0] douta;
    
    // -------------stuff for encode ----------------------------
    
    //-------------- stuff for decode ---------------------------
    
    
    // ------------- stuff for filter ---------------------------
   
    // ------------ Modules -------------------------------------
    blk_mem_gen_0 BRAM_DUT(
        .clka(CLK100MHZ),     // input wire clka
        .ena(ena),            // input wire ena               // ena = read enable
        .wea(wea),            // input wire [0 : 0] wea       // wea = write enble
        .addra(addra),        // input wire [7 : 0] addra
        .dina(dina),          // input wire [7 : 0] dina
        .douta(douta)         // output wire [7 : 0] douta
    );
    
    encode enc(
        .CLK100MHZ(CLK100MHZ),
        .data(douta),
        .start(start),
        .reset(reset),
        .out(encoded_bit)
    );
    
    
    decode dec (
        .CLK100MHZ(CLK100MHZ),
        .encode(encoded_bit),
        .reset(reset),
        .start(start),
        .result(decode_out)
    );
    
    
    filter avg (
        .CLK100MHZ(CLK100MHZ),
        .reset(reset),
        .start(start),
        .current(decode_out),
        .result(filtered)
    );
    
    
    //----------------------------- main loop ----------------------
    
    always@(posedge CLK100MHZ) begin
        if(reset == 1) begin
            ena <= 0;
            addra <= 0;
        end
        else if (start == 1) begin
            ena <= 1;
        end
    end
    
    // end of each cycle
    always@(negedge CLK100MHZ) begin
        
        addra = addra + 1; // so that this happens afterwards

    end
    
    assign val = douta;
    assign decode_result = decode_out;
        
endmodule
