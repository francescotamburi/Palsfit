function varargout = m_gui(varargin)
% M_GUI M-file for m_gui.fig
%      M_GUI, by itself, creates axes_spectrum new M_GUI or raises the existing
%      singleton*.
%
%      H = M_GUI returns the handle to axes_spectrum new M_GUI or the handle to
%      the existing singleton*.
%
%      M_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M_GUI.M with the given input arguments.
%
%      M_GUI('Property','Value',...) creates axes_spectrum new M_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help m_gui

% Last Modified by GUIDE v2.5 03-Dec-2010 15:36:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @m_gui_OutputFcn, ...
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


% --- Executes just before m_gui is made visible.
function m_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in axes_spectrum future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m_gui (see VARARGIN)

% Choose default command line output for m_gui
handles.output = hObject;

%evalin('base','clear');

% Update handles structure
guidata(hObject, handles);

pushbutton_loadset_Callback(hObject, eventdata, handles, 'm_input.mat');

% UIWAIT makes m_gui wait for user response (see UIRESUME)
% uiwait(handles.figure_melt);


% --- Outputs from this function are returned to the command line.
function varargout = m_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in axes_spectrum future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_bg_lines(hObject, handles)
handles.bgline=line([handles.xlimits(1),handles.xlimits(2)],...
    [evalin('base','bg'),evalin('base','bg')],'Color',[.5,0,0]);
handles.bgstartline=line([evalin('base','startbg')-.1,evalin('base','startbg')+.1],...
    [handles.ylimits(1),handles.ylimits(2)],'Color',[.5,0,.5]);
handles.bgstopline=line([evalin('base','stopbg')-.1,evalin('base','stopbg')+.1],...
    [handles.ylimits(1),handles.ylimits(2)],'Color',[.5,0,.5]);
guidata(hObject, handles);


function delplot_bg_lines(hObject, handles)
delete(handles.bgline);
delete(handles.bgstartline);
delete(handles.bgstopline);
plot_bg_lines(hObject, guidata(hObject))


function plot_dat_lines(hObject, handles)
handles.startline=line([evalin('base','startD')-.1,evalin('base','startD')+.1],...
    [handles.ylimits(1),handles.ylimits(2)],'Color',[0,.5,0]);
handles.stopline=line([evalin('base','stopdat')-.1,evalin('base','stopdat')+.1],...
    [handles.ylimits(1),handles.ylimits(2)],'Color',[0,.5,0]);
guidata(hObject, handles);


function delplot_dat_lines(hObject, handles)
delete(handles.startline);
delete(handles.stopline);
plot_dat_lines(hObject, guidata(hObject))

function show_entsteps(hObject, handles)
if strcmp(evalin('base','entsteps'),'1')
    set(handles.edit_entmax,'Visible','off');
    entstepstr=evalin('base','entmin');
else
    set(handles.edit_entmax,'Visible','on');
    entlogsteps=log10(evalin('base','eval(entmin)')):...
        evalin('base','(log10(eval(entmax))-log10(eval(entmin)))/(eval(entsteps)-1)'):...
        log10(evalin('base','eval(entmax)'));
    entstepstr='';
    for i=1:length(entlogsteps)
        entstepstr=[entstepstr,num2str([10.^entlogsteps(i),],'%4.1e'),char(10)];
    end
end
set(handles.edit_entsteps,'TooltipString',entstepstr);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%feature('DumpMem')

% load input
function pushbutton_loadset_Callback(hObject, eventdata, handles, fname)
% set dir
currpath=pwd;
% get name
if nargin<4
    if isfield(handles,'fpath')
        cd(handles.fpath)
    end
    [fname,fpath]=uigetfile('*.mat','Load MELT settings & results');
    cd(currpath)
    % "chancel"
    if fname==0
        return
    else
        evalin('base',['load(''',fpath,'\',fname,''');']);
        handles.fpath=fpath;
    end
else
    evalin('base',['load(''.\',fname,''');']);
end

% fill fields
set(handles.edit_namedat,'String',evalin('base','namedat'));
set(handles.edit_cutoff,'String',evalin('base','cutoff'));
set(handles.edit_entsteps,'String',evalin('base','entsteps'));
set(handles.edit_entmin,'String',evalin('base','entmin'));
set(handles.edit_entmax,'String',evalin('base','entmax'));
%set(handles.edit_startdat,'String',num2str(evalin('base','startD')));
set(handles.edit_stopdat,'String',num2str(evalin('base','stopdat')));
set(handles.edit_startbg,'String',num2str(evalin('base','startbg')));
set(handles.edit_stopbg,'String',num2str(evalin('base','stopbg')));
set(handles.edit_bg,'String',num2str(evalin('base','bg')));
% set(handles.edit_t0shift,'String',num2str(evalin('base','t0shift')));
set(handles.edit_psperchannel,'String',num2str(evalin('base','psperchannel')));
set(handles.edit_fwhm,'String',num2str(evalin('base','fwhm')'));
set(handles.edit_fwhmint,'String',num2str(evalin('base','fwhmint')'));
set(handles.edit_fwhmzero,'String',num2str(evalin('base','fwhmzero')'));
if (evalin('base','exist(''srctau'')')==1)&&(evalin('base','exist(''srcint'')')==1)
    set(handles.edit_srctau,'String',num2str(evalin('base','srctau')'));
    set(handles.edit_srcint,'String',num2str(evalin('base','srcint')'));
else
    set(handles.edit_srctau,'String','');
    set(handles.edit_srcint,'String','');
end
show_entsteps(hObject, guidata(hObject));
guidata(hObject, handles);
pushbutton_loadnamedat_Callback(hObject, eventdata, guidata(hObject))

% save input
function pushbutton_saveset_Callback(hObject, eventdata, handles)
[filename,pathname]=uiputfile('*.mat','Save MELT settings & results','m_input.mat');
if isequal(filename,0)
    return
else
    savecmd=['save ''',pathname,filename,'''',...
    ' namedat t0shift psperchannel fwhm fwhmint fwhmzero fwhmzero bg startbg stopbg left_of_max stopdat',... % data
    ' Ntau taumin taumax cutoff entsteps entmin entmax enditer itermaxdev lastiter maxchi b verbose',...     % analysis parameters
    ' tau FCs MODss as ng1s ng2s nits pfas pas pfs chi2saves convsaves successes taumeans intensitys interrors ents'];% results
    if (evalin('base','exist(''srctau'')')==1)&&(evalin('base','exist(''srcint'')')==1)
        savecmd=[savecmd,' srctau srcint'];
    end
    evalin('base',savecmd);
end


% load data
function pushbutton_loadnamedat_Callback(hObject, eventdata, handles)
if evalin('base','exist(namedat,''file'')')
    evalin('base','m_data');
    % fill fields
    set(handles.edit_startdat,'String',num2str(evalin('base','startD')));
    set(handles.edit_startdat,'TooltipString',['Max data in: ',num2str(evalin('base','indmaxdat'))]);
    set(handles.edit_t0shift,'String',num2str(evalin('base','t0shift+indmaxdat')));
%     set(handles.edit_t0shift,'TooltipString',['t0: ',num2str(evalin('base','t0shift+indmaxdat'))]);
    % plot data
    set(handles.figure_melt,'CurrentAxes',handles.axes_spectrum);
    semilogy(evalin('base','DATFULL'),'.');
    xlim(handles.axes_spectrum,[0 length(evalin('base','DATFULL'))]);
    handles.xlimits=xlim(handles.axes_spectrum);
    handles.ylimits=ylim(handles.axes_spectrum);
    guidata(hObject,handles);
    plot_dat_lines(hObject, guidata(hObject));
    plot_bg_lines(hObject, guidata(hObject));
else
    errordlg('No such file')
end


% find data file
function pushbutton_loaddat_Callback(hObject, eventdata, handles)
% set dir
currpath=pwd;
if isfield(handles,'fpath')
    cd(handles.fpath)
end
% get name
[fname,fpath]=uigetfile('*.dat');
cd(currpath)
% "chancel"
if fname==0
    return
else
    handles.fpath=fpath;
end
%update name of datafile
%if ~strcmp(fpath,[pwd,'\'])
    filename=[fpath,fname];
%else
%    filename=fname;
%end
if ischar(filename)
    evalin('base',['namedat=''',filename,''';']);
    set(handles.edit_namedat,'String',filename);
end
guidata(hObject, handles);


% basic settings
function edit_namedat_Callback(hObject, eventdata, handles)
evalin('base',['namedat=''',get(handles.edit_namedat,'String'),''';'])


function edit_entsteps_Callback(hObject, eventdata, handles)
evalin('base',['entsteps=''',get(handles.edit_entsteps,'String'),''';']);
show_entsteps(hObject, guidata(hObject));


function edit_entmin_Callback(hObject, eventdata, handles)
evalin('base',['entmin=''',get(handles.edit_entmin,'String'),''';']);
show_entsteps(hObject, guidata(hObject));


function edit_entmax_Callback(hObject, eventdata, handles)
evalin('base',['entmax=''',get(handles.edit_entmax,'String'),''';']);
show_entsteps(hObject, guidata(hObject));


function edit_cutoff_Callback(hObject, eventdata, handles)
evalin('base',['cutoff=''',get(handles.edit_cutoff,'String'),''';']);


function edit_psperchannel_Callback(hObject, eventdata, handles)
evalin('base',['psperchannel=',get(handles.edit_psperchannel,'String'),';']);


function edit_t0shift_Callback(hObject, eventdata, handles)
evalin('base',['t0shift=',get(handles.edit_t0shift,'String'),'-indmaxdat;']);
set(handles.edit_t0shift,'TooltipString',['t0: ',num2str(evalin('base','indmaxdat+t0shift'))]);


% data limits
function edit_startdat_Callback(hObject, eventdata, handles)
evalin('base',['left_of_max=',num2str(evalin('base','indmaxdat')-str2num(get(handles.edit_startdat,'String'))),';']);
evalin('base','startD=indmaxdat-left_of_max;');
guidata(hObject, handles);
delplot_dat_lines(hObject, guidata(hObject));


function edit_stopdat_Callback(hObject, eventdata, handles)
evalin('base',['stopdat=',get(handles.edit_stopdat,'String'),';']);
guidata(hObject, handles);
delplot_dat_lines(hObject, guidata(hObject));


% background
function pushbutton_bgestim_Callback(hObject, eventdata, handles)
evalin('base','bg=mean(DATFULL(startbg:stopbg));');
set(handles.edit_bg,'String',num2str(evalin('base','bg'),'%4.3f'));
set(handles.edit_stopdat,'TooltipString',['Estimated minimum: ',num2str(evalin('base','length(Ds)+startD'))])
delplot_bg_lines(hObject, guidata(hObject));


function edit_bg_Callback(hObject, eventdata, handles)
evalin('base',['bg=',get(handles.edit_bg,'String'),';']);
delplot_bg_lines(hObject, guidata(hObject));


function edit_startbg_Callback(hObject, eventdata, handles)
evalin('base',['startbg=',get(handles.edit_startbg,'String'),';']);
set(handles.edit_stopdat,'TooltipString',['Estimated minimum: ',num2str(evalin('base','length(Ds)+startD'))])
delplot_bg_lines(hObject, guidata(hObject));


function edit_stopbg_Callback(hObject, eventdata, handles)
evalin('base',['stopbg=',get(handles.edit_stopbg,'String'),';']);
set(handles.edit_stopdat,'TooltipString',['Estimated minimum: ',num2str(evalin('base','length(Ds)+startD'))])
guidata(hObject, handles);
delplot_bg_lines(hObject, guidata(hObject));


% FWHM
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


% plot routines
function pushbutton_zoom_Callback(hObject, eventdata, handles)
zoom;


function pushbutton_zoomfull_Callback(hObject, eventdata, handles)
zoom out;


function pushbutton_pan_Callback(hObject, eventdata, handles)
pan;

% source correction
function edit_srcint_Callback(hObject, eventdata, handles)
srcints=get(handles.edit_srcint,'String');
evalin('base','clear srcint');
if ~isempty(srcints)
    for i=1:length(srcints(:,1))
        evalin('base',['srcint(',num2str(i),')=',(srcints(i,:)),';']);
    end
end

function edit_srctau_Callback(hObject, eventdata, handles)
srctaus=get(handles.edit_srctau,'String');
evalin('base','clear srctau');
if ~isempty(srctaus)
    for i=1:length(srctaus(:,1))
        evalin('base',['srctau(',num2str(i),')=',(srctaus(i,:)),';']);
    end
end

% tau grid
function pushbutton_taugrid_Callback(hObject, eventdata, handles)
uiwait(m_gui_taugrid);
set(handles.edit_t0shift,'String',num2str(evalin('base','t0shift+indmaxdat')));
set(handles.edit_fwhm,'String',num2str(evalin('base','fwhm')'));
set(handles.edit_fwhmint,'String',num2str(evalin('base','fwhmint')'));
set(handles.edit_fwhmzero,'String',num2str(evalin('base','fwhmzero')'));

% advanced settings
function pushbutton_advanced_Callback(hObject, eventdata, handles)
m_gui_advanced;


function pushbutton_startmelt_Callback(hObject, eventdata, handles)
set(handles.figure_melt,'Visible','off');
timetaken=cputime;
if evalin('base','verbose')
    fprintf('\n*** invoking MELT session *** \n')
    fprintf('*MELT info* (re)loading data and calculating tau matrix... \n')
end
    figure_extinfo=m_gui_extinfo(0,['MELT initialized',char(10),'Loading data'],'replace');
    drawnow;
evalin('base','m_data');
    figure_extinfo=m_gui_extinfo(0,'Constructing tau matrix','add');
    drawnow;
evalin('base','m_tcmat');
evalin('base','m_mat');
    figure_extinfo=m_gui_extinfo(0,'Applying source correction','add');
    drawnow;
evalin('base','m_scorr');
if evalin('base','verbose')
    fprintf('*MELT info* pre-filtering and iterating... \n')
end
    figure_extinfo=m_gui_extinfo(0,'Pre-filtering and iterating...','add');
    drawnow;
evalin('base','m_iter');
% call you
if evalin('base','verbose')
    fprintf('*MELT info* deconvolution took %0.1f seconds of cpu time \n',cputime-timetaken)
    fprintf('*** finishing MELT session ***\n\n')
end;
try
    sound(sin(1:5000),5000) % sound signal
end
    figure_extinfo=m_gui_extinfo(0,'MELT finished job. Press ''Close'' to display results','add');
    waitfor(figure_extinfo,'BeingDeleted')
set(handles.figure_melt,'Visible','on');
m_gui_plotres;


function pushbutton_showres_Callback(hObject, eventdata, handles)
evalin('base','m_gui_plotres');

%default dir
function loaddir(hObject, eventdata, handles)
handles.lastdirfile = [fileparts(mfilename('fullpath')),'\lastdir.mat'];
if exist(handles.lastdirfile, 'file') ~= 0
    load('-mat', handles.lastdirfile)
    if (exist('lastdir', 'var') == 1) && (exist(lastdir, 'dir') == 7)
        handles.fpath = lastdir;
    end
end

guidata(hObject, handles);

function savedir(hObject, eventdata, handles)
if (exist('handles', 'var') == 1)
    if (isfield(handles,'fpath'))
        if ~isequal(handles.fpath,0)
            try
                lastdir = handles.fpath;
                save(handles.lastdirfile, 'lastdir');
            catch
                disp(['WARNING: Cannot write ''', handles.lastdirfile, '''']);
            end
        end
    end
end

