clc
clear all
close all

[fn pn] = uigetfile('Testing\*.png','PNG');

img = imread([pn fn]);

img = imresize(img,[227 227],'bilinear');

if(size(img,3) ~= 3)
    img = cat(3,img,img,img);
end

doTraining = true;

if doTraining == true
    
    data = imageDatastore('Training\', 'IncludeSubfolders',true,'LabelSource','foldernames');
    [dataTrain,dataTest] = splitEachLabel(data,0.8,'randomized');
    dataTrain = shuffle(dataTrain);

    net = alexnet;
    
    layersTransfer = net.Layers(1:end-3);
    
    layers = [layersTransfer
        fullyConnectedLayer(7)
        softmaxLayer
        classificationLayer];
    
    options = trainingOptions('sgdm',...
    'MiniBatchSize',35,...
    'MaxEpochs',50,...
    'InitialLearnRate',0.0001,...
    'Plots','training-progress');

    classifier = trainNetwork(dataTrain,layers,options);
    
    save('CNN_TRIAL.mat','classifier');
else
    load CNN_TRIAL.mat
end

[class, score] = classify(classifier,img);

imshow(img), title(char(class))

