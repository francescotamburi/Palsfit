function varargout = m_gui_plotres(varargin)
% M_GUI_PLOTRES M-file for m_gui_plotres.fig
%      M_GUI_PLOTRES, by itself, creates a new M_GUI_PLOTRES or raises the existing
%      singleton*.
%
%      H = M_GUI_PLOTRES returns the handle to a new M_GUI_PLOTRES or the handle to
%      the existing singleton*.
%
%      M_GUI_PLOTRES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M_GUI_PLOTRES.M with the given input arguments.
%
%      M_GUI_PLOTRES('Property','Value',...) creates a new M_GUI_PLOTRES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m_gui_plotres_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m_gui_plotres_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help m_gui_plotres2

% Last Modified by GUIDE v2.5 04-Feb-2006 23:52:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m_gui_plotres2_OpeningFcn, ...
                   'gui_OutputFcn',  @m_gui_plotres2_OutputFcn, ...
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


% --- Executes just before m_gui_plotres is made visible.
function m_gui_plotres2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m_gui_plotres2 (see VARARGIN)

% Choose default command line output for m_gui_plotres2
handles.output = hObject;

% define initial values
handles.Zscale='linear';
handles.dim='3D';
% data for picture
handles.VAR='FCs';
handles.plottype3D='waterfall';
handles.axesformat='FCs_axis';
set(handles.text_curplot,'String','Intensity');
handles.VARmaxlvl=evalin('base',['max(max(',handles.VAR,'));']);
handles.VARminlvl=evalin('base',['min(min(',handles.VAR,'));']);
% Update handles structure
guidata(hObject, handles);
% plot picture
set_sliders(hObject, handles)
entsteps=evalin('base','length(as)');
if entsteps==1
    set(handles.slider_ent,'Visible','off');
    set(handles.pushbutton_chi2s_ent,'Visible','off');
    set(handles.pushbutton_pas_ent,'Visible','off');
else
    set(handles.slider_ent,'Visible','on');
    set(handles.pushbutton_chi2s_ent,'Visible','on');
    set(handles.pushbutton_pas_ent,'Visible','on');
    set(handles.slider_ent,'Max',entsteps);
    set(handles.slider_ent,'SliderStep',[1/(entsteps-1),1/(entsteps-1)]);
end
evalin('base','entno=1;');
evalin('base','[pasmax,best]=max(pas);');
pushbutton_Z_Callback(hObject, eventdata, handles)
print_results(hObject, handles)

% UIWAIT makes m_gui_plotres2 wait for user response (see UIRESUME)
% uiwait(handles.figure_res);


% --- Outputs from this function are returned to the command line.
function varargout = m_gui_plotres2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function set_sliders(hObject, handles)
handles.VARmaxlvl=evalin('base',['max(max(',handles.VAR,'(isfinite(',handles.VAR,'))));']);
handles.VARminlvl=evalin('base',['min(min(',handles.VAR,'(isfinite(',handles.VAR,'))));']);
if ~(handles.VARminlvl<handles.VARmaxlvl)
    handles.VARminlvl=0;
    handles.VARmaxlvl=1;
end
if strcmp(handles.Zscale,'linear')
    prefix='';
elseif strcmp(handles.Zscale,'log')
    prefix='log10';
    if handles.VARminlvl<=0
        handles.VARminlvl=handles.VARmaxlvl*1e-12;
    end
end
set(handles.slider_Zmax,'Min',eval([prefix,'(',num2str(handles.VARminlvl),')']));
set(handles.slider_Zmax,'Max',eval([prefix,'(',num2str(handles.VARmaxlvl),')']));
set(handles.slider_Zmin,'Min',eval([prefix,'(',num2str(handles.VARminlvl),')']));
set(handles.slider_Zmin,'Max',eval([prefix,'(',num2str(handles.VARmaxlvl),')']));
set(handles.slider_Zmax,'Value',eval([prefix,'(',num2str(handles.VARmaxlvl),')']));
set(handles.slider_Zmin,'Value',eval([prefix,'(',num2str(handles.VARminlvl),')']));
set(handles.text_max,'String',['Zmax = ',num2str(handles.VARmaxlvl,'%4.1g')]);
set(handles.text_min,'String',['Zmin = ',num2str(handles.VARminlvl,'%4.1g')]);
guidata(hObject, handles);


function print_results(hObject, handles)
if evalin('base','successes(entno)==0')
    set(handles.edit_res,'ForegroundColor',[.5,0,0]);
    set(handles.edit_res,'String','analysis failed!');
    return
elseif evalin('base','successes(entno)==1')
    set(handles.edit_res,'ForegroundColor',[0,0,0]);
elseif evalin('base','successes(entno)==2')
    set(handles.edit_res,'ForegroundColor',[.3,.3,.3]);
end
text=[evalin('base','sprintf(''ng1\t ng2\t no.of iter.\n'');')];
text=[text,evalin('base','sprintf(''%5.3f\t %5.3f\t %d\n\n'',ng1s(entno),ng2s(entno),nits(entno));')];
text=[text,evalin('base','sprintf(''sum(data)\t sum(data-model)\t\n'');')];
text=[text,evalin('base','sprintf(''%d\t %d\n\n'',sum(D),sum(D)-sum(MODss(entno,:)));')];
text=[text,evalin('base','sprintf(''post. prob. a\t post. prob. f\t post. prob. fa\n'');')];
text=[text,evalin('base','sprintf(''%5.3e\t %5.3e\t %5.3e\t\n\n'',pas(entno),pfs(entno),pfas(entno));')];
text=[text,evalin('base','sprintf(''conv\t ent-chi2\t ent\n'');')];
text=[text,evalin('base','sprintf(''%5.3e\t %5.3e\t %5.3e\t\n'',convsaves(entno,nits(entno)),as(entno)*ents(entno)-chi2saves(entno,nits(entno))/2,ents(entno));')];
text=[text,evalin('base','sprintf(''\n lifetime(ps)\t intensity\t int. error\n'');')];
text=[text,evalin('base','sprintf(''%9.1f\t %6.1f\t %6.1f\n'',[taumeans{entno};intensitys{entno}*100;interrors{entno}*100]);')];
text=[text,evalin('base','sprintf(''\n entweight: %6.1e\t chi2: %5.4f'',as(entno),chi2saves(entno,nits(entno)));')];
if evalin('base','sum(FCs(entno,:))>0')&&evalin('base','FCs(entno,1)/max(FCs(entno,:))>0.001;');		% warning for unoptimal t0
    text=[text,evalin('base','sprintf(''\n\nThere is very short lifetime component \n'')'),...
    evalin('base','sprintf(''Hint: try to reduce t0-tmax'')')];
    evalin('base','successes(entno)=2;')
end
set(handles.edit_res,'String',text);
set(handles.edit_res,'ListboxTop',1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SLIDERS
function slider_Zmax_Callback(hObject, eventdata, handles)
if strcmp(handles.Zscale,'linear')
    prefix='';
elseif strcmp(handles.Zscale,'log')
    prefix='10^';
end
slidmax=get(handles.slider_Zmax,'Value');
slidmin=get(handles.slider_Zmin,'Value');
if slidmax<slidmin
    slidmax=slidmin;
end
handles.VARmaxlvl=eval([prefix,'(',num2str(slidmax),')']);
set(handles.text_max,'String',['Zmax = ',num2str(handles.VARmaxlvl,'%4.2g')]);
guidata(hObject, handles);


function slider_Zmin_Callback(hObject, eventdata, handles)
if strcmp(handles.Zscale,'linear')
    prefix='';
elseif strcmp(handles.Zscale,'log')
    prefix='10^';
end
slidmax=get(handles.slider_Zmax,'Value');
slidmin=get(handles.slider_Zmin,'Value');
if slidmax<slidmin
    slidmin=slidmax;
end
handles.VARminlvl=eval([prefix,'(',num2str(slidmin),')']);
set(handles.text_min,'String',['Zmin = ',num2str(handles.VARminlvl,'%4.2g')]);
guidata(hObject, handles);


function slider_ent_Callback(hObject, eventdata, handles)
evalin('base',['entno=',num2str(round(get(handles.slider_ent,'Value'))),';']);
print_results(hObject, handles)
m_gui_plotres('pushbutton_Z_Callback',gcbo,[],guidata(gcbo))


% BUTTONS
function pushbutton_Z_Callback(hObject, eventdata, handles)

plottype=handles.plottype3D;
if evalin('base','length(as)')==1 
    handles.dim='2D';
end

VAR=evalin('base',handles.VAR);
if strcmp(handles.dim,'3D')
    
%figure_info=m_gui_info(['Plotting data',char(10),'Please Wait...']);
drawnow;

if (handles.VARmaxlvl<max(max(VAR)))||(handles.VARminlvl>min(min(VAR)))
    handles.VARcut=zeros(size(VAR));
    for i=1:length(VAR(:,1))
        for j=1:length(VAR(1,:))
            if VAR(i,j)<handles.VARminlvl
                handles.VARcut(i,j)=handles.VARminlvl;
            elseif VAR(i,j)>handles.VARmaxlvl
                handles.VARcut(i,j)=handles.VARmaxlvl;
            else
                handles.VARcut(i,j)=VAR(i,j);
            end
        end
    end
else
    handles.VARcut=VAR;
end
%delete(figure_info);   
    
elseif strcmp(handles.dim,'2D')
    
%figure_info=m_gui_info(['Plotting data',char(10),'Please Wait...']);
drawnow;
if isvector(VAR)
    i=1;
else
    i=evalin('base','entno');
end
if (handles.VARmaxlvl<max(max(VAR)))||(handles.VARminlvl>min(min(VAR)))
    handles.VARcut=zeros(size(VAR));
    for j=1:length(VAR(i,:))
        if VAR(i,j)<handles.VARminlvl
            handles.VARcut(i,j)=handles.VARminlvl;
        elseif VAR(i,j)>handles.VARmaxlvl
            handles.VARcut(i,j)=handles.VARmaxlvl;
        else
            handles.VARcut(i,j)=VAR(i,j);
        end
    end
else
    handles.VARcut=VAR(i,:);
end
%delete(figure_info);   
    
end

set(0,'CurrentFigure',handles.figure_res);
set(handles.figure_res,'CurrentAxes',handles.axes_res);
handles.VARplot=eval([plottype,'(handles.VARcut);']);
axis tight
set(handles.axes_res,'ZScale',handles.Zscale)
guidata(hObject, handles);
eval([handles.axesformat,'(hObject, eventdata, guidata(hObject))']);


function radiobutton_lin_Callback(hObject, eventdata, handles)
handles.Zscale='linear';
guidata(hObject, handles);
set_sliders(hObject, handles)


function radiobutton_log_Callback(hObject, eventdata, handles)
handles.Zscale='log';
guidata(hObject, handles);
set_sliders(hObject, handles)


function radiobutton_2D_Callback(hObject, eventdata, handles)
handles.dim='2D';
guidata(hObject, handles);

function radiobutton_3D_Callback(hObject, eventdata, handles)
handles.dim='3D';
guidata(hObject, handles);


%%%% PLOTS %%%%

function pushbutton_FCs_Callback(hObject, eventdata, handles)
handles.VAR='FCs';
handles.plottype3D='waterfall';
handles.axesformat='FCs_axis';
set(handles.text_curplot,'String','Intensity');
guidata(hObject, handles);
set_sliders(hObject, handles)
pushbutton_Z_Callback(hObject, eventdata, guidata(hObject));

function FCs_axis(hObject, eventdata, handles)
% set view
if strcmp(handles.dim,'3D')
    view(5,30)
    yticks=get(handles.axes_res,'YTick');
    set(handles.axes_res,'YTick',yticks);
    set(handles.axes_res,'YTickLabel',evalin('base',['num2str(as([',num2str(round(yticks)),'])'',''%4.1e'')']));
    ylabel('Entropy');
else
   view(0,0) 
end
% additional lines
if strcmp(handles.dim,'2D')
    if evalin('base','entno==best')
            handles.best=line(1:evalin('base','Ntau'),ones(1,evalin('base','Ntau')),handles.VARcut);
            set(handles.best,'Color',[0,0,1]);
    elseif evalin('base','successes(entno)==0')
        handles.best=line(1:evalin('base','Ntau'),ones(1,evalin('base','Ntau')),handles.VARcut);
        set(handles.best,'Color',[.5,0,0]);
    elseif evalin('base','successes(entno)==2')
        handles.best=line(1:evalin('base','Ntau'),ones(1,evalin('base','Ntau')),handles.VARcut);
        set(handles.best,'Color',[.3,.3,.3]);
    end
elseif strcmp(handles.dim,'3D')
    handles.best=line(1:evalin('base','Ntau'),ones(1,evalin('base','Ntau'))*evalin('base','best'),handles.VARcut(evalin('base','best'),:));
    set(handles.best,'Color',[0,0,1]);
    for i=1:evalin('base','length(successes);')
       if evalin('base',['successes(',num2str(i),')==0'])
           handles.best=line(1:evalin('base','Ntau'),ones(1,evalin('base','Ntau'))*i,handles.VARcut(i,:));
           set(handles.best,'Color',[.5,0,0]);
       elseif evalin('base',['successes(',num2str(i),')==2'])
           handles.best=line(1:evalin('base','Ntau'),ones(1,evalin('base','Ntau'))*i,handles.VARcut(i,:));
           set(handles.best,'Color',[.3,.3,.3]);
       end
    end
end
% colors
set(handles.VARplot,'FaceColor',[.8,.8,.9])
set(handles.VARplot,'EdgeColor',[.0,.0,0])
% ticks & labels
xticks=abs(round(get(handles.axes_res,'XTick')));
if all(xticks)
    set(handles.axes_res,'XTick',xticks);
    set(handles.axes_res,'XTickLabel',round(evalin('base',['tau([',num2str(xticks),'])'])*10)/10);
end
xlabel('tau (ps)');
guidata(hObject, handles);


function pushbutton_resids_Callback(hObject, eventdata, handles)
for MODi=1:evalin('base','length(as)')
    evalin('base',['residualss(',num2str(MODi),',:)=((D-MODss(',num2str(MODi),',:)'').*abs(D-MODss(',num2str(MODi),',:)''))./MODss(',num2str(MODi),',:)'';']);
end
handles.VAR='residualss';
handles.plottype3D='stem3';
handles.axesformat='resids_axis';
set(handles.text_curplot,'String','Residuals');
guidata(hObject, handles);
set_sliders(hObject, handles)
m_gui_plotres('pushbutton_Z_Callback',gcbo,[],guidata(gcbo))

function resids_axis(hObject, eventdata, handles)
if strcmp(handles.dim,'3D')
    view(3,75)
    yticks=get(handles.axes_res,'YTick');
    set(handles.axes_res,'YTick',yticks);
    set(handles.axes_res,'YTickLabel',evalin('base',['num2str(ents([',num2str(round(yticks)),'])'',''%4.1e'')']));
    ylabel('Entropy');
else
   view(0,0) 
end
set(handles.VARplot,'LineStyle','none')
set(handles.VARplot,'Marker','.')
xticks=get(handles.axes_res,'XTick');
set(handles.axes_res,'XTick',xticks);
%xticklabels=1:evalin('base','enditer');
%set(handles.axes_res,'XTickLabel',xticklabels([xticks]));
xlabel('ch');

guidata(hObject, handles);


function pushbutton_chi2s_Callback(hObject, eventdata, handles)
handles.VAR='chi2saves';
handles.plottype3D='waterfall';
handles.axesformat='chi2s_axis';
set(handles.text_curplot,'String','Chi2');
guidata(hObject, handles);
set_sliders(hObject, handles)
m_gui_plotres('pushbutton_Z_Callback',gcbo,[],guidata(gcbo))


function chi2s_axis(hObject, eventdata, handles)
if strcmp(handles.dim,'3D')
    view(-185,30)
    yticks=get(handles.axes_res,'YTick');
    set(handles.axes_res,'YTick',yticks);
    set(handles.axes_res,'YTickLabel',evalin('base',['num2str(as([',num2str(round(yticks)),'])'',''%4.1e'')']));
    ylabel('Entropy');
else
   view(0,0) 
end
set(handles.VARplot,'FaceColor',[.8,.9,.8])
set(handles.VARplot,'EdgeColor',[.0,.3,.0])
xticks=get(handles.axes_res,'XTick');
set(handles.axes_res,'XTick',xticks);
xticklabels=1:evalin('base','enditer');
set(handles.axes_res,'XTickLabel',xticklabels([xticks]));
xlabel('Iter.');
guidata(hObject, handles);


function pushbutton_convs_Callback(hObject, eventdata, handles)
handles.VAR='convsaves';
handles.plottype3D='waterfall';
handles.axesformat='chi2s_axis';
set(handles.text_curplot,'String','Convergence');
guidata(hObject, handles);
set_sliders(hObject, handles)
m_gui_plotres('pushbutton_Z_Callback',gcbo,[],guidata(gcbo))


function pushbutton_chi2s_ent_Callback(hObject, eventdata, handles)
handles.VAR='chi2s';
handles.plottype3D='waterfall';
handles.axesformat='chi2s_ent_axis';
set(handles.text_curplot,'String','Chi2');
guidata(hObject, handles);
set_sliders(hObject, handles)
m_gui_plotres('pushbutton_Z_Callback',gcbo,[],guidata(gcbo))


function chi2s_ent_axis(hObject, eventdata, handles)
view(0,0)
set(handles.VARplot,'Marker','.')
set(handles.VARplot,'MarkerSize',20)
set(handles.VARplot,'FaceColor',[1,.8,.8])
set(handles.VARplot,'EdgeColor',[.3,.0,.0])
xticks=get(handles.axes_res,'XTick');
set(handles.axes_res,'XTick',xticks);
set(handles.axes_res,'XTickLabel',evalin('base',['num2str(as([',num2str(round(xticks)),'])'',''%4.1e'')']));
xlabel('Entropy');
guidata(hObject, handles);


function pushbutton_pas_ent_Callback(hObject, eventdata, handles)
handles.VAR='pas';
handles.plottype3D='waterfall';
handles.axesformat='chi2s_ent_axis';
set(handles.text_curplot,'String','Prob. of a');
guidata(hObject, handles);
set_sliders(hObject, handles)
m_gui_plotres('pushbutton_Z_Callback',gcbo,[],guidata(gcbo))


function pushbutton_extinfo_Callback(hObject, eventdata, handles)
figure_extinfo=m_gui_extinfo(get(handles.edit_res,'String'),'replace');
%listdlg('ListString',get(handles.edit_res,'String'),'SelectionMode','single','ListSize',[250 300])

%%%% SAVE %%%%

function pushbutton_savres_Callback(hObject, eventdata, handles)
[pathstr,name,ext] = fileparts(evalin('base','namedat'));
filename=[pathstr,'\',name,'_',evalin('base','entmin'),'-',evalin('base','entmax'),'_',evalin('base','cutoff'),'_',...
    num2str(evalin('base','fwhm'),'%0.1f_'),num2str(evalin('base','t0shift'),'%0.3f_'),...
    num2str(evalin('base','bg'),'%0.2f'),'.mat'];
[filename,pathname]=uiputfile('*.mat','Save MELT settings & results',filename);
% POPRWKA: dorobic source correction !!!
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


function pushbutton_savascii_Callback(hObject, eventdata, handles)
[pathstr,name,ext] = fileparts(evalin('base','namedat'));
filename=[pathstr,'\',name,'_',evalin('base','entmin'),'-',evalin('base','entmax'),'_',evalin('base','cutoff'),'_',...
    num2str(evalin('base','fwhm'),'%0.1f_'),num2str(evalin('base','t0shift'),'%0.3f_'),...
    num2str(evalin('base','bg'),'%0.2f')];
[filename,pathname]=uiputfile('*.dat','Save MELT settings & results',filename);
if isequal(filename,0)
    return
else
    as=evalin('base','as');
    taumeans=evalin('base','taumeans');
    intensitys=evalin('base','intensitys');
    interrors=evalin('base','interrors');
    % I(tau) histogram
    frmtext='\n%12.8f';
    for i=1:length(as)
       frmtext=[frmtext,'%14.8f'];
    end
    fid=fopen([pathname,filename,'_I(tau).dat'],'w');
    fprintf(fid,'    tau[ns]');
    fprintf(fid,'  H=%0.3e',evalin('base','as'));
    fprintf(fid,frmtext,vertcat(evalin('base','tau/1000'),evalin('base','FCs')));
    fclose(fid);
    % results
    for i=1:length(as)
       lengthtau(i)=length(taumeans{i});
    end
    lengthtaumax=max(lengthtau);
    datatosave=nan(length(as),lengthtaumax*3+1);
    for i=1:length(as)
        datatosave(i,1)=as(i);
        datatosave(i,2:2:length(intensitys{i})*2+1)=intensitys{i}*100;
        datatosave(i,3:2:length(interrors{i})*2+1)=interrors{i}*100;
        datatosave(i,2+2*lengthtaumax:length(taumeans{i})+2*lengthtaumax+1)=taumeans{i}/1000;
    end
    frmtext='\n%10.3e';
    intinfotext='         H';
    tauinfotext='';
    for i=1:lengthtaumax
        intinfotext=[intinfotext,'     I',num2str(i),'[%%]    dI',num2str(i),'[%%]'];
        tauinfotext=[tauinfotext,'  tau',num2str(i),'[ns]'];
        frmtext=[frmtext,'%10.4f%10.4f%10.4f'];
    end
    fid = fopen([pathname,filename,'_result.dat'],'w');
    fprintf(fid,[intinfotext,tauinfotext]);
    fprintf(fid,frmtext,datatosave');
    fclose(fid);
end
