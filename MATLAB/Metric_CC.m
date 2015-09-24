function coc = Metric_CC( MSImage,Pansharp )
% MS ve pankeskinleþtirilmiþ görüntü arasýndaki benzerliði inceler.
% Referans deðeri 1.

MSImage     = double (MSImage);
Pansharp    = double ( Pansharp );

[en,boy,bant]   = size(MSImage);

toplamRGB   = MSImage/(en*boy*bant);
toplamRGB   = sum(toplamRGB(:));

matrixOnes  = ones(en,boy,bant);
ortalmaRGB  = toplamRGB*matrixOnes;
toplamPansharp  = Pansharp/(en*boy*bant);
toplamPansharp  = sum(toplamPansharp(:));
ortalamaPansharp    = toplamPansharp*matrixOnes;

pay_1   = MSImage-ortalmaRGB;
pay_2   = Pansharp-ortalamaPansharp;
pay     = pay_1.*pay_2;
pay     = sum(pay(:));
payda1  = pay_1.*pay_1;
payda2  = pay_2.*pay_2;
payda1  = sum(payda1(:));
payda2  = sum(payda2(:));
payda   = sqrt(payda1)*sqrt(payda2);

coc     = pay/payda;
end

