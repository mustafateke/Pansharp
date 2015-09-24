% 03.06.2014
% Ezgi KOÇ tarafýndan oluþturuldu.
% Values from -1 to 1.
% The value should be as close to 1 as possible.

function [HCC] = Metric_HCC(MSImage,Pansharp)

bantnum=size(MSImage,3);
toplam = 0;
payda = 0;
ortMSImage = mean(MSImage);
ortPansharp = mean(Pansharp(:,:,1:3));

for bant = 1:bantnum
   toplam = toplam + (MSImage(:,:,bant)-ortMSImage).*(Pansharp(:,:,bant)-ortPansharp);
   payda = payda + ((MSImage(:,:,bant)-ortMSImage).^2).*((Pansharp(:,:,bant)-ortPansharp).^2);
end

HCC = toplam./sqrt(payda);
end