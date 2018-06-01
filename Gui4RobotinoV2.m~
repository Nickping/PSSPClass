function varargout = Gui4RobotinoV2(varargin)
% GUI4ROBOTINOV2 MATLAB code for Gui4RobotinoV2.fig
%      GUI4ROBOTINOV2, by itself, creates a new GUI4ROBOTINOV2 or raises the existing
%      singleton*.
%
%      H = GUI4ROBOTINOV2 returns the handle to a new GUI4ROBOTINOV2 or the handle to
%      the existing singleton*.
%
%      GUI4ROBOTINOV2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI4ROBOTINOV2.M with the given input arguments.
%
%      GUI4ROBOTINOV2('Property','Value',...) creates a new GUI4ROBOTINOV2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui4RobotinoV2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui4RobotinoV2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui4RobotinoV2

% Last Modified by GUIDE v2.5 01-Jun-2018 10:32:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui4RobotinoV2_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui4RobotinoV2_OutputFcn, ...
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


% --- Executes just before Gui4RobotinoV2 is made visible.
function Gui4RobotinoV2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui4RobotinoV2 (see VARARGIN)

% Choose default command line output for Gui4RobotinoV2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui4RobotinoV2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
evalin('base','clear all')
assignin('base','ExitFlag',0);
assignin('base','InitialAngle',0);

DistanceMatrix = xlsread('WeightMatrix.xls');
assignin('base','Algorithm',0);
DistanceMatrix = DistanceMatrix(2:end,2:end);
IndexInf = find(DistanceMatrix==0);
DistanceMatrix(IndexInf)=Inf;
assignin('base','DistanceMatrix',DistanceMatrix);
drawingGridlayout();

function drawingGridlayout()



% --- Outputs from this function are returned to the command line.
function varargout = Gui4RobotinoV2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadButton.
function LoadButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','ComId = Com_construct');
evalin('base','MotorId0 = Motor_construct( 0 )');
evalin('base','MotorId1 = Motor_construct( 1 )');
evalin('base','MotorId2 = Motor_construct( 2 )');
evalin('base','CameraId = Camera_construct');
evalin('base','OdometryId = Odometry_construct');
evalin('base','Com_setAddress(ComId, ''192.168.1.203'')');
evalin('base','Com_connect(ComId)');
evalin('base','Motor_setComId( MotorId0, ComId )');
evalin('base','Motor_setComId( MotorId1, ComId )');
evalin('base','Motor_setComId( MotorId2, ComId )');
evalin('base','Camera_setComId(CameraId, ComId)');
evalin('base','Odometry_setComId( OdometryId, ComId )');
evalin('base','clc');
evalin('base','clear img');
evalin('base','load ExtrinsicResults.mat');
evalin('base','clear theta');
Rc_ext=evalin('base','Rc_ext');
Tc_ext=evalin('base','Tc_ext');
KK=evalin('base','KK');
CameraId=evalin('base','CameraId');
while evalin('base','exist(''img'')~=1')
     if ~(Camera_setStreaming(CameraId, 1) == 1)
        disp('Camera_setStreaming failed.');
     end
     if (Camera_grab(CameraId) == 1)
        img = Camera_getImage( CameraId );
        assignin('base','img',img);
     end
     pause(.1);
end

% (msgbox('Cam initialised and robot ready to go!','Information to the user','warn'))
set(handles.text2,'BackgroundColor','green');
set(handles.text2,'String','Parameters already loaded!');
set(handles.DisconnectButton,'Visible','on')
set(handles.LoadButton,'Visible','off')
set(handles.DisconnectButton,'Visible','on')
set(handles.EditListOfWayPoints,'Visible','on')
set(handles.EditInitialAngle,'Visible','on')
set(handles.text16,'Visible','on')
set(handles.text5,'Visible','on')
% --- Executes on button press in DisconnectButton.
function DisconnectButton_Callback(hObject, eventdata, handles)
% hObject    handle to DisconnectButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base','ExitFlag',1);

evalin('base','Com_disconnect(ComId);');

evalin('base','Com_destroy(ComId);');
evalin('base','Motor_destroy(MotorId0);');
evalin('base','Motor_destroy(MotorId1);');
evalin('base','Motor_destroy(MotorId2);');

evalin('base','Camera_destroy(CameraId);');
evalin('base','Odometry_destroy( OdometryId );');

if evalin('base','ExitFlag')
    close(Gui4RobotinoV2);
end
    

function EditInitialNode_Callback(hObject, eventdata, handles)
% hObject    handle to EditInitialNode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditInitialNode as text
%        str2double(get(hObject,'String')) returns contents of EditInitialNode as a double
assignin('base','InitialNode',str2num(get(handles.EditInitialNode,'String')))

% --- Executes during object creation, after setting all properties.
function EditInitialNode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditInitialNode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditTargetNode_Callback(hObject, eventdata, handles)
% hObject    handle to EditTargetNode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditTargetNode as text
%        str2double(get(hObject,'String')) returns contents of EditTargetNode as a double
assignin('base','TargetNode',str2num(get(hObject,'String')))


% --- Executes during object creation, after setting all properties.
function EditTargetNode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditTargetNode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditListOfWayPoints_Callback(hObject, eventdata, handles)
% hObject    handle to EditListOfWayPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditListOfWayPoints as text
%        str2double(get(hObject,'String')) returns contents of EditListOfWayPoints as a double
assignin('base','ListOfWayPoints',str2num(get(handles.EditListOfWayPoints,'String')));
assignin('base','InitialNode',evalin('base','ListOfWayPoints(1)'));
assignin('base','TargetNode',evalin('base','ListOfWayPoints(2)'));
set(handles.GoButton,'Visible','on')
set(handles.text7,'Visible','on')
set(handles.text8,'Visible','on')
set(handles.text9,'Visible','on')
set(handles.text10,'Visible','on')
set(handles.text13,'Visible','on')
set(handles.text14,'Visible','on')
set(handles.text15,'Visible','on')


% --- Executes during object creation, after setting all properties.
function EditListOfWayPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditListOfWayPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GoButton.
function GoButton_Callback(hObject, eventdata, handles)
% hObject    handle to GoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.GoButton,'BackgroundColor','yellow');
ComId=evalin('base','ComId');
OdometryId=evalin('base','OdometryId');
CameraId=evalin('base','CameraId');
MotorId0=evalin('base','MotorId0');
MotorId1=evalin('base','MotorId1');
MotorId2=evalin('base','MotorId2');
Rc_ext=evalin('base','Rc_ext');
Tc_ext=evalin('base','Tc_ext');
KK=evalin('base','KK');
InitialNode=evalin('base','ListOfWayPoints(1)');
set(handles.text13,'String',num2str(InitialNode));
InitialAngle=evalin('base','InitialAngle');
set(handles.text15,'String','');
TargetNode=evalin('base','ListOfWayPoints(2)');
set(handles.text14,'String',num2str(TargetNode));
evalin('base','clear EndAngle');
ListOfWayPoints=evalin('base','ListOfWayPoints');
for i=1:length(ListOfWayPoints)-1
    InitialNode=ListOfWayPoints(i);
    TargetNode=ListOfWayPoints(i+1);
    set(handles.text14,'String',num2str(TargetNode));
    set(handles.text13,'String',num2str(InitialNode));
    [ EndNode,EndAngle ] = RunningFreeWithoutDisconnection( InitialNode,TargetNode,InitialAngle,MotorId0,MotorId1,MotorId2,CameraId,OdometryId,Rc_ext,Tc_ext,KK );
    InitialAngle=EndAngle;
end

% % % while evalin('base','~exist(''EndAngle'')')
% % %     pause(1)
% % % end
set(handles.text15,'String',num2str(EndAngle));
set(handles.GoButton,'BackgroundColor','green');
pause(1)
set(handles.GoButton,'BackgroundColor','red');
set(handles.EditInitialAngle,'String',num2str(EndAngle));
assignin('base','InitialAngle',EndAngle);




function EditInitialAngle_Callback(hObject, eventdata, handles)
% hObject    handle to EditInitialAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditInitialAngle as text
%        str2double(get(hObject,'String')) returns contents of EditInitialAngle as a double
assignin('base','InitialAngle',str2num(get(handles.EditInitialAngle,'String')))


% --- Executes during object creation, after setting all properties.
function EditInitialAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditInitialAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
DistanceMatrix = evalin('base','DistanceMatrix');
algorithm = evalin('base','Algorithm');
ListOfWp = pathPlanning(DistanceMatrix,0,1,10,algorithm);
Nodes = NodesToCoordinates(ListOfWp);

assignin('base','Coordinates',Nodes);
assignin('base','ListOfWp',ListOfWp);

if evalin('base','Algorithm') ~= 0 %
ListOfWp = transpose(ListOfWp);
end

NodeStr = num2str(ListOfWp);
disp(NodeStr);
NodesToGo = findobj('Tag','Node');

set(NodesToGo,'string',NodeStr);

EditListOfWayPoints = findobj('Tag','EditListOfWayPoints');
set(EditListOfWayPoints,'string',NodeStr);





% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)


% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

hold on;
           
%handels.Name,....

%hold on- >CreateFcn 
% for i=1:size(gridSource1,1)-1
% 
%     plot(gridSource1(i:i+1,1),gridSource1(i:i+1,2),'-r');
% 
% end
% for i=1:size(gridSource2,1)-1
%     plot(gridSource2(i:i+1,1),gridSource2(i:i+1,2),'-r');
% end
% 
% for i=1:size(gridSource3,1)-1
%     plot(gridSource3(i:i+1,1),gridSource3(i:i+1,2),'-r');
% end
% for i=1:size(gridSource4,1)-1
%     plot(gridSource4(i:i+1,1),gridSource4(i:i+1,2),'-r');
% end
% for i=1:size(gridSource5,1)-1
%     plot(gridSource5(i:i+1,1),gridSource5(i:i+1,2),'-r');
% end
% for i=1:size(gridSource6,1)-1
%     plot(gridSource6(i:i+1,1),gridSource6(i:i+1,2),'-r');
% end
% for i=1:size(gridSource7,1)-1
%     plot(gridSource7(i:i+1,1),gridSource7(i:i+1,2),'-r');
% end
% for i=1:size(gridSource8,1)-1
%     plot(gridSource8(i:i+1,1),gridSource8(i:i+1,2),'-r');
% end


% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(hObject, 'String'));
algorithm = contents{get(hObject,'Value')};

disp(contents{get(hObject,'Value')});
if strcmp(algorithm,'Greedy')
    assignin('base','Algorithm',0);
end
if strcmp(algorithm,'A star')
        assignin('base','Algorithm',1);

end
if strcmp(algorithm,'Dijkstra')
        assignin('base','Algorithm',2);

end

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton6_CreateFcn(hObject, eventdata, handles)


% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
