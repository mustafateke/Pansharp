function [Q]=UIQI(MS,PANMS)
MS=double(MS);
PANMS=double(PANMS);
d=size(PANMS,3);
MS=MS(:,:,1:d);

MX= mean(MS,3);
MY= mean(PANMS,3);


% Each value minus the mean along each band
M1=MS(:,:,1)-MX;
M2=MS(:,:,2)-MX;
M3=MS(:,:,3)-(MX);

P1=PANMS(:,:,1)-(MY);
P2=PANMS(:,:,2)-(MY);
P3=PANMS(:,:,3)-(MY);


    QX= (1/d-1)*((M1.^2)+(M2.^2)+(M3.^2));
    QY= (1/d-1)*((P1.^2)+(P2.^2)+(P3.^2));
    QXY= (1/d-1)*((M1.*P1)+(M2.*P2)+(M3.*P3));


Q =(d.*((QXY.*MX).*MY))./((QX+QY).*((MX.^2)+(MY.^2)));



