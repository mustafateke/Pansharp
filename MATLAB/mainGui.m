function varargout = mainGui(varargin)
% Ýþlem                         Yazar
% Kod oluþturuldu             Arda Aðçal
% Göktürk-2 güncellemeleri    Ezgi San ,Ezgi Koç

% MAINGUI MATLAB code for mainGui.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGui

% Last Modified by GUIDE v2.5 04-Aug-2014 15:33:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mainGui_OpeningFcn, ...
    'gui_OutputFcn',  @mainGui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);

if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mainGui is made visible.

function mainGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGui (see VARARGIN)
global metodsecim;
metodsecim = 0;
global aradegersecim;
aradegersecim = 0;
global eskiadres;
eskiadres = 0;
global adreskontrol;
adreskontrol = 0;
global eskirgbadres;
eskirgbadres = 0;
global rgbadreskontrol;
rgbadreskontrol = 0;
global isUSStateChanged;
isUSStateChanged = 0;
global eskiUSState;
eskiUSState = 0;

% Choose default command line output for mainGui
set(handles.pbAboutBack,'Visible','off');
handles.output = hObject;
jFrame = get(handles.AnaEkran,'javaframe');
jicon = javax.swing.ImageIcon('uzaylogo.jpeg');
jFrame.setFigureIcon(jicon);
jFrame = get(handle(handles.AnaEkran), 'javaframe');
handles.output = hObject;
% Update handles structure
%-------------------------------------
loadstate(handles);
%*******************************************
linkaxes([handles.axes3 handles.axes2 handles.PansharpResultAxes],'xy');
axis fill
guidata(hObject, handles);
% axes(handles.axes1);
% imshow('uzaylogo.jpeg');

% UIWAIT makes mainGui wait for user response (see UIRESUME)
% uiwait(handles.AnaEkran);
if(length(get(handles.RGB,'String'))>0)
    if(exist(get(handles.RGB,'String'),'file')~=0)
        RGBImg = imread( get(handles.RGB,'String') );
        
        RGBImg(isnan(RGBImg)) = 0;
        
        format = get(handles.araDeger,'Value');
        if(format == 1)
            RGBImg = imresize(RGBImg, 2, 'cubic');
            
        elseif(format == 2)
            RGBImg = imresize(RGBImg, 2, 'nearest');
            
        elseif(format == 3)
            RGBImg = imresize(RGBImg, 2, 'bilinear');
        end
        
        RGBImg8bit = ConvertTo8Bit(RGBImg);
        
        setappdata(0,'RGBImg8bit',RGBImg8bit);
        setappdata(0,'RGBImg',RGBImg);
        setappdata(0,'class',class(RGBImg));
        
        axes(handles.axes2);
        imshow(RGBImg8bit);
    end
    
end

if(length(get(handles.PanAdress,'String'))>0 && exist( get(handles.PanAdress,'String'), 'file' ) )
    
    PanImg = imread(get(handles.PanAdress,'String'));
    
    PanImg8bit = ConvertTo8Bit(PanImg);
    
    setappdata(0,'PanImg8bit',PanImg8bit);
    setappdata(0,'PanImg',PanImg);
    setappdata(0,'class',class(PanImg));
    
    axes(handles.axes3);
    imshow(PanImg8bit);
    
end

if(length(get(handles.PanAdress,'String'))>1 && length(get(handles.RGB,'String'))>1 )
    set(handles.pushbuttonHesapla,'Enable','on');
end

kontrol = get(handles.sonuc,'String');
if (~isempty(kontrol))
    set(handles.save,'Enable','on');
    set(handles.temizle,'Enable','on');
end
% --- Outputs from this function are returned to the command line.
function varargout = mainGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function PanAdress_Callback(hObject, eventdata, handles)
% hObject    handle to PanAdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PanAdress as text
%        str2double(get(hObject,'String')) returns contents of PanAdress as a double
global eskiadres;
global adreskontrol;

Pan = imread(get(handles.PanAdress,'String'));

PanImg8bit = ConvertTo8Bit(Pan);

setappdata(0,'PanImg8bit',PanImg8bit);
setappdata(0,'PanImg',PanImg);
setappdata(0,'class',class(PanImg));

axes(handles.axes3);
imshow(PanImg8bit);

if(length(get(handles.PanAdress,'String'))>1 && length(get(handles.RGB,'String'))>1 )
    set(handles.pushbuttonHesapla,'Enable','on')
end

if(eskiadres == get(handles.PanAdress,'String'))
    adreskontrol = 0;
    
else
    adreskontrol = 1;
    eskiadres = get(handles.PanAdress,'String');
    
end
% --- Executes during object creation, after setting all properties.
function PanAdress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PanAdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function RGB_Callback(hObject, eventdata, handles)
% hObject    handle to RGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RGB as text
%        str2double(get(hObject,'String')) returns contents of RGB as a double
global eskirgbadres;
global rgbadreskontrol;
if(length(get(handles.RGB,'String'))>0)
    RGBImg = imread( get(handles.RGB,'String') );
    
    RGBImg(isnan(RGBImg))=0;
    
    format = get(handles.araDeger,'Value');
    if(format == 1)
        RGBImg = imresize(RGBImg, 2, 'cubic');
        
    elseif(format == 2)
        RGBImg = imresize(RGBImg, 2, 'nearest');
        
    elseif(format == 3)
        RGBImg = imresize(RGBImg, 2, 'bilinear');
    end
    
    RGBImg8bit = ConvertTo8Bit(RGBImg);
    
    setappdata(0,'RGBImg8bit',RGBImg8bit);
    setappdata(0,'RGBImg',RGBImg);
    setappdata(0,'class',class(RGBImg));
    
    axes(handles.axes2);
    imshow(RGBImg8bit);
    
    if(length(get(handles.PanAdress,'String'))>1 && length(get(handles.RGB,'String'))>1 )
        set(handles.pushbuttonHesapla,'Enable','on')
    end
    
end
if(eskirgbadres == get(handles.RGB,'String'))
    rgbadreskontrol = 0;
    
else
    rgbadreskontrol = 1;
    eskirgbadres = get(handles.RGB,'String');
    
end
% --- Executes during object creation, after setting all properties.
function RGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in araDeger.
function araDeger_Callback(hObject, eventdata, handles)
% hObject    handle to araDeger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns araDeger contents as cell array
%        contents{get(hObject,'Value')} returns selected item from araDeger


% --- Executes during object creation, after setting all properties.
function araDeger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to araDeger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sonuc_Callback(hObject, eventdata, handles)
% hObject    handle to sonuc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sonuc as text
%        str2double(get(hObject,'String')) returns contents of sonuc as a double

% --- Executes during object creation, after setting all properties.
function sonuc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sonuc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonHesapla.
function pushbuttonHesapla_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHesapla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global metodsecim;
global aradegersecim;
global adreskontrol;
global rgbadreskontrol;
global eskiUSState;
global isUSStateChanged;
global Pansharp8Bit;

Kontrast = get(handles.KontrastSecim,'Value');
set(handles.pushbuttonHesapla,'Enable','off');
saatyok=0;

if(eskiUSState == get(handles.checkboxUnsharpUygula,'Value'));
    isUSStateChanged = 0;
    
else
    isUSStateChanged = 1;
    eskiUSState = get(handles.checkboxUnsharpUygula,'Value');
   
end

if(metodsecim == get(handles.metod,'Value') && aradegersecim == get(handles.araDeger,'Value')  && ...
        ((adreskontrol == 0 || rgbadreskontrol == 0) && isUSStateChanged == 0))
    saatyok = 1;
    sure = '-';
    x = 0.5;
    waitbar(x,'Metrik hesaplanýyor...')
    close
else
    
    metodsecim = get(handles.metod,'Value');
    aradegersecim = get(handles.araDeger,'Value');
    x = 0;
    waitbar(x,'Görüntüler alýnýyor...')
    close
    
    PanImg = getappdata(0,'PanImg');
    RGBImg =  getappdata(0,'RGBImg');
    
    rgbadreskontrol = 0;
    adreskontrol = 0;
    
    PanImg(isnan(PanImg)) = 0;
    RGBImg(isnan(RGBImg)) = 0;
    
    [rows, cols] = size(PanImg);
    format = get(handles.araDeger,'Value');
    if(format == 1)
        RGBImg = imresize(RGBImg, [rows, cols], 'cubic');
        
    elseif(format == 2)
        RGBImg = imresize(RGBImg, [rows, cols], 'nearest');
        
    elseif(format == 3)
        RGBImg = imresize(RGBImg, [rows, cols], 'bilinear');
    end
    
    %% Unsharp
    UnsharpUygula = get(handles.checkboxUnsharpUygula,'Value');
    Sigma = str2double(get(handles.editSigma,'String'));
    Weight = str2double(get(handles.editWeight,'String'));
    Threshold = str2double(get(handles.editThreshold,'String'));
    
    if(UnsharpUygula == 1)
         x = 0.3;
        waitbar(x,'Unsharp yapýlýyor...')
        PanImg = UnsharpPan(PanImg, Sigma, Weight, Threshold);
        close
    end
    
    Method = get(handles.metod,'Value');
    x = 0.3;
    waitbar(x,'Pan Keskinleþtirme yapýlýyor...')
    tic
    %% Brovey
    if ( Method == 1 )
        Pansharp = PS_Brovey(RGBImg,PanImg);
        
        %%  Gramm-Schmitt
    elseif ( Method == 2 )
        Pansharp = PS_GS(RGBImg(:,:,1),RGBImg(:,:,2),RGBImg(:,:,3),PanImg );
        
        %% HCS
    elseif ( Method == 3 )
        Pansharp = PS_HCS(PanImg,RGBImg);
        %% HCS Smart
    elseif ( Method == 4 )
        Pansharp = PS_HCS_Smart(PanImg,RGBImg);
        %% HPF
    elseif ( Method == 5 )
        HighPassAdditionWeight = 0.24;
        Pansharp = PS_HPF(PanImg, RGBImg, HighPassAdditionWeight);
       %% HSV
       elseif ( Method == 6 )
        Pansharp = PS_HSV(RGBImg,PanImg);
        %% IHS
    elseif ( Method == 7 )
        Pansharp = PS_IHS(RGBImg,PanImg );
        %% OptimizedHPF
    elseif(Method==8)
        LevelOfFilter = 1;
        ratio=2;
        Pansharp = PS_OptimizedHPF(RGBImg,PanImg,LevelOfFilter,ratio);
        %% PCA
    elseif ( Method == 9 )
        Pansharp = PS_PCA(RGBImg,PanImg);
        %% SFIM
    elseif(Method == 10)
        Pansharp = PS_SFIM (RGBImg,PanImg);
       %% Wavelet
    elseif(Method == 11)
    Pansharp = PS_Wavelet (RGBImg,PanImg);
    end
    
    sure=toc;
    
    classVal = getappdata(0, 'class');
    
    if (strcmp(classVal, 'uint8') == 1)
        Pansharp8Bit = uint8(Pansharp);
        setappdata(0, 'Pansharp8Bit', Pansharp8Bit);
    else
        Pansharp8Bit = uint8(255*double(Pansharp)./2048);
        %setappdata(0, 'Pansharp', uint16(Pansharp));
        setappdata(0, 'Pansharp8Bit', Pansharp8Bit);
    end
    
    %     setappdata(0,'Pansharp8Bit',Pansharp8Bit);
    x = 0.7;
    close
    waitbar(x,'Metrik hesaplanýyor...')
    close
    %*************************************
    axes(handles.PansharpResultAxes);
    imshow(Pansharp8Bit);
    axis fill
    if(exist('Kontrast') == 1)
        Iyilestir_Callback(hObject, eventdata, handles);
    end
    %*************************************
   
end

set(handles.pansharpSave,'Enable','on');
set(handles.yeniletool,'Enable','on');
Method = get(handles.metod,'Value');
format = get(handles.araDeger,'Value');
metrik = get(handles.metrik,'Value');
old = get(handles.sonuc,'String');
metodadi = get(handles.metod,'String');
metodadi = metodadi(Method);
metrikadi = get(handles.metrik,'String');
metrikadi = metrikadi(metrik);
aradegeradi = get(handles.araDeger,'String');
aradegeradi = aradegeradi(format);

 PanImg = getappdata(0,'PanImg');
 RGBImg =  getappdata(0,'RGBImg');
 
 RGBImg(isnan(RGBImg))=0;
 Pansharp(isnan(Pansharp))=0;
 PanImg(isnan(PanImg))=0;

 RGBImg = double(RGBImg);
 Pansharp = double(Pansharp);
 PanImg = double(PanImg);


if(metrik==0)
    %Do Nothing
elseif(metrik==1)
    %% CC
    coc = Metric_CC(RGBImg,Pansharp);
    coc = num2str(coc);
    hata = coc;
    
elseif(metrik==2)
    %% ERGAS
    ERGASsonuc = Metric_ERGAS(RGBImg,Pansharp);
    ERGASsonuc = num2str(ERGASsonuc);
    hata = ERGASsonuc;
    
elseif(metrik==3)
    %% RASE
    sonucRase = Metric_RASE(RGBImg,Pansharp);
    sonucRase = num2str(sonucRase);
    hata = sonucRase;
elseif(metrik==4)
    %% RMSE
    rmseSonuc = Metric_RMSE( RGBImg, Pansharp );
    rmseSonuc = num2str(rmseSonuc);
    hata = rmseSonuc;
    
elseif(metrik==5)
    %% SAM
    angle = Metric_SAM(RGBImg,Pansharp);
    angle = abs(angle);
    angle = num2str(angle);
    hata = angle;
    
elseif(metrik==6)
    %% SID
    SIDsonuc = Metric_SID( RGBImg,Pansharp );
    SIDsonuc = num2str(SIDsonuc);
    hata = SIDsonuc;
elseif(metrik==7)
    %% Spatial
    spatialSonuc = Metric_Spatial(Pansharp,PanImg);
    spatialSonuc = num2str(spatialSonuc);
    hata = spatialSonuc;
    
elseif(metrik==8)
    %% QAVE
    qaveSonuc = Metric_QAVE( RGBImg,Pansharp );
    qaveSonuc = num2str(qaveSonuc);
    hata = qaveSonuc;
    
    
end

panadresi = get(handles.PanAdress,'String');
rgbadresi = get(handles.RGB,'String');
list1 = strcat('Pan:',{' '},panadresi);
list11 = strcat('KYM:',{' '},rgbadresi);
list1 = char(list1);
list11 = char(list11);
list1 = strvcat(list1,list11);
list2 = strcat('Metod:',{' '},metodadi,{' '},'Ara Deðer:',{' '},aradegeradi);
list1 = char(list1);
list2 = char(list2);
list12 = strvcat(list1,list2);
list3 = strcat('Metrik:',{' '},metrikadi,{' '},'Hata:',{' '},hata);
list3 = char(list3);
formatOut = 'dd/mm/yy';
tarih = datestr(now,formatOut);
tarih = char(tarih);
saat = datestr(now,'HH:MM');
tarih = strcat(tarih,{' '},saat);
sure = num2str(sure);
if(saatyok == 0)
    sure = strcat(sure,'saniye');
end
list4 = strcat('Tarih:',{' '},tarih,{' '},'Süre:',{' '},sure);
list4 = char(list4);
list123 = strvcat(list12,list3);
list = strvcat(list123,list4);
list = strvcat(list,'>>>');
list = char(list);
old = char(old);
new = strvcat(old,list);
new = cellstr(new);
old = cellstr(old);
set(handles.sonuc,'String',new);
kontrol = get(handles.sonuc,'String');
if (~isempty(kontrol))
    set(handles.save,'Enable','on');
    set(handles.temizle,'Enable','on');
end

set(handles.pushbuttonHesapla,'Enable','on');

% --- Executes on selection change in metod.
function metod_Callback(hObject, eventdata, handles)
% hObject    handle to metod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns metod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from metod


% --- Executes during object creation, after setting all properties.
function metod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in metrik.
function metrik_Callback(hObject, eventdata, handles)
% hObject    handle to metrik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns metrik contents as cell array
%        contents{get(hObject,'Value')} returns selected item from metrik


% --- Executes during object creation, after setting all properties.
function metrik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metrik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in panekle.
function panekle_Callback(hObject, eventdata, handles)
% hObject    handle to panekle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yol;
global eskiadres;
global adreskontrol;
if(length(yol) ~= 0)
    if(yol == 0)
        [filenam,pathname,filterindex] = uigetfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'Pan resmi seçin');
    else
        [filenam,pathname,filterindex] = uigetfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'Pan resmi seçin',yol);
    end
    if(pathname ~= 0)
        yol=pathname;
    end
elseif(length(yol) == 0)
    [filenam,pathname,filterindex] = uigetfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'Pan resmi seçin');
    yol=pathname;
end
index = [pathname filenam];
if(filenam ~= 0)
    set(handles.PanAdress,'String',index);
    
    PanImg = imread(get(handles.PanAdress,'String'));
    PanImg8bit = ConvertTo8Bit(PanImg);
    
    setappdata(0,'PanImg8bit',PanImg8bit);
    setappdata(0,'PanImg',PanImg);
    setappdata(0,'class',class(PanImg));
    
    axes(handles.axes3);
    imshow(PanImg8bit);
    
end
if(length(get(handles.PanAdress,'String'))>1 && length(get(handles.RGB,'String'))>1 )
    set(handles.pushbuttonHesapla,'Enable','on')
end

if(eskiadres == get(handles.PanAdress,'String'))
    adreskontrol = 0;
else
    adreskontrol = 1;
    eskiadres = get(handles.PanAdress,'String');
end

% --- Executes on button press in rgbekle.
function rgbekle_Callback(hObject, eventdata, handles)
% hObject    handle to rgbekle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global eskirgbadres;
global rgbadreskontrol;
global yol
global rows;
global cols;
if(length(yol)>0)
    if(yol == 0)
        [filenam,pathname,filterindex] = uigetfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'KYM resmi seçin');
    else
        [filenam,pathname,filterindex] = uigetfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'KYM resmi seçin',yol);
    end
    if(pathname ~= 0)
        yol = pathname;
    end
elseif(length(yol) == 0 )
    [filenam,pathname,filterindex] = uigetfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'KYM resmi seçin');
    yol = pathname;
end
index = [pathname filenam];
if(index ~= 0)
    set(handles.RGB,'String',index);
    RGBImg = imread( get(handles.RGB,'String') );
    RGBImg(isnan(RGBImg)) = 0;
    
    format = get(handles.araDeger,'Value');
    if(format == 1)
        RGBImg = imresize(RGBImg, 2, 'bilinear');
        
    elseif(format == 2)
        RGBImg = imresize(RGBImg, 2, 'cubic');
        
    elseif(format == 3)
        RGBImg = imresize(RGBImg, 2, 'nearest');
    end
    RGBImg8bit = ConvertTo8Bit(RGBImg);
    
    setappdata(0,'RGBImg8bit',RGBImg8bit);
    setappdata(0,'RGBImg',RGBImg);
    setappdata(0,'class',class(RGBImg));
    
    axes(handles.axes2);
    imshow(RGBImg8bit);
    
end
%end
if(length(get(handles.PanAdress,'String'))>1 && length(get(handles.RGB,'String'))>1 )
    set(handles.pushbuttonHesapla,'Enable','on')
end

if(eskirgbadres == get(handles.RGB,'String'))
    rgbadreskontrol = 0;
else
    rgbadreskontrol = 1;
    eskirgbadres = get(handles.RGB,'String');
end

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uiputfile('*.txt');
id = [pathname filename];
fileID = fopen(id,'a+');
b = get(handles.sonuc,'String');
for i = 1:length(b)
    b1 = b{i};
    b1 = char(b1);
    b1 = transpose(b1);
    fprintf(fileID,'%s',b1);
    fprintf(fileID,'\n');
end
fclose(fileID);
% --- Executes when user attempts to close AnaEkran.
function AnaEkran_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to AnaEkran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
savestate(handles);
delete(hObject);
function savestate(handles)
stated.editStr = get(handles.sonuc,'String');
stated.rgb = get(handles.RGB,'String');
stated.pan = get(handles.PanAdress,'String');
stated.metod = get(handles.metod,'Value');
stated.metrik = get(handles.metrik,'Value');
stated.aradeger = get(handles.araDeger,'Value');
save('stated.mat', 'stated');
function loadstate(handles)
filenam = 'stated.mat';
if (exist(filenam,'file')~=0)
    load(filenam);
    set(handles.PanAdress,'String',stated.pan)
    set(handles.RGB,'String',stated.rgb)
    set(handles.metod,'Value',stated.metod)
    set(handles.metrik,'Value',stated.metrik)
    set(handles.araDeger,'Value',stated.aradeger)
    delete(filenam);
end
% --------------------------------------------------------------------
function zoomin_OnCallback(hObject, eventdata, handles)
% hObject    handle to zoomin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%linkaxes([handles.axes3 handles.axes2 handles.PansharpResultAxes],'xy');
%set(axes.PlotBoxAspectRatioMode,'manual');
%axis fill
% --- Executes on button press in temizle.
function temizle_Callback(hObject, eventdata, handles)
% hObject    handle to temizle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.save,'Enable','off');
set(handles.sonuc,'String','');
set(handles.temizle,'Enable','off');
% --- Executes on mouse motion over figure - except title and menu.
function AnaEkran_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to AnaEkran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  C = get (gca, 'CurrentPoint');
% title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);

% --- Executes on button press in hak.
function hak_Callback(hObject, eventdata, handles)
% hObject    handle to hak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text9,'Position',[43.6 28.69 95.8 30.85]);
%set(handles.geri,'Position',[82.4 31.9 13.8 1.7]);
set(handles.text9,'Visible','on');
set(handles.geri,'Visible','on');


% --- Executes on button press in geri.
function geri_Callback(hObject, eventdata, handles)
% hObject    handle to geri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text9,'Visible','off');
set(handles.geri,'Visible','off');


% --- Executes on mouse press over axes background.
function PansharpResultAxes_ButtonDownFcn(hObject, eventdata, handles)

% hObject    handle to PansharpResultAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function uitoggletool7_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
impixelinfo

function daata(src,varargin)
%currentPoint = get(handles.PansharpResultAxes, 'CurrentPoint')
%get(impixelinfo,'UserData')

% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.text9,'Position',[43.6 28.69 95.8 30.85]);
%set(handles.geri,'Position',[82.4 31.9 13.8 1.7]);
set(handles.text9,'Visible','on');
set(handles.pbAboutBack,'Visible','on');

function pankeskinKayit_Callback(hObject, eventdata, handles)
% hObject    handle to pankeskinKayit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pankeskinKayit as text
%        str2double(get(hObject,'String')) returns contents of pankeskinKayit as a double


% --- Executes during object creation, after setting all properties.
function pankeskinKayit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pankeskinKayit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pansharpSave.
function pansharpSave_Callback(hObject, eventdata, handles)
% hObject    handle to pansharpSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global Pansharp8bit;
global yol;
[filename pathname] = uiputfile({'*.tif';'*.jpeg';'*.jpg';'*.png';'*.bmp'},'Kaydet',yol);
id = [pathname filename];
if(pathname~=0)
    yol = pathname;
end
if(filename ~= 0)
    Pansharp8Bit = getappdata(0,'Pansharp8Bit');
    imwrite(Pansharp8Bit,id);
    
    set(handles.Pansharp8bitKayit,'String',id);
    set(handles.Pansharp8bitKayit,'Enable','inactive');
end
% --------------------------------------------------------------------
function zoomout_OnCallback(hObject, eventdata, handles)
% hObject    handle to zoomout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axis equal

% --------------------------------------------------------------------
function zoomin_OffCallback(hObject, eventdata, handles)
% hObject    handle to zoomin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function yeniletool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to yeniletool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global Pansharp8Bit;
% global PanImg8bit;
% global RGBImg8bit;
PanImg8bit = getappdata(0,'PanImg8bit');
RGBImg8bit = getappdata(0,'RGBImg8bit');
Pansharp8Bit = getappdata(0,'Pansharp8Bit');
set(handles.zoomin,'State','off');
set(handles.zoomout,'State','off');
set(handles.uitoggletool7,'State','off');
set(handles.uitoggletool3,'State','off');
set(handles.yeniletool,'State','off');
axes(handles.axes3);
imshow(PanImg8bit);
axes(handles.axes2);
imshow(RGBImg8bit);
axes(handles.PansharpResultAxes);
imshow(Pansharp8Bit);

axis fill


% --- Executes on selection change in KontrastSecim.
function KontrastSecim_Callback(hObject, eventdata, handles)
% hObject    handle to KontrastSecim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns KontrastSecim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from KontrastSecim


% --- Executes during object creation, after setting all properties.
function KontrastSecim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KontrastSecim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Iyilestir.
function Iyilestir_Callback(hObject, eventdata, handles)
% global Pansharp8Bit;
% hObject    handle to Iyilestir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Kontrast = get(handles.KontrastSecim,'Value');
%%yok
if(exist('eskiKontrastSecimi') == 0)
    eskiKontrastSecimi = -1;
end
if(Kontrast == 1 && (eskiKontrastSecimi ~= 1 || eskiKontrastSecimi ~= -1) )
    
    PanImg = getappdata(0,'PanImg');
    RGBImg = getappdata(0,'RGBImg');
    PanImg8bit = ConvertTo8Bit(PanImg);
    RGBImg8bit = ConvertTo8Bit(RGBImg);
elseif(Kontrast > 1)
    x = 0.5;
    waitbar(x,'Görüntü iyileþtiriliyor...')
    close
    PanImg8bit = getappdata(0,'PanImg8bit');
    RGBImg8bit = getappdata(0,'RGBImg8bit');
    Pansharp8Bit = getappdata(0,'Pansharp8Bit');
    
    PanImg8bit = KontrastIyilestir(PanImg8bit, Kontrast);
    RGBImg8bit = KontrastIyilestir(RGBImg8bit, Kontrast);
    Pansharp8Bit = KontrastIyilestir(Pansharp8Bit, Kontrast);
end
axes(handles.axes3);
imshow(PanImg8bit);

axes(handles.axes2);
imshow(RGBImg8bit);

if(exist('Pansharp8Bit') == 1)
    axes(handles.PansharpResultAxes);
    imshow(Pansharp8Bit)
end
setappdata(0, 'eskiKontrastSecimi', Kontrast);


% --- Executes on button press in checkboxUnsharpUygula.


% --- Executes on button press in checkboxUnsharpUygula.
function checkboxUnsharpUygula_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxUnsharpUygula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxUnsharpUygula


function editSigma_Callback(hObject, eventdata, handles)
% hObject    handle to editSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSigma as text
%        str2double(get(hObject,'String')) returns contents of editSigma as a double


% --- Executes during object creation, after setting all properties.
function editSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWeight_Callback(hObject, eventdata, handles)
% hObject    handle to editWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWeight as text
%        str2double(get(hObject,'String')) returns contents of editWeight as a double


% --- Executes during object creation, after setting all properties.
function editWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to editThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editThreshold as text
%        str2double(get(hObject,'String')) returns contents of editThreshold as a double


% --- Executes during object creation, after setting all properties.
function editThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text9.
function text9_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text9,'Visible','off');


% --- Executes on button press in pbAboutBack.
function pbAboutBack_Callback(hObject, eventdata, handles)
% hObject    handle to pbAboutBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text9,'Visible','off');
set(handles.pbAboutBack,'Visible','off');
