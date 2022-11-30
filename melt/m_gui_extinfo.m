function varargout = m_gui_extinfo(varargin)
% M_GUI_EXTINFO M-file for m_gui_extinfo.fig
%      M_GUI_EXTINFO, by itself, creates a new M_GUI_EXTINFO or raises the existing
%      singleton*.
%
%      H = M_GUI_EXTINFO returns the handle to a new M_GUI_EXTINFO or the handle to
%      the existing singleton*.
%
%      M_GUI_EXTINFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M_GUI_EXTINFO.M with the given input arguments.
%
%      M_GUI_EXTINFO('Property','Value',...) creates a new M_GUI_EXTINFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m_gui_extinfo_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m_gui_extinfo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help m_gui_extinfo

% Last Modified by GUIDE v2.5 13-Dec-2005 21:48:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m_gui_extinfo_OpeningFcn, ...
                   'gui_OutputFcn',  @m_gui_extinfo_OutputFcn, ...
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


% --- Executes just before m_gui_extinfo is made visible.
function m_gui_extinfo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m_gui_extinfo (see VARARGIN)

% Choose default command line output for m_gui_extinfo
handles.output = hObject;

% Update text
if strcmp(varargin(3),'replace')
%    set(handles.edit_info,'Max',20);
    set(handles.edit_info,'String',varargin(2));
elseif strcmp(varargin(3),'add')
%    set(handles.edit_info,'Max',get(handles.edit_info,'Max')+1);
    set(handles.edit_info,'String',vertcat(get(handles.edit_info,'String'),varargin(2)));
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes m_gui_extinfo wait for user response (see UIRESUME)
% uiwait(handles.figure_);


% --- Outputs from this function are returned to the command line.
function varargout = m_gui_extinfo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function pushbutton_close_Callback(hObject, eventdata, handles)
close

