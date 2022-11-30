% m_ltint.m 
% calculates and prints out centre of gravities of peaks (lifetime in ps),
% intensities ( % ) and corresponding errors ( +-% ) for a lifetime spectrum
% analysed by melt. used by m_plot, can be used independently too.
%
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch
 
clear taumean intensity interror
i=0;
%tau=m_tgrid(Ntau,taumin,taumax)';
if length(lim)<1
    taumean=NaN;
    intensity=NaN;
    interror=NaN;
else
    for j=1:2:(length(lim)-1)
        i=i+1;
        intensity(i)=sum(FC(lim(j):lim(j+1)));
        if intensity(i)==0
           intensity(i)=NaN; 
        end
        taumean(i)=sum(FC(lim(j):lim(j+1)).*tau(lim(j):lim(j+1))')/intensity(i);
        if rank(Yi)>s-1
            if abs(imag(standevf(i)))==0
                interror(i)=standevf(i);
            else
                interror(i)=NaN;
            end
        else
            interror(i)=NaN;
        end
    end
end
%clear lim standevf FC Yi s
 
%*********************************************************************

