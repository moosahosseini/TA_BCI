%%% SSVEP example using CCA
%% Dec 2018
%%

clc
clear
close all

load('SSVEP_DATA_S');

%%%%%%%%% three classes of data for 3 stimulus at 13,17 and 21 Hz
%%
N_Seg = 1;%% If N_Seg=1--->Trial Lenghth=5s ,

for i=1:size(Data_Class1,2)%%%%% for trials
    for j=1:size(Data_Class1{i},2)%%%% for channels
        D_Class1{i}(j,:,:) = reshape(Data_Class1{i}(:,j),[],N_Seg)';%%D_class=160 cell each channel no*N_seg*(signal length/N_seg) 
        D_Class2{i}(j,:,:) = reshape(Data_Class2{i}(:,j),[],N_Seg)';
        D_Class3{i}(j,:,:) = reshape(Data_Class3{i}(:,j),[],N_Seg)';
        
    end
end
%%
L=1;
for i=1:size(D_Class1,2)
    for j=1:size(D_Class1{i},2)
        S_Class1{L} = squeeze(D_Class1{i}(:,j,:));%%% s_class = 160* N_seg each cell= channel no*(signal length/N_seg)
        S_Class2{L} = squeeze(D_Class2{i}(:,j,:));
        S_Class3{L} = squeeze(D_Class3{i}(:,j,:));
        L = L+1;
    end
end
%%

DATA_ALL{1} = S_Class1;   DATA_ALL{2} = S_Class2;   DATA_ALL{3} = S_Class3;


for ClaSS=1:size(DATA_ALL,2) %% Size(DATA_ALL,2) = N_Stimulus
    
%% CLASS %% Class1  = 13 Hz %% Class2 = 21 Hz %% Class3 = 17 Hz %% 
DATA_SSVEP = DATA_ALL{ClaSS};
LABEL_SSVEP = ClaSS;
%% %% %% %%

%% Method 


t = linspace(0,5/N_Seg,size(DATA_SSVEP{1},2));
H_1 = [cos(2*pi*13*t);sin(2*pi*13*t);cos(4*pi*13*t);sin(4*pi*13*t)];  %% stimulus at 13Hz and its second harmonic
H_2 = [cos(2*pi*21*t);sin(2*pi*21*t);cos(4*pi*21*t);sin(4*pi*21*t)];  %% stimulus at 21Hz and its second harmonic
H_3 = [cos(2*pi*17*t);sin(2*pi*17*t);cos(4*pi*17*t);sin(4*pi*17*t)];  %% stimulus at 17Hz and its second harmonic
%%%%

Nch=1; %% U can choose btw 1 to 8 EEG channels
chstr = {'Oz ','O1 ','O2 ','PO3 ','POz ','PO7 ','PO8 ','PO4 '};

 for i = 1:size(DATA_SSVEP,2)
        %%
        Signal = DATA_SSVEP{i}(1:Nch,:);
        Signal=Signal';
        Fs = 256;
        [b,a] = butter(2,[49.5 50.5]/(Fs/2),'stop');
        Signal = filtfilt(b,a,Signal);
        % Method 1
        [~,~,CORR_R1(i,:)] = canoncorr(Signal,H_1');
        [~,~,CORR_R2(i,:)] = canoncorr(Signal,H_2');
        [~,~,CORR_R3(i,:)] = canoncorr(Signal,H_3');
        
        CORR_ALL = [max(CORR_R1(i,:));max(CORR_R2(i,:));max(CORR_R3(i,:))];
        
        [M(i) Label(i)] = max(CORR_ALL');
    end
%%%[Label{ClaSS}] = BCI_BEHROOZI_SSVEP(DATA_SSVEP,LABEL_SSVEP,Mode,N_Seg);%%% output is predicted label from function

%% Validation 
Perf(ClaSS) = length(find(Label==LABEL_SSVEP))/length(Label);

clear Label

%%L_trial = 5/N_Seg;

Stimulus =[13,21,17];
length_Signal =[5 2.5 1.25 1 0.5;1 2 4 5 10];
AAA= find(length_Signal(2,:)==N_Seg);
disp(['Channels= ',chstr{1:Nch}, ' Stimulus = ',num2str(Stimulus(ClaSS)),'   Performance=  ', num2str(100*Perf(ClaSS))])

end
Average_Perf = mean(Perf);
disp(['    Average Performance =    ', num2str(100*Average_Perf)])

