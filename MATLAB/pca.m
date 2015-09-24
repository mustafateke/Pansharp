% PCA  metodu
% Ýþlem                         Yazar              Tarih
% Kod oluþturuldu             MS. Seyfioglu      05.01.2014
% imageRGB= renkli 3 bant görüntü
% no_dims, number of dimensions. RGB için 3 dimension olduðundan 3
% girilecek
% mapping içerisinde eigenvectorleri, eigenvalueleri ve her bir bant için
% ortalama RGB deðerlerini tutan bir struct matris
% mappedX: Map edilmiþ RGB deðerleri.

function [mappedX, mapping] = pca(imageRGB, no_dims)


    if ~exist('no_dims', 'var')
        no_dims = 2;
    end

	%RGB görüntüyü zero mean olacak þekilde ayarla. Gaussian.
	
    %Burada her bant için tüm piksel deðerlerinin ortalamasý alýnmakta
    mapping.mean = mean(imageRGB, 1);
    %Burada her piksel deðerinden ortalama deðer çýkartýlýp yeni bir matris
    %elde edilmekte
	imageRGB = imageRGB - repmat(mapping.mean, [size(imageRGB, 1) 1]);
    
	% kovaryans matrisini hesapla
    if size(imageRGB, 2) < size(imageRGB, 1)
    %sonuc olarak 3x3'lük bir kovaryans matrisi elde ediyoruz.
        C = cov(imageRGB);
    else
        C = (1 / size(imageRGB, 1)) * (imageRGB * imageRGB');        % if N>D, eigendecomposition için bunu kullan
    end
	
	% C için eigendecomposition iþlemi yap
	C(isnan(C)) = 0;
	C(isinf(C)) = 0;
    [M, lambda] = eig(C);
    %lambda özdeðerleri, M ise özvektörleri ifade etmekte
    clear C;
    
    % Eigenvectorleri azalan sýraya göre diz
    [lambda, ind] = sort(diag(lambda), 'descend');
    if no_dims > size(M, 2)
        no_dims = size(M, 2);
        warning(['Target dimensionality reduced to ' num2str(no_dims) '.']);
    end
	M = M(:,ind(1:no_dims));
    lambda = lambda(1:no_dims);
	
	% Elde edilen veriye mapping yapýlýr.
    if ~(size(imageRGB, 2) < size(imageRGB, 1))
        M = (imageRGB' * M) .* repmat((1 ./ sqrt(size(imageRGB, 1) .* lambda))', [size(imageRGB, 2) 1]);     
    end
    mappedX = imageRGB * M;
    
    % out-of-sample extension için veriyi store et.
    mapping.M = M;
	mapping.lambda = lambda;
    