clear all
clc
ECGdata=zeros(20,7229);
Label=cell(20,1);
row=1;

for k=1:40
    
    load(['Data_Preprocessed_P' num2str(k) '.mat'])
    
    
for i=1:20

    Person1_Trial1_data=joined_data{1,i};
    
    
    if(isempty(Person1_Trial1_data))
        Label(i,1)={'Empty'};
        ECGdata(i,1:7229)=0;
        continue
    end
    
    
    ECG_Channel1=Person1_Trial1_data(:,15); % ECG at 15
    ECG_Channel2=Person1_Trial1_data(:,16); % ECG at 16


    c1=ECG_Channel1(1:7229,1);
    c2=ECG_Channel2(1:7229,1);


    data_c1=c1.';
    data_c2=c2.';
    
    
    check_c1=isnan(data_c1);
    check_c2=isnan(data_c2);
    if(check_c1==1 | check_c2==1)
        Label(i,1)={'NAN'};
        ECGdata(i,1:7229)=0;
        continue
    end
    % make a matrix contains 20 rows and 7229 columns of AVG ECG Data
    
    for loop=1:7229
        
        ECGdata(i,loop)=0.5*(data_c1(loop)+data_c2(loop));
        
    end
    
%     row=row+1;
    
    
    emotion_value=labels_selfassessment{1,i};
    if(isempty(emotion_value))
        Label(i,1)={'No_Emotion'};
        ECGdata(i,1:7229)=0;
        continue
    end
    
    a=emotion_value(6:12);
    non_zeros=nnz(a);       % nnz tells number of ones
    zeross=all(a==0);       % array consists of all zero elements 
    
    if(non_zeros>1)
        Label(i,1)={'More than 1 emotion'};
        ECGdata(i,1:7229)=0;
        continue
    end
    if(zeross==1)
       Label(i,1)={'No Emotion'};
       ECGdata(i,1:7229)=0;
       continue
    end
    if(a(1)==1)
        Label(i,1)={'Neutral'};
        
    end
    if(a(2)==1)
        Label(i,1)={'Disgust'};
        
    end
    if(a(3)==1)
        Label(i,1)={'Happy'};
        
    end
    if(a(4)==1)
        Label(i,1)={'Surprise'};
        
    end
    if(a(5)==1)
        Label(i,1)={'Anger'};
        
    end
    if(a(6)==1)
        Label(i,1)={'Fear'};
        continue
    end
    if(a(7)==1)
        Label(i,1)={'Sad'};
        
    end
end
 AVG_ECG_STRUCT=struct('AVG_ECG',ECGdata,'Label',{Label});
 save(sprintf('ECG%1d',k), 'AVG_ECG_STRUCT');
% save ([ 'AVG_ECG_' num2str (k) '.mat' ], 'AVG_ECG_STRUCT' )
end


%  save('GSR_Person_1.mat','AVG_ECG_STRUCT');