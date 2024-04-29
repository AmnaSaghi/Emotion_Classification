close all
clear all
clc
              %%%%%%%%%%% Counter initialization %%%%%%%%%%%%
neutral=1;
disgust=1;
sad=1;
happy=1;
anger=1;
surprise=1;
fear=1;
                %%%%%%%%%%% Spectrogram parameters %%%%%%%%%%%%%%

window=hamming(256);
noverlap=148;
nfft=128;
fs=128;


    load('SMOTE_ECG_Surprise.mat')
for i=1:96
    data=AVG_ECG_STRUCT.AVG_ECG(i,1:7229);





    S=spectrogram(data,window,noverlap,nfft,fs,'yaxis');

    xlabel('time');
    ylabel('Frequency hz');
    figure
    J = imresize(S,[227 227]);
    imshow(J,[]);
    
    
    
      redChannel = J(:,:,1); % Red channel
    greenChannel = J(:,:,1); % Green channel
    blueChannel = J(:,:,1); % Blue channel
    allBlack = zeros(size(J, 1), size(J, 2), 'uint8');
    just_red = cat(3, redChannel, allBlack, allBlack);
    just_green = cat(3, allBlack, greenChannel, allBlack);
    just_blue = cat(3, allBlack, allBlack, blueChannel);
    % Recombine the individual color channels to create the original RGB image again.
    recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);
    %imwrite(recombinedRGBImage,strcat('neutral',num2str(neutral),'.png'),'png')
    imwrite(recombinedRGBImage,strcat('Surprise',num2str(anger),'.png'),'png')
    
   %imwrite(J,strcat('Anger',num2str(anger),'.png'),'png')
    anger=anger+1;

%anger if/else

% if isequal(GSR_STRUCT.Label{i,1},'Fear')        %fear
% 
% 
%     S=spectrogram(data,window,noverlap,nfft,fs,'yaxis');
% 
%     xlabel('time');
%     ylabel('Frequency hz');
%     figure
%     J = imresize(S, [227 227]);
%     imshow(J,[]);c
%     
%     
%     
%       redChannel = J(:,:,1); % Red channel
%     greenChannel = J(:,:,1); % Green channel
%     blueChannel = J(:,:,1); % Blue channel
%     allBlack = zeros(size(J, 1), size(J, 2), 'uint8');
%     just_red = cat(3, redChannel, allBlack, allBlack);
%     just_green = cat(3, allBlack, greenChannel, allBlack);
%     just_blue = cat(3, allBlack, allBlack, blueChannel);
%     % Recombine the individual color channels to create the original RGB image again.
%     recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);
%     %imwrite(recombinedRGBImage,strcat('neutral',num2str(neutral),'.png'),'png')
%     imwrite(recombinedRGBImage,strcat('Fear',num2str(fear),'.png'),'png')
%     
%     %imwrite(J,strcat('Fear',num2str(fear),'.png'),'png')
%     fear=fear+1;
% 
% end%fear if/else
% 
% if isequal(GSR_STRUCT.Label{i,1},'Sad')       %sad
% 
%     S=spectrogram(data,window,noverlap,nfft,fs,'yaxis');
% 
%     xlabel('time');
%     ylabel('Frequency hz');
%     figure
%     J = imresize(S, [227 227]);
%     imshow(J,[]);    
%     
%     
%       redChannel = J(:,:,1); % Red channel
%     greenChannel = J(:,:,1); % Green channel
%     blueChannel = J(:,:,1); % Blue channel
%     allBlack = zeros(size(J, 1), size(J, 2), 'uint8');
%     just_red = cat(3, redChannel, allBlack, allBlack);
%     just_green = cat(3, allBlack, greenChannel, allBlack);
%     just_blue = cat(3, allBlack, allBlack, blueChannel);
%     % Recombine the individual color channels to create the original RGB image again.
%     recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);
%     %imwrite(recombinedRGBImage,strcat('neutral',num2str(neutral),'.png'),'png')
%     imwrite(recombinedRGBImage,strcat('Sad',num2str(sad),'.png'),'png')
%     
%    %imwrite(J,strcat('Sad',num2str(sad),'.png'),'png')
%     sad=sad+1;
% 
% end %sad if-else end
% 

end


