`timescale 1ns / 1ps

module top(
    // These signal names are for the nexys A7. 
    // Check your constraint file to get the right names
    input  CLK100MHZ,
    input [7:0] SW,
    input BTNL,      //reset button
    input BTNR,      //start button
    output AUD_PWM, 
    output AUD_SD,
    output reg [7:0] LED
    );
    
//-------------stuff for modules-----------------------------
wire [7:0] val;
wire encoded_bit;
wire signed[8:0] decode_out;
wire signed[8:0] filtered;

 wire reset;
 wire start;
    
// ------------ stuff for BRAM ------------------------------
    reg ena = 0;
    reg wea = 0;            // not writing so can be low
    reg [7:0] addra=0;
    reg [7:0] dina=0;      //We're not putting data in, so we can leave this unassigned
    wire [7:0] douta;
    reg[7:0] counter = 0;
    reg clk = 0;
    reg [14:0] cycle = 0;
    // ------------ Modules -------------------------------------
  blk_mem_gen_0 BRAM (
    .clka(clk),    // input wire clka
    .ena(ena),      // input wire ena
    .wea(wea),      // input wire [0 : 0] wea
    .addra(addra),  // input wire [6 : 0] addra
    .dina(dina),    // input wire [7 : 0] dina
    .douta(douta)  // output wire [7 : 0] douta
    );
      
    Debounce dReset(
       .clk(CLK100MHZ),
       .Button(BTNL),
       .Flag(reset) 
    );
    
    Debounce dStart(
       .clk(CLK100MHZ),
       .Button(BTNR),
       .Flag(start) 
    );
    
    encode enc(
        .CLK100MHZ(clk),
        .data(douta),
        .start(start),
        .reset(reset),
        .out(encoded_bit)
    );
    
    
    decode dec (
        .CLK100MHZ(clk),
        .encode(encoded_bit),
        .reset(reset),
        .start(start),
        .result(decode_out)
    );
    
    
    filter avg (
        .CLK100MHZ(clk),
        .reset(reset),
        .start(start),
        .current(decode_out),
        .result(filtered)
    );
    
    //PWM Out - this gets tied to the BRAM
    wire [8:0] PWM;
    
    // Instantiate the PWM module
    // PWM should take in the clock, the data from memory
    // PWM should output to AUD_PWM (or whatever the constraints file uses for the audio out.
    pwm_module pwm1(CLK100MHZ, PWM, AUD_PWM);
    //----------------------------- main loop ----------------------
    reg i=0;
    always@(posedge CLK100MHZ) begin
      //  PWM <= filtered;
        if(reset) begin
            ena <= 0;
            addra <= 0;
            clk <= 0;
            i <=0;
        end
         else if (start) begin
            ena <= 1; 
            i<=1;          
        end
        
        if(cycle >= 12500) begin
            cycle = 0;
            clk = ~clk;
        end
        
        cycle = cycle + 1;
      
        LED[0] <= i;
       
    end
    
    // end of each clk cycle
    always@(negedge clk) begin
   
        if(counter > 79) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end            
        
        addra = counter; // so that this happens afterwards

    end
    
    assign val = douta;
    assign decode_result = decode_out;
    assign PWM = filtered;
    assign AUD_SD = 1'b1;  // Enable audio out
          
endmodule
