function varargout = FilterDesignGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FilterDesignGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FilterDesignGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before FilterDesignGUI is made visible.

function FilterDesignGUI_OpeningFcn(hObject, eventdata, handles, varargin)
global C Fs audiorr;
Fs=58000;
C=zeros(1,5);
 audiorr = [];
% Set the minimum and maximum values for the sliders
set(handles.Band1, 'min', -12, 'max', 12);
set(handles.Band2, 'min', -12, 'max', 12);
set(handles.Band3, 'min', -12, 'max', 12);
set(handles.Band4, 'min', -12, 'max', 12);
set(handles.Band5, 'min', -12, 'max', 12);

% Set the slider range to represent values between -12 and 12 dB
set(handles.Band1, 'SliderStep', [1/24, 1/12]);
set(handles.Band2, 'SliderStep', [1/24, 1/12]);
set(handles.Band3, 'SliderStep', [1/24, 1/12]);
set(handles.Band4, 'SliderStep', [1/24, 1/12]);
set(handles.Band5, 'SliderStep', [1/24, 1/12]);

% Set initial values for sliders
set(handles.Band1, 'value', 0);
set(handles.Band2, 'value', 0);
set(handles.Band3, 'value', 0);
set(handles.Band4, 'value', 0);
set(handles.Band5, 'value', 0);


handles.output = hObject;
guidata(hObject, handles);

axes(handles.axes6)
imshow('LOGO.png')

% --- Outputs from this function are returned to the command line.
function varargout = FilterDesignGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global audiorr
varargout{1} = handles.output;

% getting butterworth coefficients  and cuttoff frequencies
function [a,b]=butter_coef()
Q = 0.85;
fc = [63 250 1000 4000 16000];
fc1= zeros(1,5);
fc2= zeros(1,5);
for i =1:5
    fc1(i) = -fc(i)/(2*Q)+fc(i)*sqrt(1/(Q^2)+4)/2;
    fc2(i) = fc(i)/Q + fc1(i);
end
Fs = 58000;
[b1 a1] = butter(3,[fc1(1) fc2(1)]/(Fs/2),'bandpass');
[b2 a2] = butter(4,[fc1(2) fc2(2)]/(Fs/2),'bandpass');
[b3 a3] = butter(2,[fc1(3) fc2(3)]/(Fs/2),'bandpass');
[b4 a4] = butter(3,[fc1(4) fc2(4)]/(Fs/2),'bandpass');
[b5 a5] = butter(3,[fc1(5) fc2(5)]/(Fs/2),'bandpass');
a={a1,a2,a3,a4,a5};
b={b1,b2,b3,b4,b5};

% Input plot
function input_plot(handles)
global file_name;
[x,Fs] = audioread(file_name);
axes(handles.axes1)
t = linspace(0,length(x)/Fs,length(x));
plot(t,x);xlabel('Time [sec]');
 
ylabel('Magnitude');
grid on;
axes(handles.axes2)
Nfft =1024;
f = linspace(0,Fs,Nfft);
G = abs(fft(x,Nfft));
plot(f(1:Nfft/2),G(1:Nfft/2));
xlabel('Frequency [Hz]');
ylabel('Magnitude');
grid on;

% output plot
function output_plot(handles)
    global C  file_name;
    [x,Fs] = audioread(file_name);
    [a,b]=butter_coef();
    sampleRate=2*Fs;
    y=0;
    for k=1:5
        y=y+db2mag(C(k))*filter(b{k},a{k},x);
    end
      %Output Time Plot
    axes(handles.axes3);
    t = linspace(0,length(y)/Fs,length(y));
    plot(t,y);
    xlabel('Time [sec]');
    ylabel('Magnitude');
    grid on;
  %Output Spectral Plot
    axes(handles.axes4);
    Nfft =1024;
    f = linspace(0,Fs,Nfft);
    G = abs(fft(y,Nfft));
    plot(f(1:Nfft/2),G(1:Nfft/2));
    xlabel('Frequency [Hz]');
    ylabel('Magnitude');
    grid on;

% --- Executes on slider movement.
function Band1_Callback(hObject, eventdata, handles)
global C;
C(1)=get(hObject,'value');
set(handles.Band1_val,'string',num2str(C(1)));
update_play_button_string(handles);

% --- Executes during object creation, after setting all properties.
function Band1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Band1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function Band2_Callback(hObject, eventdata, handles)
global C;
C(2)=get(hObject,'value');
set(handles.Band2_val,'string',num2str(C(2)));
update_play_button_string(handles);
% --- Executes during object creation, after setting all properties.
function Band2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Band3_Callback(hObject, eventdata, handles)
global C;
C(3)=get(hObject,'value');
set(handles.Band3_val,'string',num2str(C(3)));
update_play_button_string(handles);
% --- Executes during object creation, after setting all properties.
function Band3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function Band4_Callback(hObject, eventdata, handles)
global C;
C(4)=get(hObject,'value');
set(handles.Band4_val,'string',num2str(C(4)));
update_play_button_string(handles);

function Band4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function Band5_Callback(hObject, eventdata, handles)
global C;
C(5)=get(hObject,'value');
set(handles.Band5_val,'string',num2str(C(5)));
update_play_button_string(handles);

function Band5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function update_play_button_string(handles)
global C;
play_button = handles.PLAY;

% Check if any slider value is not equal to 0
if any(C ~= 0)
    % If yes, set the PLAY button string to 'Equalizer'
    set(play_button, 'String', 'Apply');
else
    % If all slider values are 0, set the PLAY button string to 'Play'
    set(play_button, 'String', 'Play');
end
% --- Executes on button press in PLAY.
function PLAY_Callback(hObject, eventdata, handles)
    global C  file_name audiorr;

    % Check if 'audiorr' is not empty
    if isempty(audiorr)
        % If 'audiorr' is empty, load the audio
        [x, Fs] = audioread(fullfile(pwd, file_name));
        [a, b] = butter_coef();
        sampleRate = 2 * Fs;
        y = 0;
        for k = 1:5
            y = y + db2mag(C(k)) * filter(b{k}, a{k}, x);
        end
        audiorr = audioplayer(y, Fs);
        play(audiorr);
    else
       plot_all(handles)
    end




function plot_all(handles)
    global C Fs audiorr file_name;
    
    
    % Plot input
    input_plot(handles);
    
    % Plot output
    output_plot(handles);
    
    % Load the audio file
    [x, Fs] = audioread(fullfile(pwd, file_name));
    
    % Apply the filter settings to the audio
    [a, b] = butter_coef();
    y = 0;
    for k = 1:5
        y = y + db2mag(C(k)) * filter(b{k}, a{k}, x);
    end
    
    % Play the updated audio
    audiorr = audioplayer(y, Fs);
    play(audiorr);
% --- Executes on button press in LOAD.
function LOAD_Callback(hObject, eventdata, handles)
global file_name audiorr;
file_name = uigetfile('*wav');
 plot_all(handles);
if ~isempty(audiorr) && isplaying(audiorr)
        stop(audiorr);

    
end
% input_plot(handles);
% output_plot(handles);
% --- Executes on button press in RESET.
function RESET_Callback(hObject, eventdata, handles)
    global Fs C file_name audiorr;

    % Clear the loaded file
    file_name = '';

    % Set gain values to zero
    C = zeros(1, 5);

    % Set text fields to show zero
    set(handles.Band1_val, 'string', num2str(0));
    set(handles.Band2_val, 'string', num2str(0));
    set(handles.Band3_val, 'string', num2str(0));
    set(handles.Band4_val, 'string', num2str(0));
    set(handles.Band5_val, 'string', num2str(0));

    % Reset slider values to center
    set(handles.Band1, 'value', 0);
    set(handles.Band2, 'value', 0);
    set(handles.Band3, 'value', 0);
    set(handles.Band4, 'value', 0);
    set(handles.Band5, 'value', 0);

    % Clear input and output plots
    cla(handles.axes1);
    cla(handles.axes2);
    cla(handles.axes3);
    cla(handles.axes4);

    % Check if 'audiorr' is not empty and is playing
    if ~isempty(audiorr) && isplaying(audiorr)
        stop(audiorr);
    end



% --- Executes on slider movement.

function Band1_val_Callback(hObject, eventdata, handles)
global C;
C(1)=str2double(get(hObject,'string'));
minn=get(handles.Band1,'min');
maxx=get(handles.Band1,'max');
if(C(1)<minn || C(1)>maxx)
    C(1)=get(handles.Band1,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.Band1,'value',C(1));
end
function Band1_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Band2_val_Callback(hObject, eventdata, handles)
global C;
C(2)=str2double(get(hObject,'string'));
minn=get(handles.Band2,'min');
maxx=get(handles.Band2,'max');
if(C(2)<minn || C(2)>maxx)
    C(2)=get(handles.Band,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.Band1,'value',C(2));
end
function Band2_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Band3_val_Callback(hObject, eventdata, handles)
global C;
C(3)=str2double(get(hObject,'string'));
minn=get(handles.Band3,'min');
maxx=get(handles.Band3,'max');
if(C(3)<minn || C(3)>maxx)
    C(3)=get(handles.Band3,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.Band3,'value',C(1));
end
function Band3_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Band4_val_Callback(hObject, eventdata, handles)
global C;
C(4)=str2double(get(hObject,'string'));
minn=get(handles.Band4,'min');
maxx=get(handles.Band4,'max');
if(C(4)<minn || C(4)>maxx)
    C(4)=get(handles.Band4,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.Band1,'value',C(4));
end
function Band4_val_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Band5_val_Callback(hObject, eventdata, handles)
global C;
C(5)=str2double(get(hObject,'string'));
minn=get(handles.Band5,'min');
maxx=get(handles.Band5,'max');
if(C(5)<minn || C(5)>maxx)
    C(5)=get(handles.Band1,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.Band5,'value',C(5));
end
function Band5_val_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in STOP.
function STOP_Callback(hObject, eventdata, handles)
global audiorr;
    % Check if 'audiorr' is not empty and is playing
    if ~isempty(audiorr) && isplaying(audiorr)
       pause(audiorr);
    end
    
 % --- Executes on button press in EXIT.
function EXIT_Callback(hObject, eventdata, handles)
    % Assuming 'fig' is the handle to your main GUI figure
    fig = handles.figure1;  % Replace 'figure1' with the actual name of your figure handle

    % Display a confirmation dialog
    choice = questdlg('Do you want to exit the application?', 'Exit Confirmation', 'Yes', 'No', 'No');

    % Process the user's choice
    if strcmp(choice, 'Yes')
        % Close the figure (exit the app)
        close(fig);
        disp('Application closed.');
    else
        % Do nothing or perform additional actions if needed
        disp('Exit cancelled.');
    end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
