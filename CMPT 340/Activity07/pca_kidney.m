%% CMPT340 - Activity 7: Kidney PCA 
%
% *Goal*
% In this assignment, we will apply PCA on 3D point clouds of kidneys.
% This will allow us to create a model that learns how kidneys deform.
% We will be able to manipulate this model and it will deform based on the
% variations found in our dataset.
%
%
% *Data files*
% The data files are under the folder ./kidneys_3d_points:
% The folder contains sets of 3D points for 20 kidneys.
%
% *Instructions*
% The questions and specific instructions are given below. We have included
% some "checks" with answers to allow you to see if certain parts of your
% code corresponds to what we expect. If you have the same answers, 
% this should help confirm that you are on the right track.
%
% Some of the instructions are not specific questions, but are there
% to help guide you through the work.
% 
% Whenever you see:
%
% %--------- Your Code Here ------%
%
% %-------------------------------%
%
% You should enter your code in that area. 
%
% You don't have to submit anything for this activity. The solution key
% will be posted afterwards.
% 
%
% *Save your results*
% please save your results as .gif under the folder ./html
% you should still be able to visualize your results using generic image viewer
% after closing MATLAB

% Clean up
clear all; close all;
clc

if ~exist('html')
    mkdir('html')
end

%% Q. Load and display the sample data
% Load the file "DeformedObject (13).mat" into variable K13.
% Use plot3 to plot all the point as small dots.
% Do not connect the dots together.

%--------- Your Code Here ------%
load (['kidneys_3d_points\','DeformedObject (13).mat']);
K13 = DeformedObject;
plot3 (K13(:,1),K13(:,2),K13(:,3),'.');
%-------------------------------%

% *** check ***
display(sprintf('Load data check (size): %i', isequal(size(K13),[1924,3])))
display(sprintf('Load data check (coordinate): %i', round(K13(1924,1))==41));


%% Find how many 3D points (landmarks) there are.
% Save the answer in variable L

%--------- Your Code Here ------%
[L,~] = size(K13);

%-------------------------------%
display(sprintf('Num Landmark check: %i',L == 1924))

%% Q. Create observation matrix
% Convert K13 into a single column observation by stacking the x coordinates, 
% the y coordinates, then the z coordinates all below each other

%--------- Your Code Here ------%
K13 = K13(:);
%x = 1:1924;
%plot3 (K13(x,1),K13(x+1924,1),K13(x+3848,1),'.');

%-------------------------------%

% *** check ***
display(sprintf('K13 column check (size): %i', isequal(size(K13),[5772,1])))
display(sprintf('K13 column check (value): %i', round(K13(5769))==16))
%%


%% Q. Load all data files and save all the data into an observation matrix X
% the resulting X should have:
% number of rows = number of observations (i.e. number of kidneys);
%
% number of columns = number of 3D points per kidney * 3 (we multiply by 3
% as each point has x,y and z coordinates);
%
%         

%--------- Your Code Here ------%
for i = 1:20
    load (['kidneys_3d_points\',[sprintf('DeformedObject (%d)', i), '.mat']]);
    X(i,:) = DeformedObject(:);
end

%-------------------------------%

% *** check ***
display(sprintf('X size:%i',isequal(size(X),[20,5772])));
% check some sample coordinates
display(sprintf('X values:%i', isequal(round(X(10,20)),43)));
display(sprintf('X values:%i', isequal(round(X(19,4000)),66)));


%% Q. Plot all data 
% Write a for loop that will display, one at a time, all kidneys using plot3
% Create a GIF of each kidney and export the figures under the html folder.
fAllData = figure(1);
%--------- Your Code Here ------%
axis tight manual
filename = ['html\','ALL.gif'];

i = 1:20;
x = 1:L;
plot3 (X(i,x),X(i,x+L),X(i,x+2*L),'.');
drawnow

frame = getframe(fAllData); 
im = frame2im(frame); 
[imind,cm] = rgb2ind(im,256);
if i==20
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
else
    imwrite(imind,cm,filename,'gif','WriteMode','append'); 
end

%-------------------------------%
close(fAllData)
%%

%% Q. The mean kidney
% Calculate and plot the "mean kidney" shape. 
% The mean kidney is the kidney produced by taking the mean of all the
% kidney data. It should look like an "average" kidney.

%--------- Your Code Here ------%
for i = 1:5772
    mn_temp(i) = mean(X(:,i));
end
mn = mn_temp.';
plot3 (mn(x,1),mn(x+L,1),mn(x+2*L,1),'.')


%-------------------------------%

% *** check ***
display(sprintf('mean size check: %i', isequal(size(mn), [5772,1])));
% random check
display(sprintf('mean val check: %i', isequal(round(mn(1000:1005))', [ 51    54    53    58    56    62])));



%% Q. Apply PCA
% Perform PCA using the _pca()_ command. Make sure to compute the eigenvectors,
% scores, and eigenvalues.
% note that PCA sorts output eigenvalue magnitudes in decreading order
%                                                                  

%--------- Your Code Here ------%
[coeff, score, latent] = pca(X);

%-------------------------------%


%% Q. Extract PC1
% Extract the eigenvector with the largest eigenvalue and save it in
% a column variable PC1

%--------- Your Code Here ------%
PC1 = coeff(:,1);

%-------------------------------%
display(sprintf('PC1 check:%i',isequal(round((PC1(100,1))*10^7),1444))); 

%% Q. Create a new shape along PC1 
% Create a new shape Xn by moving one *unit* along PC1 away
% from the mean. Represent Xn as a column vector.
%--------- Your Code Here ------%
Xn = mn + PC1;

%-------------------------------%
display(sprintf('PC1 shape check:%i', isequal(round(Xn(200:205,1)'), [59    35    39    55    32    55])));


%% Q. Plot the shape from PC1
% Plot this new shape _Xn_ in 3D.
% Hint: This should look somewhat like a kidney still.

figure(2)
%--------- Your Code Here ------%
plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');

%-------------------------------%


%% Q. Extract PC2
% Extract the eigenvector with the 2nd largest eigenvalue and save it
% in a column variable PC2 AND save its corresponding eigenvalue in variable l2

%--------- Your Code Here ------%
PC2 = coeff(:,2);
v2 = latent(2, 1);

%-------------------------------%
display(sprintf('PC2 check:%i', isequal(round(PC2(2000:2005,1)'*10^7), [-26968      -18511      -21273      -28805      -24438      -26308])));
display(sprintf('v2 check:%i', isequal(round(v2), 3113)));


%% Q. Create and plot the PC2 shape
% Create a new shape (also Xn) by moving 3 standard deviations along PC2
% away from the mean. Note that the eigenvector should be *appropriately* 
% weighted by it's correpsonding eigenvalue.
% Hint: This should look like a kidney.

%--------- Your Code Here ------%
Xn = mn + 3*PC2;

%-------------------------------%

% plot the shape in 3D
figure(3)
%--------- Your Code Here ------%
plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
%-------------------------------%

display(sprintf('PC2 shape: %i', isequal(round(Xn(1:5))', [46    43    45    45    52])));


%% Q. Moving along the first 3 PCs to generate new kidneys
% Plot the shape changes as the PCs are varied independently
% Write a loop that shows how the kidney changes when a single principal
% component (PC) is changed and the rest are fixed.
%
% We will only change the first 3 PCs.
%
% We will only allow the kidneys to change between -5 and +5 standard deviations
% so we get deformations that could be clearly visualized.
%
% We will also plot them so all appear in the same figure.
%
% Create a GIF and make sure it is saved under the html folder along with
% other figures


% Create our figure.
hFig = figure(4);

% Make it a bit larger so we can see the kidneys better. You might need to
% adjust this based on your screen size.
set(hFig, 'Position', [50 50 1500 400])

% Loop from -5 to +5 standard deviations, where we change by 0.1 standard
% deviation in each iteration.
for k=-5:0.1:5
    
    % Change PC1 goes here...    
    subplot(1,3,1);    
    
    %--------- Your Code Here ------%
    Xn = mn+k*PC1;
    plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
    
	%-------------------------------%
	
    % We add a title so we can see the standard deviation change.
    title(sprintf('PC1: %.3f', k));
    axis([0 100 0 150 0 100])
    axis image;
    
    % Change PC2
    subplot(1,3,2);
    %--------- Your Code Here ------%
    Xn = mn+k*PC2;
    plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
    
    %-------------------------------%    
    title(sprintf('PC2: %.3f', k));
    %axis([0 100 0 150 0 100])
    axis image
    
    % Change PC3
    subplot(1,3,3);
    %--------- Your Code Here ------%
    Xn = mn+k*coeff(:,3);
    plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
    
    %-------------------------------%    
    title(sprintf('PC3: %.3f', k));
    %axis([0 100 0 150 0 100])
    axis image;     
    
    drawnow;
        
    %%%%%%% GIF code.
    filename = fullfile('html','pcChange.gif');
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == -5
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    %%%%%%%
    
    pause(0.05)
end
close(hFig);
%%


%% Q. Rough description of what happens when the PCs change
% Above we only changed 1 PC independently (fix the others, only change one) 
% In words, give a brief description of how the kidney subtely changes as we change each PC.
% Hint: Examine/rotate each kidney at the end of the above loop, and see
% in what ways the kidneys differ. 
% e.g. Does changing one PC stretch a specific part of the kidney?
% e.g. Does changing one PC cause the kidney to compress/expand?

pc1str = 'When PC1 increases, the kidney ';
%----- Your description here ------%
myPc1Description = 'compress';

%----------------------------------%
display([pc1str, myPc1Description]);

pc2str = 'When PC2 increases, the kidney ';
%----- Your description here ------%
myPc2Description = 'compress';

%----------------------------------%
display([pc2str, myPc2Description]);

pc3str = 'When PC3 increases, the kidney ';
%----- Your description here ------%
myPc3Description = 'compress';

%----------------------------------%
display([pc3str, myPc3Description]);


%% Q. Come up with 3 interesting shapes
% Instead of changing 1 PC and fixing the rest, we can change the first 3 PCs at
% the same time. Come up with 3 interesting shapes where the first 3 PCs
% have different non-zero weightings.
%
% Deform between -500 and +500 standard deviations
% so we get deformations that could be clearly visualized.
% 
% Put the standard deviations values that you used in the title.

figure(5);
%--------- Your Code Here ------%
Xn = mn+PC1+2*PC2+3*coeff(:,3);
plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
pc1std = 1;
pc2std = 2;
pc3std = 3;

%-------------------------------%
title(sprintf('PC1: %.2f, PC2: %.2f, PC3: %.2f', pc1std,pc2std,pc3std));
axis image;

%%
figure(6);
%--------- Your Code Here ------%
Xn = mn-PC1-2*PC2-3*coeff(:,3);
plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
pc1std = -1;
pc2std = -2;
pc3std = -3;

%-------------------------------%
title(sprintf('PC1: %.2f, PC2: %.2f, PC3: %.2f', pc1std,pc2std,pc3std));
axis image;

%%
figure(7);
%--------- Your Code Here ------%
Xn = mn+PC1+PC2+coeff(:,3);
plot3 (Xn(x,1),Xn(x+L,1),Xn(x+2*L,1),'.');
pc1std = 1;
pc2std = 1;
pc3std = 1;

%-------------------------------%
title(sprintf('PC1: %.2f, PC2: %.2f, PC3: %.2f', pc1std,pc2std,pc3std));
axis image;
%%