function m_gui_iter(errormsg)
% m_gui_iter.m
% Any commands done after succesfull finishing cycle of iterations
% should be placed here.

if isnan(errormsg)
    m_gui_extinfo(0,evalin('base','[''    No '',num2str(entit),''/'',num2str(entsteps),''    ent = '',num2str(a,''%4.1e''),''    chi2 = '',num2str(chi2)]'),'add');
    m_gui_extinfo(0,'OK!','add');
    drawnow;
else
    m_gui_extinfo(0,evalin('base','[''    No '',num2str(entit),''/'',num2str(entsteps),''    ent = '',num2str(a,''%4.1e''),''    chi2 = '',num2str(chi2)]'),'add');
    m_gui_extinfo(0,errormsg,'add');
    drawnow;
end