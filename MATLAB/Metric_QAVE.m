% Pan Keskinleþtirme Demosu
% Ýþlem                              Yazar                   Tarih
% 4 Bant Destegi                    Ezgi Koç                20.12.2013
% 12.05.2014
% Ezgi KOç tarafýndan güncellendi.
% Referans deðeri 1

function [ qaveSonuc ] = Metric_QAVE( MSImage,pansharpImage )

numBands=size(MSImage,3);
DataDimension = 3;
rgbBantOrt=mean(MSImage,DataDimension); %RGB bant ortalamasý
pansharpBantOrt=mean(pansharpImage,DataDimension); %Pansharp bant ortalamasý
MSImageD = double(MSImage);
SigmaX=0;
SigmaY=0;
SigmaXY=0;

for band= 1:numBands
    %Her RGB bandýnýn bant ortalamasýyla farkýnýn karesi
    SigmaX=SigmaX+((MSImageD(:,:,band)-rgbBantOrt).^2);
    
    %Her Pansharp bandýnýn bant ortalamasýyla farkýnýn karesi
    SigmaY=SigmaY+((pansharpImage(:,:,band)-pansharpBantOrt).^2);
    
    SigmaXY=SigmaXY+(MSImageD(:,:,band)-rgbBantOrt).*...
        (pansharpImage(:,:,band)-pansharpBantOrt);
end

SigmaX=SigmaX /(numBands-1);
SigmaY=SigmaY /(numBands-1);
SigmaXY=SigmaXY /(numBands-1);
Q=(4*(SigmaXY.*rgbBantOrt.*pansharpBantOrt))./...
    ((SigmaX+SigmaY).*(rgbBantOrt.^2+pansharpBantOrt.^2));
Q(isnan(Q))=1;
qaveSonuc=mean(Q(:));
end