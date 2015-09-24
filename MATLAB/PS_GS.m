% % Gram Schmidt  metodu
% % 13.08.2014 
% % Ezgi Koç tarafýndan oluþturuldu.
% % Pan: Pan-kromatik Görüntü
% % MS Image: Multispektral goruntu
% % Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
%
function [GSImage] = GS_(MSImage,Pan)
bantNum = size(MSImage,3);
toplam = 0;
[rows cols] = size(Pan);
toplam2 = cell(1,1,bantNum);

for j = 1:bantNum
    toplam = toplam + MSImage(:,:,j);
end
lowresol = toplam/bantNum;

for bant = 1:bantNum
    MSImage(:,:,bant) = double(MSImage(:,:,bant));
    Pan(isnan(Pan)) = 0;
    t = MSImage(:,:,bant);
    t(isnan(t)) = 0;
    MSImage(:,:,bant) = t;
    GS1 = lowresol;
    GS{1,1} = GS1;
    temp2 = MSImage(:,:,bant);
    carpim = cell(1,bant);
    carpim{1,bant} = zeros(rows,cols);
    
    for temp = 1:bant
        MSImageCol = MSImage(:,:,bant);
        GSCol = GS{1,temp};
        covMSImage = cov(double([MSImageCol(:) GSCol(:)]));
        varGS = covMSImage(2,2);
        covarMSImage = covMSImage(1,2);
        coeffMSImage(temp) = covarMSImage/varGS;
    end
    
    for i = 1:bant
        carpim{1,i} = double(coeffMSImage(i)*GS{1,i});
    end
    
    
    toplam2{1,1,i} = zeros(rows,cols);
    
    for col = 1:bant
        toplam2{1,1,i} = toplam2{1,1,i} + carpim{1,col};
    end
    
    
    fark = double(MSImage(:,:,bant) - mean(temp2(:)));
    GS{1,bant+1} = double(fark - toplam2{1,1,i});
end


GS{1,1} = lowresol;
GS1 = GS{1,1};
GS1mean = mean(GS1(:));
GS1std = std(double(GS1(:)));

Pan = double(Pan);
Panmean = mean(Pan(:));
Panstd = std(Pan(:));

Panmod = zeros(size(Pan));

parfor r = 1:rows
    for c = 1:cols
        Panmod(r,c) = Pan(r,c).*(GS1std/Panstd)+GS1mean-(GS1std/Panstd)*Panmean;
    end
end

GS1 = Panmod;
GS{1,1} = GS1;

for h = 1:bantNum
    image = MSImage(:,:,h);
    MSImageFinal(:,:,h) = GS{1,h+1} + mean(image(:)) + toplam2{1,1,h};
    GSImage(:,:,h) = MSImageFinal(:,:,h);
end

disp('Gramschmidt=');
end