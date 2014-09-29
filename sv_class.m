%This code is to Train a SVM Classifier

%Generating the Parameters for classification
size(signal_energy); %Thus we have 2 parameters for every Test Condition
%Generating the train and test set for Classification
group = [0;1;0;1;0;1;0;1;0;1];
numel(group);
SVMstruct = svmtrain(signal_energy,group,'ShowPlot',true);
Group = svmclassify(SVMstruct,check,'ShowPlot',true);
%SVMModel = fitcsvm(X,Y,'KernelFunction','rbf','Standarize',true,...
%                  'ClassNames',{'negClass','posClass'});
               