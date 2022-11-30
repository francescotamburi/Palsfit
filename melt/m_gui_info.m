function [hndl,hndlstr]=m_gui_info(textstr)
hndl=dialog('Position',[480,370,150,70]);
hndlstr=uicontrol('Style','text','String',textstr,'Position',[10,10,130,50],'Parent',hndl);


