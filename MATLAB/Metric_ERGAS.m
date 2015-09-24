function ERGASsonuc = Metric_ERGAS(MSImage,Pansharp )
%Relative dimensionless global error in synthesis
%Referans deðeri 0
toplam=0;
bantnum=size(MSImage,3);
 
for i=1:bantnum
    fark = (MSImage(:,:,i) - Pansharp(:,:,i)).^2;
    araFark=mean2(fark (fark> 0));
    hata = sqrt(araFark);
    
    %hata=her bandýn RMSE deðerlerini aldý
    Pansharp(isnan(Pansharp))=0;
    bantOrtalama=mean(mean(Pansharp(:,:,i)));
    kare=(hata/bantOrtalama)^2;
    toplam=kare+toplam;
end
ERGASsonuc=25*sqrt(toplam/bantnum);
end

