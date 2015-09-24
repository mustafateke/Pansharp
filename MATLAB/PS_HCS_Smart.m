% HCS_Smart yöntemine göre Pan keskinleþtirme iþlemi yapýlýr
% Pan: Pankkromatik Görüntü
% imageRGB: Renkli 3 Bant Görüntü
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% Ýþlem                              Yazar       Tarih
% Kod oluþturuldu                   M. Teke     14.01.2014

function MSPS = HCS_Smart( Pan,MSImage )
tic
if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

[rows, cols, bands] = size(MSImage);

I2 = zeros( rows, cols );
for i = 1:bands
    I2 = I2 + MSImage(:,:,i).*MSImage(:,:,i);
end

for i = 1:bands-1
    tempSum =zeros( rows, cols);
    
    for j = i+1:bands
        tempSum = tempSum + MSImage(:,:,j).*MSImage(:,:,j);
    end
    
    Fi(:,:,i) = atan( sqrt(tempSum)./ MSImage(:,:,i) );
end
h = fspecial('average', [7 7]) ;

imgPanSmooth = imfilter(Pan, h);
P2 = Pan.*Pan;


PS2 = imgPanSmooth.*imgPanSmooth;

Sigma1 = std2(PS2);
Sigma0 = std2(I2);
Mu1 = mean2(PS2);
Mu0 = mean2(I2);

PS2 = (Sigma0/Sigma1)*(PS2 - Mu1 + Sigma1) + Mu0 -Sigma0;
P2 = (Sigma0/Sigma1)*(P2 - Mu1 + Sigma1) + Mu0 -Sigma0;
clear Sigma0
clear Sigma1

IAdj = real(sqrt( (P2.*I2)./PS2));
clear I2
clear PS2
cosTree = ones( rows, cols, bands );
sinTree = ones(  rows, cols, bands );
% clear bands
% clear rows
% clear cols

for i = 1:bands-1
    cosTree(:,:, i) =  cos(Fi(:,:,i));
end

for i = 2:bands
    sinTree(:,:, i) =  sinTree(:,:,i-1).*sin( Fi(:,:,i-1) );
end
clear Fi
for i = 1:bands
    MSPS(:,:,i) = IAdj.*sinTree(:,:,i).*cosTree(:,:, i);
end
clear numImg
clear sinTree
clear cosTree
clear IAdj
disp('HCSsmart=');
toc

end


