% Ezgi Koç tarafýndan güncellendi.
% Her bandýn Spatial metrik deðeri eklendi.
% Pan görüntüyle pankeskinleþtirilmiþ görüntünün her bir bandýný yüksek geçiren filtreden geçirip uzamsal benzerliðini karþýlaþtýrýr. 
% Referans deðeri 1.

function [spatialSonuc,spatialSonucVector]=Metric_Spatial(Pansharp,Pan)
% Referans deðeri 1
Pansharp(isnan(Pansharp))=0;
[rows,colums,bands]=size(Pansharp);
mask=[-1,-1,-1;-1,8,-1;-1,-1,-1];
Pan = double(Pan);
PanCon=conv2(Pan, mask,'same');%maskeyle panýn konvolüsyonu
spatialSonucToplam = 0;
FuseCon=zeros(rows,colums,bands);

for i=1:bands    
    FuseCon(:,:,i)=conv2(Pansharp(:,:,i), mask, 'same'); %Pansharp edilmiþ resmin her bandýn maskelenmesi
    A=corrcoef(PanCon, FuseCon(:,:,i)); %Maskelenmiþ her bantla maskelenmiþ panýn corrolation coefficient'ýnýn bulunmasý
    spatialSonucToplam = spatialSonucToplam+A(1,2);% Corrcoef'lerin toplamý
    spatialSonucVector(i)= A(1,2);
end

spatialSonuc = abs(spatialSonucToplam/bands);
abs(spatialSonucVector());
end