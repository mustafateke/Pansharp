% PCA Methodu
% Ýþlem                         Yazar              Tarih
% Kod oluþturuldu             MS. Seyfioðlu      05.01.2014
% Güncelleme                  Ezgi San           23.05.2014
% Pan: Pan-kromatik Görüntü
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% Referans http://www.math.ucla.edu/~wittman/pansharpening/

function [Pansharp]=PS_PCA(MSImage,Pan)
tic

if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

[n,m,d] = size(MSImage);
MSImage = reshape( MSImage, [n*m,d]);

%Ýlk olarak RGB görüntünün her bandý için temel bileþenleri bulunur.
%Burada RGB image bir vektör haline getirilmiþtir.

[pcaData, pcaMap]= pca(MSImage,d);
pcaData = reshape(pcaData, [n,m,d]);
Pansharp = pcaData;
clear pcaData
%     histband = imhist(fusedimage(:,:,1));
%     Pan=histeq(Pan,histband);

%histband1=imhist(F(:,:,1));
%histP=histeq(P, histband1);

Pan = Pan * std(std(Pansharp(:,:,1))) / std(std(Pan));
Pan = Pan - (mean(mean(Pan))) - mean(mean(Pansharp(:,:,1)));

% pan bandýnýn histogram modifikasyonu yapýlýr.(ortalamasý ve standart sapmasý
% ilk temel bileþen ile çakýþacak þekilde.)
%     Pan=(Pan-mean(Pan(:)))*std(fusedimage(:))/std(Pan(:)) + mean(fusedimage(:));

%Ýlk temel bileþen en yüksek varyansa sahip olduðundan Pan image ile yer degistirir.

Pansharp(:,:,1) = Pan;
% Ters PCA ile Pan keskinleþtirmesi yapýlmýþ görüntü elde edilir.
Pansharp = inversepca(pcaMap.M, reshape(Pansharp,[n*m,d]), pcaMap.mean,Pansharp);
Pansharp = reshape(Pansharp, [n,m,d]);
disp('PCA=');

toc

end

