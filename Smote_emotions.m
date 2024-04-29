clear all
clc
load avg_ecg_Surprise.mat
zz=SMOTE_TRY(Surprise_MATRIX,450,3);
[r,c]=size(zz);

Label=cell(r,1);
for kk=1:r
    Label(kk,1)={'Surprise'};
end
AVG_ECG_STRUCT=struct('AVG_ECG',zz,'Label',{Label});
save('SMOTE_ECG_Surprise.mat','AVG_ECG_STRUCT');