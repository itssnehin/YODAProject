function[Sn]=dm_decoder(StepSize,fs,input)
    xlen=length(input);
    Ts=1/fs;
    n=0:Ts:Ts*(xlen-1);
    xlen=length(input);
    delay(1)=0;
    for i = 1 : xlen
        if(input(i)==1)
            delay(i+1)=delay(i)+StepSize;
        else
            delay(i+1)=delay(i)-StepSize;
        end
    end
    
    Sn = delay(2:xlen+1);