clc
clear
Fs=1000;
t= 0:1/Fs :10;
y = sin(2*pi*5*t);

Y1 = [2;-2]*y + 0.25*randn(2,length(y));
Y2 = [0.6;1.68]*y + 0.25*randn(2,length(y));
Y3 = [-3.2;2.2]*y + 0.25*randn(2,length(y));

Data =[Y1',Y2',Y3'];

%% making data zeromean
mean_Data = mean(Data) ;
Data = Data - mean_Data;

%% calculating cov matrix
N = length(y);
covariance = 1/(N-1)*(Data'*Data);
[V,D] = eig(covariance);
Signal = Data*V;

plot(Signal(:,end))
hold on
plot(y,'-r')

disp(['var of Data= ' num2str(var(Data))])
disp(['var of Signal= ' num2str(var(Signal))])