module bin2bcd(
   input [7:0] binary,
    output reg [3:0] hundreds =0 ,
    output reg [3:0] tens = 0,
    output reg [3:0] ones = 0
    ); 
reg [29:0]shifter=0; 
integer i; 
always@(binary) 
begin 
    shifter[7:0] = binary; 
    
    for (i = 0; i< 8; i = i+1) begin 
        if (shifter[17:14] >= 5) 
            shifter[17:14] = shifter[17:14] + 3; 
        if (shifter[21:18] >= 5)             
            shifter[21:18] = shifter[21:18] + 3;
        if (shifter[25:22] >= 5)             
            shifter[25:22] = shifter[25:22] + 3; 
        if (shifter[29:26] >= 5)              
            shifter[29:26] = shifter[29:26] + 3; 
        shifter = shifter  << 1;    
      
    end  

    hundreds = shifter[25:22];
    tens = shifter[21:18];
    ones = shifter[17:14];
end
endmodule