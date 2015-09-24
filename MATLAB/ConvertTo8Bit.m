function Image8Bit = ConvertTo8Bit(Image)
[~, ~, bands] = size(Image);

for band = 1:bands
    if( strcmp( class(Image),'uint8') )
        Image8Bit(:,:,band) = Image(:,:,band);
    end
    if( strcmp(class(Image), 'int16') || strcmp(class(Image), 'uint16') )
        Image8Bit(:,:,band) = uint8( 255*double( Image(:,:,band) )./2048) ;
    end
    
end

end
