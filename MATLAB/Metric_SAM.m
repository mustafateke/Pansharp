function [angle] = Metric_SAM(MSImage,Pansharp)
% Referans http://www.math.ucla.edu/~wittman/pansharpening/
 % Spectral Angle Mapper
 % Referans deðeri 0
dimension=size(Pansharp,3);
A = 0;
M = 0;
F = 0;
for i = 1:dimension   
    A = A+ MSImage(:,:,i).*Pansharp(:,:,i);%Resimlerin her bandýnýn çarpýmlarý toplamý
    M = M+MSImage(:,:,i).^2; %Multispektral resmin her bandýnýn kareleri toplamý
    F = F+Pansharp(:,:,i).^2;
    %F = F+Pansharp(:,:,1:3).^2; %Pansharp resmin her bandýnýn kareleri toplamý
end

total = double(A)./(sqrt(double(M.*F)));
angle = acosd(total);
angle(isnan(angle)) = 0;
angle = mean(angle(:));
end
