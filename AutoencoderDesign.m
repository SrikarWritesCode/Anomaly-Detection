clear all
clc
load('mfcc_train_toycar.mat')
load('toycartrain.mat')
load('mfcc_test_toycar_anomally.mat')
load('net_training.mat')
load('layers.mat')
load('toycartest_normal.mat')
load('options.mat')
load('mfcc_test_toycar_normal.mat')
load('toycartest_anomally.mat')

MFCCs = reshape(MFCCs,[1,(12*1098)]);
MFCCs_test_n = reshape(MFCCs_test_n,[1,(12*1098)]);
MFCCs_test_a = reshape(MFCCs_test_a,[1,(12*1098)]);

% featuresAfter = MFCCs;
%%Construct the LSTM autoencoder network and set the training
%%options.(uncoment to toggle the options)
% featureDimension = 1;
%
% % Define biLSTM network layers
% layers = [ sequenceInputLayer(featureDimension, 'Name', 'in')
%    bilstmLayer(16, 'Name', 'bilstm1')
%    reluLayer('Name', 'relu1')
%    bilstmLayer(32, 'Name', 'bilstm2')
%    reluLayer('Name', 'relu2')
%    bilstmLayer(16, 'Name', 'bilstm3')
%    reluLayer('Name', 'relu3')
%    fullyConnectedLayer(featureDimension, 'Name', 'fc')
%    regressionLayer('Name', 'out') ];
%
% % Set Training Options
% options = trainingOptions('adam', ...
%    'Plots', 'training-progress', ...
%    'MiniBatchSize', 500,...
%    'MaxEpochs',4000);

% net = trainNetwork(featuresAfter, featuresAfter, layers, options);

testcase = [MFCCs_test_a MFCCs_test_n];
yHatAll = predict(net, testcase);
errorAll = helperCalculateError(testcase, yHatAll);

thresh = 0.5;
anomalies = errorAll > thresh*mean(errorAll);
anomalies = reshape(anomalies,[12,2196]);
re_anomalies = reshape(anomalies,[12,2196]);
sum_err = zeros(2169);
for err = 1:2196
    sum_err(err) = sum(re_anomalies(:,err));
end

acc = 0;
for ind = 1:2196
    if sum_err(ind)>2
        acc = acc+1;
    else
        acc = acc;
    end
end
accuracy = (1 - (acc/2196))*100
