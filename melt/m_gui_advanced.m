function varargout = m_gui_advanced(varargin)
% M_GUI_ADVANCED M-file for m_gui_advanced.fig
%      M_GUI_ADVANCED, by itself, creates a new M_GUI_ADVANCED or raises the existing
%      singleton*.
%
%      H = M_GUI_ADVANCED returns the handle to a new M_GUI_ADVANCED or the handle to
%      the existing singleton*.
%
%      M_GUI_ADVANCED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M_GUI_ADVANCED.M with the given input arguments.
%
%      M_GUI_ADVANCED('Property','Value',...) creates a new M_GUI_ADVANCED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m_gui_advanced_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m_gui_advanced_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help m_gui_advanced

% Last Modified by GUIDE v2.5 07-Dec-2005 19:05:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m_gui_advanced_OpeningFcn, ...
                   'gui_OutputFcn',  @m_gui_advanced_OutputFcn, ...
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


% --- Executes just before m_gui_advanced is made visible.
function m_gui_advanced_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m_gui_advanced (see VARARGIN)

% Choose default command line output for m_gui_advanced
handles.output = hObject;

set(handles.edit_enditer,'String',num2str(evalin('base','enditer')));
set(handles.edit_maxchi,'String',num2str(evalin('base','maxchi')));
set(handles.edit_lastiter,'String',num2str(evalin('base','lastiter')));
set(handles.edit_itermaxdev,'String',num2str(evalin('base','itermaxdev')));
set(handles.checkbox_verbose,'Value',evalin('base','verbose'));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes m_gui_advanced wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = m_gui_advanced_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit_enditer_Callback(hObject, eventdata, handles)
evalin('base',['enditer=',get(handles.edit_enditer,'String'),';']);


function edit_maxchi_Callback(hObject, eventdata, handles)
evalin('base',['maxchi=',get(handles.edit_maxchi,'String'),';']);


function edit_lastiter_Callback(hObject, eventdata, handles)
evalin('base',['lastiter=',get(handles.edit_lastiter,'String'),';']);


function edit_itermaxdev_Callback(hObject, eventdata, handles)
evalin('base',['itermaxdev=',get(handles.edit_itermaxdev,'String'),';']);


function checkbox_verbose_Callback(hObject, eventdata, handles)
evalin('base',['verbose=',num2str(get(handles.checkbox_verbose,'Value')),';']);


