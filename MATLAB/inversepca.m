% PCA  metodu (inverse PCA )
% Ýþlem                         Yazar              Tarih
% Kod oluþturuldu             MS. Seyfioglu      05.01.2014
% Referans http://www.math.ucla.edu/~wittman/pansharpening/
%E=kovaryans matrisi.
%meanV= RGB image'ýn her bir bant için ortalama deðeri
%P=fusedimage (yani pca iþlemi sonrasý en yüksek varyanslý deðer yerine pan
%görüntünün alýndýðý image.)

function [inversematrix]= inversepca(E,P,meanV,PS)
[m,n]=size(P);
 [rows,cols,bantnum]=size(PS);
 for bant=1:bantnum
 c(1:m,bant)=meanV(bant);
 end
inversematrix =(P*transpose(E))+ c;
end