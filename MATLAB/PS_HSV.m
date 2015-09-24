function Pansharp = PS_HSV(MSImage,  Pan)
tic
% HSV Yöntemine göre Pan keskinleþtirme iþlemi yapýlýr
% Pan: Pankkromatik Görüntü
% MSImage: multispectral görüntü
% Pansharp: Pan keskinleþtirilmesi yapýlmýþ görüntü
% Ýþlem                              Yazar       Tarih
% Kod oluþturuldu                   M. Teke     20.12.2013

% Histogram Düzeltme Ekle
%  if(class(MSImage) ~= 'double')
if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

%  if(class(Pan) ~= 'double')
  if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end
    imageHSV = rgb2hsv( MSImage(:,:,1:3) );
%     figure('Name', 'HSV Image Before') , imshow(imageHSV);
    imageHSV (: , : , 3) = Pan;
%     figure('Name', 'HSV Image After') , imshow(imageHSV);
    Pansharp = hsv2rgb( imageHSV );
    disp('HSV');
    toc
end                                
                  