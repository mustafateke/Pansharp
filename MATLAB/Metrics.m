% Metrik fonksiyonlarý
% Ýþlem                              Yazar              Tarih
% RMSE eklendi                      Arda Aðçal         08.01.2014
% SAM metrik'i eklendi              MS. Seyfioglu      03.01.2014
% CC eklendi                        Arda Aðçal         13.01.2014
% RASE eklendi                      Arda Aðçal         14.01.2014
% QAVE ve SID eklendi               Arda Aðçal         15.01.2014
% Spatial eklendi                   Arda Aðçal         16.01.2014


function Metric_Results =  Metrics( MSImage, Pansharp, Pan )

MSImage(isnan(MSImage))=0;
Pansharp(isnan(Pansharp))=0;
Pan(isnan(Pan))=0;

MSImage=double(MSImage);
Pansharp=double(Pansharp);
Pan=double(Pan);

%% RMSE
Hata = Metric_RMSE( MSImage, Pansharp );

%% SAM
Angle= Metric_SAM(MSImage,Pansharp);

%% CC
coc=corrcoef(MSImage,Pansharp);
coc=coc(1,2);

%% RASE
RASESonuc=Metric_RASE(MSImage,Pansharp);

%% QAVE
QAVESonuc=Metric_QAVE( MSImage,Pansharp );

%% SID
SIDSonuc=Metric_SID( MSImage,Pansharp );

%% ERGAS
ERGASSonuc=Metric_ERGAS(MSImage,Pansharp);

%% Spatial
SpatialSonuc=Metric_Spatial(Pansharp,Pan);

Metric_Results=[Hata,Angle,coc,RASESonuc,QAVESonuc,SIDSonuc,ERGASSonuc,SpatialSonuc];

end

