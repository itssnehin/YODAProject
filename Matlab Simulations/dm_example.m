% 50hz sin signal sampled at 2000 Hz
fs=1/2000;
tn=0:fs:1/25;
m=.5*sin(2*pi*50*tn);
%%Deltamodulation-demodulation
StepSize=1/5;
encode = dm_encode(m,StepSize);
decode = dm_decoder(StepSize,fs,encode);

figure();
subplot(3,1,1);
plot(tn, m);
subplot(3,1,2);
plot(encode);
subplot(3,1,3);
plot(decode);
