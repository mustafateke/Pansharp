% Brovey  metodu
% Pan: Pan-kromatik Görüntü
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% Ýþlem                         Yazar              Tarih
% Kod oluþturuldu      Mustafa Teke      05.08.2014



function [Pansharp] = PS_SFIM(MSImage,Pan)
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
% Filter Pan
r = 2;
H = ones(r,r)/r^2;
I = imfilter(Pan, H);

%Band numarasý panla çarpýldýktan sonra MS görüntünün her bandýyla ...
%bant bant çarpýlarak bantlarýn toplamýna bölünerek görüntü
%keskinleþtirilir.

PanOverI = Pan./I;

parfor band = 1:bands
    Pansharp(:,:,band) = MSImage(:,:,band) ./PanOverI;
end

disp('SFIM=');
toc

end