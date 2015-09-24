% MSImage = Multispektral goruntu
% Pan = Pan goruntu
% LevelOfFilter = Filtre seviyesi ('Low için 1' , 'Medium için 2', 'High için 3' giriniz )
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% OptimizedHPF metodu
% Ýþlem                         Yazar              Tarih
% Ýlk Versiyon             Saygýn Seyfioðlu       01.03.2014
% Hatalar Giderildi          Mustafa Teke         23.05.2014


function [ Pansharp ] = PS_OptimizedHPF( MSImage,Pan,LevelOfFilter, ratio)
tic

filtersize =( 2*ratio)+1;
filter = -1*ones(filtersize,filtersize);

if(ratio == 2)
    if(LevelOfFilter== 1)
        filter(3,3) = 24;
        Modulator = 0.2;
        
    elseif(LevelOfFilter== 2)
        filter(3,3) = 28;
        Modulator = 0.25;
        
    elseif(LevelOfFilter== 3)
        filter(3,3) = 32;
        Modulator = 0.3;
    end
    %Eger gokturk goruntusu iþlenmekteyse
    
elseif(ratio==4)
    
    if(LevelOfFilter ==1)
        filter(5,5) = 80;
        Modulator = 0.35;  
        
    elseif(LevelOfFilter==2)
        filter(5,5) = 96;
        Modulator = 0.5;        
        
    elseif(LevelOfFilter==3)
        filter(5,5) = 106;
        Modulator = 0.65;
        
    end
    
end
Pan = double(Pan);

SharpImage = imfilter(Pan,filter);
MSImage = double(MSImage);
SharpImageStd = std2(SharpImage);

[rows, cols, bands] = size(MSImage);
Pansharp = zeros(rows, cols, bands);

parfor band = 1:size(MSImage, 3)
    Weighting_factor = ...
        std2(MSImage(:,:,band))/SharpImageStd*Modulator;
    SharpenedLayer = Weighting_factor* SharpImage;
    Pansharp(:, :, band) = ...
        (MSImage(:,:, band)) + SharpenedLayer ;    
end

disp('OptimizedHPF=');
toc
end


