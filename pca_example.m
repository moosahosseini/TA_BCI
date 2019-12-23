clear 
clc
close all
N = 500; % number of samples
%% PCA example
% e.g. 1 - high redundancy dataset
% constrcting dataset 1
sigm1 = [2 1.9;1.9 2];
mu1 = [2 2];
d1=mvnrnd(mu1,sigm1,N);
figure(1)
plot(d1(:,1),d1(:,2),'+');
title('High Redundancy')
grid on
hold on
[p1]= pca(d1');% applying PCA to compute P.C.

%plotv(p1','-') %% each column of p1 is P.C.
axis square
p11 = p1;
p11(1,:) = p11(1,:)/norm(p11(1,:));
p11(2,:) = p11(2,:)/norm(p11(2,:));
 quiver(0,0,p11(1,1),p11(1,2),'LineWidth',8)
 quiver(0,0,p11(2,1),p11(2,2),'LineWidth',8)
% e.g. 2 - low redundancy dataset

sigm2 = [2 0.1;0.1 2];
mu2 = [0 0];
d2=mvnrnd(mu2,sigm2,N);
figure(2)
plot(d2(:,1),d2(:,2),'+k');
hold on
title('Low Redundancy')
grid on
p2 = pca(d2');% applying PCA to compute P.C.
%plotv(p2') %% each column of p2 is P.C.
p22 = p2;
p22(1,:) = p22(1,:)/norm(p22(1,:));
p22(2,:) = p22(2,:)/norm(p22(2,:));
 quiver(0,0,p22(1,1),p22(1,2),'LineWidth',8)
 quiver(0,0,p22(2,1),p22(2,2),'LineWidth',8)

% 
% %%%%%%%%%%%%%%%%
% R1 = d1'*d1;
% R2 = d2'*d2;
% 
% %%%%%%%%%% sparse PCA
% %%using CVX toolbox
% 
% 
% cvx_begin
% variables V(2,2)
% minimize (-1*trace(R1*V))
% 
% subject to
% trace(V)=1;
% [1 1]*abs(V)*[1 1]'<=1;
% V>=0;
% 
% cvx_end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% % Fs = 10000;
% % t = 0 : 1/Fs : 1;
% % sig1 = sin(2*pi*t*1000);                         % Create 1000 Hz Tone
% % % sound(5*sig1, Fs)                                % Sounds Normal
% % % pause(2)
% % sig2 = sin(2*pi*t*4000);                          % Create 4000 Hz Tone
% % % % % sound(5*sig, 0.75*Fs)                           % Sounds Lower
% % % % % pause(2.5)
% % % % % sound(5*sig, 1.25*Fs)                           % Sounds Higher 
% % dataset = [sig1(1:1000)',sig2(1:1000)'];
% % p3 = pca(dataset);% applying PCA to compute P.C.
% % 
% % plotv(p3) %% each column of p2 is P.C.