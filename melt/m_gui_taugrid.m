function varargout = m_gui_taugrid(varargin)
% M_GUI_TAUGRID M-file for m_gui_taugrid.fig
%      M_GUI_TAUGRID, by itself, creates a new M_GUI_TAUGRID or raises the existing
%      singleton*.
%
%      H = M_GUI_TAUGRID returns the handle to a new M_GUI_TAUGRID or the handle to
%      the existing singleton*.
%
%      M_GUI_TAUGRID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M_GUI_TAUGRID.M with the given input arguments.
%
%      M_GUI_TAUGRID('Property','Value',...) creates a new M_GUI_TAUGRID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m_gui_taugrid_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m_gui_taugrid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help m_gui_taugrid

% Last Modified by GUIDE v2.5 07-Dec-2005 19:23:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m_gui_taugrid_OpeningFcn, ...
                   'gui_OutputFcn',  @m_gui_taugrid_OutputFcn, ...
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


% --- Executes just before m_gui_taugrid is made visible.
function m_gui_taugrid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m_gui_taugrid (see VARARGIN)

% Choose default command line output for m_gui_taugrid
handles.output = hObject;
% if DATFULL not defined load data
if ~evalin('base','exist(''DATFULL'',''var'')')      
    evalin('base','clear');
    figure_info=m_gui_info(['Loading data',char(10),'Please Wait...']);
    drawnow;
    evalin('base','m_input');
    evalin('base','m_data');                                	
    delete(figure_info);
end
% fill fields
set(handles.edit_t0shift,'String',num2str(evalin('base','t0shift')));
set(handles.edit_Ntau,'String',num2str(evalin('base','Ntau')));
set(handles.edit_taumin,'String',num2str(evalin('base','taumin')));
set(handles.edit_taumax,'String',num2str(evalin('base','taumax')));
set(handles.edit_fwhm,'String',num2str(evalin('base','fwhm')'));
set(handles.edit_fwhmint,'String',num2str(evalin('base','fwhmint')'));
set(handles.edit_fwhmzero,'String',num2str(evalin('base','fwhmzero')'));
handles.t0fine=0;
handles.TCind=1;
% if TC not defined calculate matrix
if ~evalin('base','exist(''TC'',''var'')')
    figure_info=m_gui_info(['Calculating analysis matrix',char(10),'Please Wait...']);
    drawnow;
    evalin('base','m_tcmat');
    delete(figure_info);
end
% set sliders
set(handles.slider_TC,'Value',handles.TCind);
set(handles.slider_TC,'Min',1);
set(handles.slider_TC,'Max',evalin('base','Ntau'));
set(handles.slider_TC,'Sliderstep',[1/evalin('base','Ntau'),1/evalin('base','Ntau')]);
set(handles.text_tau,'String',['tau = ',num2str(evalin('base',['tau(',num2str(handles.TCind),')']),'%10.1f'),' ps']);
handles.t0fine=round(get(handles.slider_t0,'Value')*100)/100;
set(handles.text_t0fine,'String',['t0fine = ',num2str(handles.t0fine)]);
% plot
set(0,'CurrentFigure',handles.figure_taugrid);
set(handles.figure_taugrid,'CurrentAxes',handles.axes_TC);
handles.datline=line((1:evalin('base','left_of_max')*2),evalin('base','D(1:left_of_max*2)/maxdat'),'Marker','o','Color',[1,0,0]);
evalin('base','[maxTC,maxTCind]=max(TC(:,:));');
TCcurr=['TC(1+firstchannel-left_of_max:firstchannel-left_of_max+left_of_max*2,',num2str(handles.TCind),')./maxTC(',num2str(handles.TCind),')'];
handles.TCline=line((1:evalin('base','left_of_max')*2)+handles.t0fine,evalin('base',TCcurr),'Marker','o');

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes m_gui_taugrid wait for user response (see UIRESUME)
% uiwait(handles.figure_taugrid);

% --- Outputs from this function are returned to the command line.
function varargout = m_gui_taugrid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMMON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ACTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pushbutton_loadTC_Callback(hObject, eventdata, handles)
evalin('base',['load(''',get(handles.edit_TCfile,'String'),''');']);
set(handles.edit_t0shift,'String',num2str(evalin('base','t0shift')));
set(handles.edit_Ntau,'String',num2str(evalin('base','Ntau')));
set(handles.edit_taumin,'String',num2str(evalin('base','taumin')));
set(handles.edit_taumax,'String',num2str(evalin('base','taumax')));
set(handles.edit_fwhm,'String',num2str(evalin('base','fwhm')'));
set(handles.edit_fwhmint,'String',num2str(evalin('base','fwhmint')'));
set(handles.edit_fwhmzero,'String',num2str(evalin('base','fwhmzero')'));
handles.t0fine=0;
set(handles.slider_t0,'Value',handles.t0fine);
handles.TCind=1;
set(handles.slider_TC,'Value',handles.TCind);
set(handles.figure_taugrid,'CurrentAxes',handles.axes_TC);
handles.datline=line((1:evalin('base','left_of_max')*2),evalin('base','D(1:left_of_max*2)/maxdat'),'Marker','o','Color',[1,0,0]);
%pushbutton_recalculate_Callback(hObject, eventdata, handles);set(handles.slider_TC,'Min',1);

set(handles.slider_TC,'Max',evalin('base','Ntau'));
set(handles.slider_TC,'Sliderstep',[1/evalin('base','Ntau'),1/evalin('base','Ntau')]);
set(handles.text_tau,'String',['tau = ',num2str(evalin('base',['tau(',num2str(handles.TCind),')']),'%10.1f'),' ps']);
handles.t0fine=round(get(handles.slider_t0,'Value')*100)/100;
set(handles.text_t0fine,'String',['t0fine = ',num2str(handles.t0fine)]);

evalin('base','[maxTC,maxTCind]=max(TC(:,:));');
TCcurr=['TC(1+firstchannel-left_of_max:firstchannel-left_of_max+left_of_max*2,',num2str(handles.TCind),')./maxTC(',num2str(handles.TCind),')'];
set(handles.figure_taugrid,'CurrentAxes',handles.axes_TC);
delete(handles.TCline);
handles.TCline=line((1:evalin('base','left_of_max')*2)+handles.t0fine,evalin('base',TCcurr),'Marker','o');
guidata(hObject, handles);


function pushbutton_findmtx_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile;
if ~strcmp(pathname,[pwd,'\'])
    filename=[pathname,filename];
end
if isstr(filename)
    set(handles.edit_TCfile,'String',filename);
end

function pushbutton_saveTC_Callback(hObject, eventdata, handles)
savemat=['save ',get(handles.edit_TCfile,'String'),' ndat Ntau taumin taumax fwhm fwhmint fwhmzero psperchannel t0shift TC'];
evalin('base',savemat);


function edit_Ntau_Callback(hObject, eventdata, handles)
evalin('base',['Ntau=',get(handles.edit_Ntau,'String'),';']);


function edit_taumin_Callback(hObject, eventdata, handles)
evalin('base',['taumin=',get(handles.edit_taumin,'String'),';']);


function edit_taumax_Callback(hObject, eventdata, handles)
evalin('base',['taumax=',get(handles.edit_taumax,'String'),';']);


function edit_t0shift_Callback(hObject, eventdata, handles)
evalin('base',['t0shift=',get(handles.edit_t0shift,'String'),';']);


function pushbutton_recalculate_Callback(hObject, eventdata, handles)
figure_info=m_gui_info(['Calculating analysis matrix',char(10),'Please Wait...']);
drawnow;
evalin('base','m_tcmat');
delete(figure_info);

handles.TCind=1;
set(handles.slider_TC,'Value',handles.TCind);
set(handles.slider_TC,'Min',1);
set(handles.slider_TC,'Max',evalin('base','Ntau'));
set(handles.slider_TC,'Sliderstep',[1/evalin('base','Ntau'),1/evalin('base','Ntau')]);
set(handles.text_tau,'String',['tau = ',num2str(evalin('base',['tau(',num2str(handles.TCind),')']),'%10.1f'),' ps']);
handles.t0fine=round(get(handles.slider_t0,'Value')*100)/100;
set(handles.text_t0fine,'String',['t0fine = ',num2str(handles.t0fine)]);

evalin('base','[maxTC,maxTCind]=max(TC(:,:));');
TCcurr=['TC(1+firstchannel-left_of_max:firstchannel-left_of_max+left_of_max*2,',num2str(handles.TCind),')./maxTC(',num2str(handles.TCind),')'];
set(handles.figure_taugrid,'CurrentAxes',handles.axes_TC);
delete(handles.TCline);
handles.TCline=line((1:evalin('base','left_of_max')*2)+handles.t0fine,evalin('base',TCcurr),'Marker','o');
guidata(hObject, handles);


function slider_TC_Callback(hObject, eventdata, handles)
handles.TCind=round(get(handles.slider_TC,'Value'));
set(handles.text_tau,'String',['tau = ',num2str(evalin('base',['tau(',num2str(handles.TCind),')']),'%10.1f'),' ps']);
handles.t0fine=round(get(handles.slider_t0,'Value')*100)/100;
set(handles.text_t0fine,'String',['t0fine = ',num2str(handles.t0fine)]);

evalin('base','[maxTC,maxTCind]=max(TC(:,:));');
TCcurr=['TC(1+firstchannel-left_of_max:firstchannel-left_of_max+left_of_max*2,',num2str(handles.TCind),')./maxTC(',num2str(handles.TCind),')'];
set(handles.figure_taugrid,'CurrentAxes',handles.axes_TC);
delete(handles.TCline);
handles.TCline=line((1:evalin('base','left_of_max')*2)+handles.t0fine,evalin('base',TCcurr),'Marker','o');
guidata(hObject, handles);


function slider_t0_Callback(hObject, eventdata, handles)
slider_TC_Callback(hObject, eventdata, handles)


function pushbutton_t0apply_Callback(hObject, eventdata, handles)
evalin('base',['t0shift=t0shift+',num2str(handles.t0fine),';']);
set(handles.edit_t0shift,'String',num2str(evalin('base','t0shift')));
handles.t0fine=0;
set(handles.slider_t0,'Value',handles.t0fine);
pushbutton_recalculate_Callback(hObject, eventdata, handles);


function pushbutton_zoom_Callback(hObject, eventdata, handles)
zoom;


function pushbutton_zoomfull_Callback(hObject, eventdata, handles)
zoom out;


function pushbutton_pan_Callback(hObject, eventdata, handles)
pan;


function edit_fwhm_Callback(hObject, eventdata, handles)
fwhms=get(handles.edit_fwhm,'String');
evalin('base','clear fwhm');
for i=1:length(fwhms(:,1))
    evalin('base',['fwhm(',num2str(i),')=',(fwhms(i,:)),';']);
end


function edit_fwhmint_Callback(hObject, eventdata, handles)
fwhmints=get(handles.edit_fwhmint,'String');
evalin('base','clear fwhmint');
for i=1:length(fwhmints(:,1))
    evalin('base',['fwhmint(',num2str(i),')=',(fwhmints(i,:)),';']);
end
    

function edit_fwhmzero_Callback(hObject, eventdata, handles)
fwhmzeros=get(handles.edit_fwhmzero,'String');
evalin('base','clear fwhmzero');
for i=1:length(fwhmzeros(:,1))
    evalin('base',['fwhmzero(',num2str(i),')=',(fwhmzeros(i,:)),';']);
end
%figure_info=m_gui_info(fwhmzeros);



