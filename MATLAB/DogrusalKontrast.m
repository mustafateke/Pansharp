function result = DogrusalKontrast(image)
[~, ~, bands] = size(image);

for band = 1:bands
    curImg = image(:,:, band);
    minVal = double(min( curImg(:) ));
    maxVal = double(max( curImg(:) ));
    
    resultImg = uint8(255.*(double(curImg) - minVal)./(maxVal - minVal));
    result(:,:, band) = resultImg;
    
    clear resultImg;
    clear curImg;
end

end