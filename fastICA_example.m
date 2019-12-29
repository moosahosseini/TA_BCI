clc
clear
close all



N=500; %data size

v=0:N-1;

sig(1,:)=sin(v/2); %sinusoid
sig(2,:)=((rem(v,23)-11)/9).^5; %funny curve
sig(3,:)=((rem(v,27)-13)/9); %saw-tooth
sig(4,:)=((rand(1,N)<.5)*2-1).*log(rand(1,N)); %impulsive noise

subplot(4,3,1)
plot(sig(1,:))
title('original sources')
subplot(4,3,4)
plot(sig(2,:))
subplot(4,3,7)
plot(sig(3,:))
subplot(4,3,10)
plot(sig(4,:))

%create mixtures

A=rand(size(sig,1));
mixedsig=(A*sig); %% attention!!! rows are channels


subplot(4,3,2)
plot(mixedsig(1,:))
title('mixed sources')
subplot(4,3,5)
plot(mixedsig(2,:))
subplot(4,3,8)
plot(mixedsig(3,:))
subplot(4,3,11)
plot(mixedsig(4,:))


%preform ica to unmix signal
ica = fastica(mixedsig); %% fastICA accepts mixedsig when rows are channels

subplot(4,3,3)
plot(ica(1,:))
title('recovered sources')
subplot(4,3,6)
plot(ica(2,:))
subplot(4,3,9)
plot(ica(3,:))
subplot(4,3,12)
plot(ica(4,:))