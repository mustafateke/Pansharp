% Brovey  metodu
% Pan: Pan-kromatik Görüntü
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% Ýþlem                         Yazar              Tarih
% Kod oluþturuldu             MS. Seyfioglu      05.01.2014
% Güncelleme                  Ezgi San           23.05.2014
% Perf. Improvement         Mustafa Teke    04.08.2014


function [Pansharp] = PS_Brovey(MSImage,Pan)
tic

if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

MSImageToplam = 0;
[rows, cols, bands] = size(MSImage);
Pansharp = zeros(rows, cols, bands);
%Tüm bantlarýn toplamý elde edilir.

% for band = 1:bandnum
%     MSImageToplam = MSImageToplam + MSImage(:,:,band);
% end

MSImageToplam = sum(MSImage, 3);

%Band numarasý panla çarpýldýktan sonra MS görüntünün her bandýyla ...
%bant bant çarpýlarak bantlarýn toplamýna bölünerek görüntü
%keskinleþtirilir.
PanOverMSSum = bands*Pan./MSImageToplam;
parfor band = 1:bands
    Pansharp(:,:,band) = PanOverMSSum .* MSImage(:,:,band);
end

disp('Brovey=');
toc

end

