% Ezgi KOÇ tarafýndan oluþturuldu.
% Root Mean Square Error
% Referans deðeri 0
% Her bir bandýn pikselleri arasýndaki farkýn karesinin ortalamasýnýn
% karekökü

function [hata,araToplamBant] = Metric_RMSE(MSImage,Pansharp)

MSImageD = double(MSImage);
bantNum=size(MSImage,3);
PansharpD=double(Pansharp);
toplam=0;
araToplamBant = zeros(2,4); %araToplamBant her bant için RMSE deðerini vermektedir.

for bant=1:bantNum;
    kare = (MSImageD(:,:,bant) - PansharpD(:,:,bant)).^2;
    araToplam = mean2(kare (kare> 0));
    araToplamBant(bant) = sqrt(araToplam);
    toplam = toplam + araToplam;
end

hata=sqrt(toplam/bantNum);
araToplamBant();
end



