function output = dm_encode(data, stepSize)
    % data - array of 8 bit data sample (0-255)
    % stepSize - the 
    % output - array of 8 bit output sample
    
    dLength = length(data);
    delay(1) = 0;
    
    for i = 1 : dLength
        if (data(i) >= delay(i))
            e_n(i) = 1; % encoded
            delay(i+1) = delay(i) + e_n(i)*stepSize;
        else
           e_n(i) = -1;
           delay(i+1) = delay(i) + e_n(i)*stepSize;
        end
    end
    
    output = e_n<0;