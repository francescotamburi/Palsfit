% m_tcmat.m
% makes the exponential matrix TC using the analytical expression for
% the convolution between the exponential and the resolution curve
% (see for example: kirkegaard and eldrup, comp. phys. comm. 3 (1972) 240-255.)
% reads input parameters from the file m_input. if you wish to save a
% particular analysis matrix (if you use the same one constantly for example
% while analysing simulated data), you must uncomment the line corresponding
% to the name of the saved matrix in m_input. if this line is uncommented
% while running melt, the analysis matrix will be loaded and used in the
% analysis instead of a new one being calculated.
% the program asks for an input (t0shift, the temporal origin) interactively
% this can be obtained by running the program m_t0.
% for t0shift=0.5 the resolution function is centered in the middle of a 
% channel, for t0shift =0 on the left edge, and for t0shift=1 on the right edge
% so t0shift=0 and t0shift=1 are equivalent.
% 
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch

ndat=ND+10;			% number of channels at psperchannel ps/channel
firstchannel=2*left_of_max+1;
tau=m_tgrid(Ntau,taumin,taumax);
gridtime=psperchannel*[-firstchannel:ndat];
gridlambda=1./tau;
 
lambdat=gridtime'*gridlambda;
lambda=ones(ndat+firstchannel+1,1)*gridlambda;
t=gridtime'*ones(1,Ntau);
TC=zeros(ndat+firstchannel,Ntau);

for i=1:length(fwhm)
    sigma(i)=fwhm(i)/(2*sqrt(log(2)));
    tdivlambda=(erf((t-psperchannel*(t0shift+fwhmzero(i)))/sigma(i)))./(2*lambda);
    Ydivlambda=(exp(-lambdat + (psperchannel*(t0shift+fwhmzero(i))*lambda) + (sigma(i)^2/4*lambda.^2))...
                .*erfc(sigma(i)/2*lambda-(t-psperchannel*(t0shift+fwhmzero(i)))/sigma(i)))./(2*lambda);
    
    TCsngl=Ydivlambda(1:ndat+firstchannel,:)-Ydivlambda(2:ndat+firstchannel+1,:)...
           -tdivlambda(1:ndat+firstchannel,:)+tdivlambda(2:ndat+firstchannel+1,:);
    
    TC=TC+fwhmint(i).*TCsngl;
end

clear TCsngl Ydivlambda tdivlambda sigma lambda lambdat t gridtime gridlambda
%*********************************************************************
