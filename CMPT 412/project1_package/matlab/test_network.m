%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
confusion_matrix = zeros(10, 10);
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~, prediction] = max(P, [], 1);
    [temp, ~] = confusionmat(ytest(i:i+99), prediction);
    confusion_matrix = confusion_matrix + temp;
end
clear temp
confusionchart(confusion_matrix);