% Pan Keskinleþtirme Demosu
% Ýþlem                              Yazar                   
% 4 Bant Destegi                    Ezgi Koç                
% 12.05.2014
% Ezgi SAn tarafýndan güncellendi.
% Relative average spectral error
% Referans deðeri 0

function sonucRase = Metric_RASE( MSImage,Pansharp )

toplam = 0;
numBands = size(MSImage,3);

for i=1:numBands % Her bir bant için RMSE deðerinin karesi hesaplanýr.
    kare = (MSImage(:,:,i) - Pansharp(:,:,i)).^2;
    araToplam = mean2(kare (kare> 0));
    toplam = toplam + araToplam;
end
toplam  = sqrt(toplam/numBands); %Her bandýn RMSE'lerinin karesi toplamý bant sayýsýna bölünür
clear kare
clear numBands
clear araToplam
ortRGB  = mean(MSImage(:));
sonucRase   = toplam*100/ortRGB;
end

