function [ResultImg] = KontrastIyilestir(image, Kontrast)
[~,~,bands] = size(image);
 ResultImg = image;

parfor band=1:bands
    if(Kontrast==1)
        
        %%Doðrusal
    elseif(Kontrast==2)
        ResultImg(:,:,band)=DogrusalKontrast(image(:,:,band));
        %%Doðrusal %1
    elseif(Kontrast==3)
        ResultImg(:,:,band)=imadjust(image(:,:,band));
        %%Histogram eþitleme
    elseif(Kontrast==4)
        ResultImg(:,:,band)=histeq(image(:,:,band));
        %%Adapte Histogram Eþitleme
    elseif(Kontrast==5)
        ResultImg(:,:,band)=adapthisteq(image(:,:,band));
        
    end
    
end