% Fast IHS  metodu
% Ýþlem                         Yazar              Tarih
% Kod oluþturuldu             MS. Seyfioglu      15.01.2014
% Güncelleme                  Ezgi Koç           16.05.2014
% Güncelleme                  Ezgi San           23.05.2014
% Perf. Improvement         Mustafa Teke    04.08.2014
% Pan: Pan-kromatik Görüntü
% MSImage: Multispektral goruntu
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% Referans http://www.math.ucla.edu/~wittman/pansharpening/
function [Pansharp] = PS_IHS( MSImage, Pan)
if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

[rows, cols, bands] = size(MSImage);
Pansharp = zeros(rows, cols, bands);

% I = zeros(rows, cols);
% 
% %MS görüntüden IHS dönüþümü yapýlarak I hesaplanýr.
% for band = 1:bandnum
%     I = I + MSImage(:,:,band) * (1/bandnum);
% end

I =  sum(MSImage, 3)/bands;

%Pan ile I bandý yerdeðiþtirir
MeanPan = mean( Pan(:) );
MeanI = mean( I(:) );
Pan = Pan*std(std(I))/std(std(Pan));
Pan = Pan-MeanPan-MeanI;
Pan = (Pan-MeanPan)*std(I(:))/std(Pan(:)) + MeanI; % Color Balancing

%Yeni Pan deðeri I dan çýkartýldýktan sonra her banda eklenerek...
%keskin görüntü elde edilmiþ olur.

PanMinusI = Pan - I;
parfor band = 1:bandnum
    Pansharp(:,:,band) = MSImage(:,:,band) + PanMinusI;
end
clear I

disp('IHS=');
toc

end