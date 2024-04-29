function varargout = Emotion_Charting(varargin)
% EMOTION_CHARTING MATLAB code for Emotion_Charting.fig
%      EMOTION_CHARTING, by itself, creates a new EMOTION_CHARTING or raises the existing
%      singleton*.
%
%      H = EMOTION_CHARTING returns the handle to a new EMOTION_CHARTING or the handle to
%      the existing singleton*.
%
%      EMOTION_CHARTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMOTION_CHARTING.M with the given input arguments.
%
%      EMOTION_CHARTING('Property','Value',...) creates a new EMOTION_CHARTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Emotion_Charting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Emotion_Charting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Emotion_Charting

% Last Modified by GUIDE v2.5 29-May-2019 21:25:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Emotion_Charting_OpeningFcn, ...
                   'gui_OutputFcn',  @Emotion_Charting_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Emotion_Charting is made visible.
function Emotion_Charting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Emotion_Charting (see VARARGIN)

% Choose default command line output for Emotion_Charting
handles.output = hObject;
set(handles.axes1,'xtick',[],'ytick',[])
set(handles.axes2,'xtick',[],'ytick',[])
set(handles.axes3,'visible', 'off');
% id_list=[];
handles.id_list =[];
% p_1=1;
% p_2=1;
% p_3=1;
% p_4=1;
handles.p_1 =1;
handles.p_2 =1;
handles.p_3 =1;
handles.p_4 =1;
handles.p_1_image='1';
handles.p_2_image='1';
handles.p_3_image='1';
handles.p_4_image='1';
handles.new_p1=1;
handles.new_p2=1;
handles.new_p3=1;
handles.new_p4=1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Emotion_Charting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Emotion_Charting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function nametexttag_Callback(hObject, eventdata, handles)
% handles = guidata(hObject);
p_name=get(handles.nametexttag,'String');
setappdata(0,'name',p_name);
% handles.nameofperson = p_name;
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function nametexttag_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function agetexttag_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function agetexttag_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gendststtag_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function gendststtag_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function idtexttag_Callback(hObject, eventdata, handles)
% handles.output = hObject;
% handles = guidata(hObject);

p_id=str2num(get(handles.idtexttag,'String'));
setappdata(0,'id',p_id);


handles.id_list=[p_id handles.id_list];
setappdata(0,'id_list',handles.id_list);
% handles.idofperson =p_id;
% disp(handles.idofperson)
% guidata(hObject, handles);

% handles = guidata(hObject);
% handles.id_list=[handles.idofperson handles.id_list];
% guidata(hObject, handles);
% assignin('base','p_id',handles.id_list)



% --- Executes during object creation, after setting all properties.
function idtexttag_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in starttag.
function starttag_Callback(hObject, eventdata, handles)
addpath('./Resources/')                                                        % directory containing supporting functions

    %% definitions

    %GSR
    
    shimmer_GSR = ShimmerHandleClass('6');
    
    %ECG
    
    shimmer_ECG = ShimmerHandleClass('8');
    SensorMacros = SetEnabledSensorsMacrosClass;                               % assign user friendly macros for setenabledsensors

    fs = 128; 
    fs_ECG=256;% sample rate in [Hz]
    firsttime = true;
    captureDuration=140;

    % Note: these constants are only relevant to this examplescript and are not used
    % by the ShimmerHandle Class
    NO_SAMPLES_IN_PLOT = 5000;                                                 % Number of samples in the plot 
    DELAY_PERIOD = 0.2;                                                        % Delay (in seconds) between data read operations
    numSamples = 0;
    numSamples_ECG = 0;

    %% settings

    % filtering settings
                                                                     
                                                                    
    nPoles = 4;                                                                % number of poles (HPF, LPF)
    pbRipple = 0.5;                                                            % pass band ripple (%)
    
                                                                   % enable (true) or disable (false) highpass filter
    LPF = true;                                                                % enable (true) or disable (false) lowpass filter
                                                                % enable (true) or disable (false) bandstop filter
    
    
   
    % lowpass filters for ExG channels
    if (LPF)
        lpfgsr1ch1 = FilterClass(FilterClass.LPF,fs,fs/2-1,nPoles,pbRipple);
        
    end
    
    %ECG LPF
     % lowpass filters for ExG channels
    if (LPF)
        lpfexg1ch1a = FilterClass(FilterClass.LPF,fs_ECG,fs_ECG/2-1,nPoles,pbRipple);
        lpfexg1ch2a = FilterClass(FilterClass.LPF,fs_ECG,fs_ECG/2-1,nPoles,pbRipple);
        lpfexg2ch1b = FilterClass(FilterClass.LPF,fs_ECG,fs_ECG/2-1,nPoles,pbRipple);
        lpfexg2ch2b = FilterClass(FilterClass.LPF,fs_ECG,fs_ECG/2-1,nPoles,pbRipple);
    end
    

    
    %%
    if ((shimmer_GSR.connect)&(shimmer_ECG.connect))
        shimmer_GSR.setsamplingrate(fs);                                           % Select sampling rate
        shimmer_GSR.setinternalboard('GSR');                                       % Select internal expansion board; select 'ECG' to enable both SENSOR_EXG1 and SENSOR_EXG2 
        shimmer_GSR.disableallsensors;                                             % Disable other sensors
        shimmer_GSR.setenabledsensors(SensorMacros.GSR,1)                          % Enable SENSOR
        
        
        shimmer_ECG.setsamplingrate(fs_ECG);                                           % Select sampling rate
        shimmer_ECG.setinternalboard('ECG');                                       % Select internal expansion board; select 'ECG' to enable both SENSOR_EXG1 and SENSOR_EXG2 
        shimmer_ECG.disableallsensors;                                             % Disable other sensors
        shimmer_ECG.setenabledsensors(SensorMacros.ECG,1)                          % Enable SENSOR

       
        if ((shimmer_GSR.start)&(shimmer_ECG.start))                                                     % TRUE if the shimmer starts streaming 

            plotData_GSR = [];                                               
            timeStamp_GSR = [];
            filteredplotData_GSR = [];
            
             plotData_ECG = [];                                               
            timeStamp_ECG = [];
            filteredplotData_ECG = [];

%             h.figure1=figure('Name','Shimmer GSR signals');                    % Create a handle to figure for plotting data from shimmer
%             set(h.figure1, 'Position', [100, 500, 800, 400]);
           
            elapsedTime = 0;                                                   % Reset to 0    
            tic;                                                               % Start timer

            while (elapsedTime < captureDuration)       

                pause(DELAY_PERIOD);                                           % Pause for this period of time on each iteration to allow data to arrive in the buffer

                [newData,signalNameArray,signalFormatArray,signalUnitArray] = shimmer_GSR.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                
                %ECG
                
                [newData_ECG,signalNameArray_ECG,signalFormatArray_ECG,signalUnitArray_ECG] = shimmer_ECG.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit

                
%                 if (firsttime==true && isempty(newData)~=1)
%                     firsttime = writeHeadersToFile(fileName,signalNameArray,signalFormatArray,signalUnitArray);
%                 end

                if ((~isempty(newData))& (~isempty(newData_ECG)))                                         % TRUE if new data has arrived
                    
                    chIndex(1) = find(ismember(signalNameArray, 'GSR'));
                    chIndex_ECG(1) = find(ismember(signalNameArray_ECG, 'ECG LL-RA'));
                    chIndex_ECG(2) = find(ismember(signalNameArray_ECG, 'ECG LA-RA'));
                    chIndex_ECG(3) = find(ismember(signalNameArray_ECG, 'ECG Vx-RL'));
                    chIndex_ECG(4) = find(ismember(signalNameArray_ECG, 'ECG RESP'));
                    
                    GSRData = newData(:,chIndex);
                    GSRDataFiltered = GSRData;
                    
                    ECGData = newData_ECG(:,chIndex_ECG);
                    ECGDataFiltered = ECGData;
                    % filter the data
                    
                    
                    
                    if LPF % h lowpassfilter to avoid aliasing
                        GSRDataFiltered(:,1) = lpfgsr1ch1.filterData(GSRDataFiltered(:,1));
                        
                    end
                    
                    
                    
                    %ECG
                    if LPF % filter bandstopfiltered data with lowpassfilter to avoid aliasing
                        ECGDataFiltered(:,1) = lpfexg1ch1a.filterData(ECGDataFiltered(:,1));
                        ECGDataFiltered(:,2) = lpfexg1ch2a.filterData(ECGDataFiltered(:,2));
                         ECGDataFiltered(:,3) = lpfexg2ch1b.filterData(ECGDataFiltered(:,3));
                         ECGDataFiltered(:,4) = lpfexg2ch2b.filterData(ECGDataFiltered(:,4));
                    end
                    
%                     dlmwrite(fileName, newData, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format

                    plotData_GSR = [plotData_GSR; GSRData];                            % Update the plotData buffer with the new GSR data
                    filteredplotData_GSR = [filteredplotData_GSR; GSRDataFiltered];    % Update the filteredplotData buffer with the new filtered gsr data
                    numPlotSamples = size(plotData_GSR,1);
                    numSamples = numSamples + size(newData,1); % 1 rep rows
                    timeStampNew = newData(:,1);                                   % get timestamps
                    timeStamp_GSR = [timeStamp_GSR; timeStampNew];
                    
                    
                    %ECG
                    
                    
                    plotData_ECG = [plotData_ECG; ECGData];                            % Update the plotData buffer with the new GSR data
                    filteredplotData_ECG = [filteredplotData_ECG; ECGDataFiltered];    % Update the filteredplotData buffer with the new filtered gsr data
                    numPlotSamples_ECG = size(plotData_ECG,1);
                    numSamples_ECG = numSamples_ECG + size(newData_ECG,1); % 1 rep rows
                    timeStampNew_ECG = newData_ECG(:,1);                                   % get timestamps
                    timeStamp_ECG = [timeStamp_ECG; timeStampNew_ECG];
                    
                    
                    
                    if (numSamples > NO_SAMPLES_IN_PLOT)
                        plotData_GSR = plotData_GSR(numPlotSamples-NO_SAMPLES_IN_PLOT+1:end,:);
                        filteredplotData_GSR = filteredplotData_GSR(numPlotSamples-NO_SAMPLES_IN_PLOT+1:end,:);
                        
                    end
                    
                    if(numSamples_ECG > NO_SAMPLES_IN_PLOT)
                         plotData_ECG = plotData_ECG(numPlotSamples_ECG-NO_SAMPLES_IN_PLOT+1:end,:);
                        filteredplotData_ECG = filteredplotData_ECG(numPlotSamples_ECG-NO_SAMPLES_IN_PLOT+1:end,:);
                    end
                    
                    sampleNumber = max(numSamples-NO_SAMPLES_IN_PLOT+1,1):numSamples;
                    sampleNumber_ECG = max(numSamples_ECG-NO_SAMPLES_IN_PLOT+1,1):numSamples_ECG;
                    
                    signalIndex = chIndex(1);
                    axes(handles.axes1);
                     
                    plot(sampleNumber,filteredplotData_GSR(:,1));              % Plot the filtered gsr for 
                    
                    xlim([sampleNumber(1) sampleNumber(end)]);
                     
                    %ECG
                    signalIndex_ECG1 = chIndex_ECG(1);
                    signalIndex_ECG2 = chIndex_ECG(2);
                    axes(handles.axes2);
                    m=0.5*(filteredplotData_ECG(:,1)+filteredplotData_ECG(:,2));
                    plot(sampleNumber_ECG,m); 
                    
                    xlim([sampleNumber_ECG(1) sampleNumber_ECG(end)]);
                                
                end

                elapsedTime = elapsedTime + toc;                           % Update elapsedTime with the time that elapsed since starting the timer
                tic;                                                       % Start timer           

            end  

            elapsedTime = elapsedTime + toc;                               % Update elapsedTime with the time that elapsed since starting the timer
            fprintf('The percentage of received packets: %d \n',shimmer_GSR.getpercentageofpacketsreceived(timeStamp_GSR)); % Detect loss packets
            shimmer_GSR.stop;                                                  % Stop data streaming                                                    
            shimmer_ECG.stop;  
        end 
      shimmer_GSR.disconnect; 
      shimmer_ECG.disconnect; 
     file_GSR=filteredplotData_GSR(:,1);
     
     
     
     file_ecg=m.';
     
    end
%     handles=guidata(hObject);
    p_id=getappdata(0,'id');
    p_list=getappdata(0,'id_list');
    p_name=getappdata(0,'name');
    if(ismember(p_id,p_list)) 
        if(p_id==1)
            j=strcat(p_name,'GSR');

            a=strcat(j,num2str(handles.p_1),'.mat');
            save(a, 'file_GSR');
            va=load(getlatestfile(pwd));
            value_GSR=va.file_GSR;
            
            
            assignin('base','VALUE_GSR_2',value_GSR)
            
            
            
            h=strcat(p_name,'ECG');
            b=strcat(h,num2str(handles.p_1),'.mat');
            save(b, 'file_ecg');
            value=load(getlatestfile(pwd));
            value_ECG=value.file_ecg;
            
            assignin('base','VALUE_ECG_2',value_ECG)
%              handles = guidata(hObject);
             handles.p_1=handles.p_1 + 1;
%              disp('updated value of handle_1')
%              vc=handles.p_1;
%              disp(vc)
%             handles = guidata(hObject);
%             guidata(hObject,handles);
            guidata(handles.figure1,handles);
%            disp('suspicious')
        end
        if(p_id==2)
            j=strcat(p_name,'GSR');

            a=strcat(j,num2str(handles.p_2),'.mat');
            save(a, 'file_GSR');
            va=load(getlatestfile(pwd));
            value_GSR=va.file_GSR;
            
            
            assignin('base','VALUE_GSR_2',value_GSR)
            
            
            
            h=strcat(p_name,'ECG');
            b=strcat(h,num2str(handles.p_2),'.mat');
            save(b, 'file_ecg');
            value=load(getlatestfile(pwd));
            value_ECG=value.file_ecg;
            
            assignin('base','VALUE_ECG_2',value_ECG)
%              handles = guidata(hObject);
             handles.p_2=handles.p_2 + 1; % This is what is working
%             guidata(hObject,handles);
            guidata(handles.figure1,handles);
        end
       
        if(p_id==3)
            j=strcat(p_name,'GSR');

            a=strcat(j,num2str(handles.p_3),'.mat');
            save(a, 'file_GSR');
            va=load(getlatestfile(pwd));
            value_GSR=va.file_GSR;
            
            
            assignin('base','VALUE_GSR_2',value_GSR)
            
            
            
            h=strcat(p_name,'ECG');
            b=strcat(h,num2str(handles.p_3),'.mat');
            save(b, 'file_ecg');
            value=load(getlatestfile(pwd));
            value_ECG=value.file_ecg;
            
            assignin('base','VALUE_ECG_2',value_ECG)
%              handles = guidata(hObject);
             handles.p_3=handles.p_3 + 1; % This is what is not working
%             guidata(hObject,handles);
guidata(handles.figure1,handles);
        end
        if(p_id==4)
            j=strcat(p_name,'GSR');

            a=strcat(j,num2str(handles.p_4),'.mat');
            save(a, 'file_GSR');
            va=load(getlatestfile(pwd));
            value_GSR=va.file_GSR;
            
            
            assignin('base','VALUE_GSR_2',value_GSR)
            
            
            
            h=strcat(p_name,'ECG');
            b=strcat(h,num2str(handles.p_4),'.mat');
            save(b, 'file_ecg');
            value=load(getlatestfile(pwd));
            value_ECG=value.file_ecg;
            
            assignin('base','VALUE_ECG_2',value_ECG)
%              handles = guidata(hObject);
             handles.p_4=handles.p_4 + 1; % This is what is not working
%             guidata(hObject,handles);
guidata(handles.figure1,handles);
        end

    end
        
        
    
   
    

%     
% disp('reached1')
    
    clear shimmer;
    

    
    gsr=zeros(2,5000);
    comp=zeros(2,5000);

    
    norm_gsr=normalize(value_GSR, 'range');

    data(1,:) = norm_gsr;
    assignin('base','norm_gsr',data(1,:))
    
     norm_ecg=normalize(value_ECG, 'range');
% disp('reached2')
    data(2,:) = norm_ecg;
     assignin('base','norm_ecg',data(2,:))
%     
    [~,signalLength] = size(data);

    fb = cwtfilterbank('SignalLength',signalLength,'VoicesPerOctave',12);
    r = size(data,1);
    
%     disp('reached3')

        if(ismember(p_id,p_list)) 
            if(p_id==1)
                for ii = 1:r
                    cfs = abs(fb.wt(data(ii,:)));
                    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                     
                    if(ii==1)
                       
                       
                        current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_GSR',handles.p_1_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        GSR_image=imread(read_image_path);
                    end
                    if(ii==2)
                       current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_ECG',handles.p_1_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        ECG_image=imread(read_image_path);
                    end
                end
%                 handles = guidata(hObject);
%                  disp('before update')
%                  blue=handles.p_1_image;
%                 disp(blue)
                handles.new_p1=str2num(handles.p_1_image);
                handles.new_p1=handles.new_p1+1;
                handles.p_1_image=num2str(handles.new_p1);
%                 red=handles.p_1_image;
%                 disp('after update')
%                 disp(red)
%                 guidata(hObject,handles);
guidata(handles.figure1,handles);

            end %---id end-----%
            
            if(p_id==2)
                for ii = 1:r
                    cfs = abs(fb.wt(data(ii,:)));
                    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                    if(ii==1)
                    
                        current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_GSR',handles.p_2_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        GSR_image=imread(read_image_path);
                    end
                    if(ii==2)
                       current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_ECG',handles.p_2_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        ECG_image=imread(read_image_path);
                    end
                end
                handles = guidata(hObject);
                handles.new_p2=str2num(handles.p_2_image);
                handles.new_p2=handles.new_p2+1;
                handles.p_2_image=num2str(handles.new_p2);
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);


            end %---id end-----%
              
            if(p_id==3)
                for ii = 1:r
                    cfs = abs(fb.wt(data(ii,:)));
                    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                    if(ii==1)
                    
                        current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_GSR',handles.p_3_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        GSR_image=imread(read_image_path);
                    end
                    if(ii==2)
                       current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_ECG',handles.p_3_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        ECG_image=imread(read_image_path);
                    end
                end
                handles = guidata(hObject);
                handles.new_p3=str2num(handles.p_3_image);
                handles.new_p3=handles.new_p3+1;
                handles.p_3_image=num2str(handles.new_p3);
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);

                
            end
            if(p_id==4)
                for ii = 1:r
                    cfs = abs(fb.wt(data(ii,:)));
                    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                    if(ii==1)
                    
                        current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_GSR',handles.p_4_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        GSR_image=imread(read_image_path);
                    end
                    if(ii==2)
                       current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_ECG',handles.p_4_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        ECG_image=imread(read_image_path);
                    end
                end
                handles = guidata(hObject);
                handles.new_p4=str2num(handles.p_4_image);
                handles.new_p4=handles.new_p4+1;
                handles.p_4_image=num2str(handles.new_p4);
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);

            end
            else
                if(p_id==1)
                    for ii = 1:r
                        cfs = abs(fb.wt(data(ii,:)));
                        im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                        if(ii==1)

                            current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                            mkdir(current_path)
                            imFileName = strcat(p_name,'_GSR',handles.p_1_image,'.png');
                            imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
        %                   
                            read_image_path=fullfile(current_path,imFileName);
                            GSR_image=imread(read_image_path);
                        end
                        if(ii==2)
                           current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                            mkdir(current_path)
                            imFileName = strcat(p_name,'_ECG',handles.p_1_image,'.png');
                            imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
        %                   
                            read_image_path=fullfile(current_path,imFileName);
                            ECG_image=imread(read_image_path);
                        end
                    end
                    
                handles = guidata(hObject);
                handles.new_p1=str2num(handles.p_1_image);
                handles.new_p1=handles.new_p1+1;
                handles.p_1_image=num2str(handles.new_p1);
%                     assignin('base','patient_update',handles.p_1_image)
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);

                end
                if(p_id==2)
                    for ii = 1:r
                        cfs = abs(fb.wt(data(ii,:)));
                        im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                        if(ii==1)

                            current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                            mkdir(current_path)
                            imFileName = strcat(p_name,'_GSR',handles.p_2_image,'.png');
                            imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
        %                   
                            read_image_path=fullfile(current_path,imFileName);
                            GSR_image=imread(read_image_path);
                        end
                        if(ii==2)
                           current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                            mkdir(current_path)
                            imFileName = strcat(p_name,'_ECG',handles.p_2_image,'.png');
                            imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
        %                   
                            read_image_path=fullfile(current_path,imFileName);
                            ECG_image=imread(read_image_path);
                        end
                    end
                handles = guidata(hObject);
                handles.new_p2=str2num(handles.p_2_image);
                handles.new_p2=handles.new_p2+1;
                handles.p_2_image=num2str(handles.new_p2);
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);


                end%---id end-----%
              
            if(p_id==3)
                for ii = 1:r
                    cfs = abs(fb.wt(data(ii,:)));
                    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                    if(ii==1)
                    
                        current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_GSR',handles.p_3_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        GSR_image=imread(read_image_path);
                    end
                    if(ii==2)
                       current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_ECG',handles.p_3_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        ECG_image=imread(read_image_path);
                    end
                end
                handles = guidata(hObject);
                handles.new_p3=str2num(handles.p_3_image);
                handles.new_p3=handles.new_p3+1;
                handles.p_3_image=num2str(handles.new_p3);
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);

                
            end
            if(p_id==4)
                for ii = 1:r
                    cfs = abs(fb.wt(data(ii,:)));
                    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
                    if(ii==1)
                    
                        current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_GSR',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_GSR',handles.p_4_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        GSR_image=imread(read_image_path);
                    end
                    if(ii==2)
                       current_path=fullfile('C:\Users\HP\Desktop\p_scalo/p_ECG',p_name);
                        mkdir(current_path)
                        imFileName = strcat(p_name,'_ECG',handles.p_4_image,'.png');
                        imwrite(imresize(im,[227 227]),fullfile(current_path,imFileName));
    %                   
                        read_image_path=fullfile(current_path,imFileName);
                        ECG_image=imread(read_image_path);
                    end
                end
                handles = guidata(hObject);
                handles.new_p4=str2num(handles.p_4_image);
                handles.new_p4=handles.new_p4+1;
                handles.p_4_image=num2str(handles.new_p4);
%                 guidata(hObject,handles);
                guidata(handles.figure1,handles);

                
            end
        end%---in list----%
        

    
    load CNN.mat       %GSR
[class, score] = classify(classifier,GSR_image);


gsr_score = score;

load ECG_CNN.mat    %ECG
[class, score] = classify(classifier,ECG_image);
ecg_score=score;

for n=1:7
    SCORE_NEW(n)=0.5*(gsr_score(n)+ecg_score(n));
end

assignin('base','score',SCORE_NEW)
axes(handles.axes3);
a=double(SCORE_NEW);
pie(a,{'Anger','Disgust','Fear','Happy','Neutral','Sad','Surprise'})
a1 ='https://ec-device-56629.firebaseio.com/';
id1='ECG'; % assigning input id
json='.json';
%concatenating the url
url1=strcat(a1,id1); 
Firebase_Url1=strcat(url1,json);
% current date 
e1 = today('datetime'); 
%assigning the emotion values to struct data
data1=struct;
data1.signal=file_ecg(:,1:900);
data1.date=e1; %current date
options1 = weboptions('MediaType','application/json'); %defining data as .json object
response1=webwrite(Firebase_Url1,data1,options1);  

 % sending gsr signals to the firebase
a2 ='https://ec-device-56629.firebaseio.com/';
id2='GSR'; % assigning input id
json='.json';
%concatenating the url
url2=strcat(a2,id2); 
Firebase_Url2=strcat(url2,json);
% current date 
e2= today('datetime'); 
%assigning the emotion values to struct data
data2=struct;
data2.signal=file_GSR(1:900,:);
data2.date=e2; %current date
options2= weboptions('MediaType','application/json'); %defining data as .json object
response2=webwrite(Firebase_Url2,data2,options2);  





p_name=getappdata(0,'name');
a='https://ec-device-56629.firebaseio.com/';
id='expression'; % assigning input id
json='.json';
%concatenating the url
url=strcat(a,id); 
Firebase_Url=strcat(url,json);
% current date 
e = today('datetime'); 
% n='Aqsa';
d='Fever';
ob='20 Aug 1997';
%assigning the emotion values to struct data
data=struct;
data.anger=SCORE_NEW(1)*100;
data.disgust=SCORE_NEW(2)*100;
% % % % % % % % % % % % % % % % % % % % % % data.fear=SCORE_NEW(3)*100;
data.happy=SCORE_NEW(4)*100;
data.neutral=SCORE_NEW(5)*100;
data.sad=SCORE_NEW(6)*100;
data.surprise=SCORE_NEW(7)*100;
data.date=e; %current date
data.name=p_name;
data.disease=d;
data.dob=ob;
options = weboptions('MediaType','application/json'); %defining data as .json object
response=webwrite(Firebase_Url,data,options);  


% pause(15)
% set(handles.axes1,'xtick',[],'ytick',[])
% cla(handles.axes1)
% 
% set(handles.axes2,'xtick',[],'ytick',[])
% cla(handles.axes2)
% 
% cla(handles.axes3)
% t = timer;
% t.StartDelay = 60;
% pause(300)
% % t.TimerFcn = @(myTimerObj, thisEvent)starttag_Callback(@starttag_Callback,eventdata, handles);
% starttag_Callback(@starttag_Callback,eventdata, handles);
% start(t)

% pause(20);
% disp('Hello');
