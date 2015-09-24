% HPF yöntemine göre Pan keskinleþtirme iþlemi yapýlýr
% Pan: Pan-kromatik Görüntü
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% High Pass Weight: HPF'den geçmiþ Pan görüntünün RGB görüntüye eklenmeden
% önce çarpýldýðý katsayý
% Ýþlem                              Yazar       Tarih
% Kod oluþturuldu                   M. Teke     20.12.2013
% Güncelleme                        Ezgi San    23.05.2014

function [Pansharp] = PS_HPF(Pan, MSImage, HighPassWeight)
tic
 
if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

% H = padarray(2,[2 2]) - fspecial('gaussian' ,[5 5],2);
r = 2;
H = -1*ones (2*r+1,2*r+1);
H(3,3) = (2*r+1) *( 2*r+1)- 1;

%Pana elde edilen filtre uygulanýr ve yüksek geçiren elde edilir.
sharpened = imfilter(Pan,H);
%Elde edilen yüksek geçiren, katsayý ile çarpýlýr
SharpenedLayer = HighPassWeight * double(sharpened) ;

[rows, cols, bands] = size(MSImage);
Pansharp = zeros(rows, cols, bands);
%Oluþturulan keskin görüntü tüm bantlara eklenir.
parfor band = 1:bands
    Pansharp(:, :, band) =  MSImage(:, :, band) + SharpenedLayer;
end

disp('HPF=');
toc

end