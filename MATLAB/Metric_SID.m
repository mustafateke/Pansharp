% Spectral Information Divergence
% Referans deðeri 0

function [ SIDsonuc ] = Metric_SID( MSImage,Pansharp )

bant=size(MSImage,3);
toplamX=0;
toplamY=0;
for i=1:bant %RGB ve Pansharp resmin bantlarý toplamý
    toplamX=toplamX+MSImage(:,:,i);
    toplamY=toplamY+Pansharp(:,:,i);
end
Dxy=0;
Dyx=0;
for j=1:bant
    pj=MSImage(:,:,j)./toplamX;
    qj=Pansharp(:,:,j)./toplamY;
    Dxy=Dxy+pj.*log((pj./qj));
    Dyx=Dyx+qj.*log((qj./pj));
end
SIDsonuc=Dxy+Dyx;
clear Dxy
clear Dyx

SIDsonuc(isnan(SIDsonuc))=0;
SIDsonuc=mean(SIDsonuc(:));
end

