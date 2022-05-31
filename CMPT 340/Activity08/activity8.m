clear all; close all;
clc
%%
load(['data\', 'diagnosis.mat']);
load(['data\', 'GGO_value.mat']);


positive = zeros(1, 51);
negative = zeros(1, 49);
pos = 0;
neg = 0;

for i = 1:100
    if diagnosis(i) == 1
        pos = pos +1;
        positive(pos) = GGO_values(i);
    end
    
    if diagnosis(i) == 0
        neg = neg+1;
        negative(neg) = GGO_values(i);
    end
end

mean_pos = mean(positive);
std_pos = std(positive);

mean_neg = mean(negative);
std_neg = std(negative);

display(['Mean of positive subjects: ', num2str(mean_pos)]);
display(['Std of positive subjects: ', num2str(std_pos)]);

display(['Mean of negative subjects: ', num2str(mean_neg)]);
display(['Std of negative subjects: ', num2str(std_neg)]);

%%
x_pos = (mean_pos-3*std_pos : 0.1 : mean_pos+3*std_pos);
x_neg = (mean_neg-3*std_neg : 0.1 : mean_neg+3*std_neg);

y_pos = normpdf(x_pos, mean_pos, std_pos);
y_neg = normpdf(x_neg, mean_neg, std_neg);

plot (x_pos, y_pos);
xlabel('AI generated GGO score') 
ylabel('Probability') 
hold on
plot (x_neg, y_neg);
legend({'positive','negative'})
hold off

%%
threshold = (0 : 1 : 110);

for i = 0:110
    threshold(2, i+1) = 100*normcdf(i, mean_pos, std_pos);
    threshold(3, i+1) = 100*normcdf(i, mean_neg, std_neg);
end

plot(threshold(2, :), threshold(3, :), '.')
xlabel('(100 - TP)(%)') 
ylabel('TN(%)') 



