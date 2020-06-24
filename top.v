`timescale 1ns / 1ps

module top(
    input CLK100MHZ, // clk
    input start, // start btn
    input reset, // reset btn
    output encoded_bit, // encoded bit
    output [7:0] filtered // filtered decoded result
    );
    
    // ------------ stuff for BRAM ------------------------------
    reg ena = 0;
    reg wea = 0;            // not writing so can be low
    reg [7:0] addra=0;
    reg [7:0] dina=0;      //We're not putting data in, so we can leave this unassigned
    wire signed [7:0] douta;
    
    // -------------stuff for encode ----------------------------
    reg [7:0] delay_enc = 0; // used to store last sample going into encoder
    wire enc_out; // output of the encoder
    
    //-------------- stuff for decode ---------------------------
    reg [7:0] delay_dec = 0; // store last sample out from decoder
    reg [7:0] decode_out = 0; // output of the decoder
    
    
    // ------------- stuff for filter ---------------------------
    reg [7:0]  delay_dec2 = 0; // store 2nd last sample out from decoder
    reg [7:0]  delay_dec3 = 0; // store 2nd last sample out from decoder
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
        .delay(delay_enc),
        .start(start),
        .reset(reset),
        .out(enc_out)
    );
    
    
    decode dec (
        .CLK100MHZ(CLK100MHZ),
        .encode(enc_out),
        .reset(reset),
        .start(start),
        .delay(delay_dec),
        .result(decode_out)
    );
    
    
    filter avg (
        .CLK100MHZ(CLK100MHZ),
        .reset(reset),
        .start(start),
        .current(decode_out),
        .delay(delay_dec),
        .delay2(delay_dec2),
        .delay3(delay_dec3),
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
        delay_enc = douta; // blocking update delay_enc first
        addra = addra + 1; // so that this happens afterwards
        
        delay_dec3 = delay_dec2;
        delay_dec2 = delay_dec;
        delay_dec = decode_out; // update delay val for decoder
        
    end
        
endmodule
