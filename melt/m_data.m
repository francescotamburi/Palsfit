% m_data.m
% loads and edits data. calculates and subtracts background (bg).
% if the datafile is ascii, it should be called variable_name.dat so
% that the data can be identified in m_input by namedat='variable_name'. 
% an ascii datafile may contain any number of lines and columns with
% data reading from top to bottom and from left to right.
% the columns must be aligned at left and separated by spaces.
% 
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch
 
 
DATFULL=round(eval(['load(''',namedat,''');']));		        % load datafile
DATFULL=DATFULL(:);
if ~exist('bg')
    bg=mean(DATFULL(startbg:stopbg));
end
bgstd=std(DATFULL(startbg:stopbg));     % calculate standard deviation on bg level
[maxdat,indmaxdat]=max(DATFULL);
 
% Define D, the data vector to be analysed
startD=indmaxdat-left_of_max;		    % first bin of data. start left_of_max bins before maximum.
stopD=stopdat;
D=round(DATFULL(startD:stopD));
%D=round((D-bg)+abs(D-bg))/2;		    % fix negative values to 0
volD=sum(D-bg);
ND=length(D);
 
 
% Define Ds, the range within D used by m_iter for calculating MOD. neglects
% the parts which are essentially background
for zeroindex=26:max(size(D))
    if abs(mean(D(zeroindex-25:zeroindex))-bg) < bgstd
        break
    end
end
if zeroindex<ND-16
    zeroindex=zeroindex+15;
end
Ds=D(1:zeroindex);
volDs=sum(Ds-bg);
NDs=length(Ds);
 
%*********************************************************************
