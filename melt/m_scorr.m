% m_scorr.m
% subtracts the given source components from the data before analysis.
% fabricates the source components using the same formulae as for the 
% exponentials in the analysis matrix TC, and uses in particular the values
% for t0shift and fwhm defined earlier. no restrictions on the number of source
% components but this is always a risky operation in that an uncertainty
% about the source component will propagate through to the final result.
% if you know them, subtract them, if you don't, don't.
%
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch

if exist('srctau')==1&&exist('srcint')==1
    ndat=ND+10;			% number of channels at psperchannel ps/channel
    firstchannel=2*left_of_max+1;
    gridtime=psperchannel*[-firstchannel:ndat];
    gridlambdas=1./srctau;

    lambdast=gridtime'*gridlambdas;
    lambdas=ones(ndat+firstchannel+1,1)*gridlambdas;
    t=gridtime'*ones(1,max(size(srctau)));
    TCs=zeros(ndat+firstchannel,max(size(srctau)));
    
    for i=1:length(fwhm)
        sigma(i)=fwhm(i)/(2*sqrt(log(2)));
        tdivlambdas=(erf((t-psperchannel*(t0shift+fwhmzero(i)))/sigma(i)))./(2*lambdas);
        Ydivlambdas=(exp(-lambdast + (psperchannel*(t0shift+fwhmzero(i))*lambdas) + (sigma(i)^2/4*lambdas.^2))...
                    .*erfc(sigma(i)/2*lambdas-(t-psperchannel*(t0shift+fwhmzero(i)))/sigma(i)))./(2*lambdas);

        TCsngls=Ydivlambdas(1:ndat+firstchannel,:)-Ydivlambdas(2:ndat+firstchannel+1,:)...
               -tdivlambdas(1:ndat+firstchannel,:)+tdivlambdas(2:ndat+firstchannel+1,:);

        TCs=TCs+fwhmint(i).*TCsngls;
    end
    for i=1:min(size(TCs))
%        TCs(:,i)=TCs(:,i)/sum(TCs(:,i))*srcint(i)/100*volD;
         srcout=exp(-(stopdat-indmaxdat-t0shift)*psperchannel/srctau(i));
         srcin=srcint(i)/100*(1-srcout)/(1-srcint(i)/100*srcout);
         fprintf('%4.4f\n',srcin)
         TCs(:,i)=TCs(:,i)/sum(TCs(:,i))*volD*srcin;
    end
    TCs=round(TCs(startana:stopana,:));
    sourcecorr=zeros(max(size(TCs)),1);
    for i=1:min(size(TCs))
        sourcecorr=sourcecorr+TCs(:,i);
    end
    D=D-sourcecorr;
    %D=round((D-bg)+abs(D-bg))/2;		% fix negative values to 0

    clear TCsngls Ydivlambdas tdivlambdas sigma lambdas lambdast t gridtime gridlambdas 
end
 
%*********************************************************************
