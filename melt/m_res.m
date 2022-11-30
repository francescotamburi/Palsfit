% m_res.m: prepare results to be visualised on line or to be saved using m_save
%
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch
 

L=diag(Yi*M*Yi');                                   % store eigenvalues
ent=sum(F-INIMAP-F.*log((F./INIMAP)+1e-50));		% entropy(avoid log(0)!)
ng1=-2*a*ent;                                       % shannon number
ng2=sum(L./(a+L));
q=a*ent-chi2/2;                                     % entropy - chi square
pf=prod((a+L).^0.5);                            	% posterior probability of f
aL=a./(a+L);
aL=aL.^(0.5);
pa=(exp(q)/a)*prod(aL);                         	% posterior probability of a
pfa=pa*pf;                                          % pointwise joint posterior probability of f and a
 
% calculate errors on the intensities
if rank(Yi)>s-1,
    Y=inv(Yi);
    COVa=(1/a)*diag(F,0);
    COVb=diag(F,0)*U*Y*diag(L./(a*(a+L)),0)*Y'*U'*diag(F,0);
    COVARIANCE=COVa-COVb;				% covariance matrix
else
    fprintf('*MELT warning* could not calculate errors :(\n')
end
% calculate the number of components in the spectrum, delimit the range 
% for determining lifetime center of gravity and intensity.
% make top hat masks to single out each component according to the
% determined range and calculate the standard deviation(error bar) on the
% intensity of each component
 
compnumber=0;
df=diff(F);
df=[df(1);diff(F)];
comparezero=zeros(Ntau,1);
logic=df>comparezero;
dlogic=[diff(logic);0];
lim(1)=5;                               % fix limit on left
for y=1:Ntau,
    if dlogic(y)==-1,
        compnumber=compnumber+1;		% number of components= number of maxima
        compmax(compnumber)=y;
    elseif dlogic(y)==1 & compnumber>0,
        lim(2*compnumber)=y;
        lim(2*compnumber+1)=y+1;
    end
end
if length(lim)>(2*compnumber),
    lim=lim(1:2*compnumber);
elseif length(lim)<2*compnumber,
    lim(2*compnumber)=Ntau-5;           % fix limit on right
end

clear standevf
% make top hat masks and calculate standard deviations
endj=length(lim)-1;
if (rank(Yi)>s-1)&(endj>0)
    indstandev=0;
    for j=1:2:endj,
        indstandev=indstandev+1;
        mask=zeros(1,Ntau);
        range=lim(j+1)-lim(j)+1;
        mask(lim(j):lim(j+1))=ones(1,range);
        standevf(indstandev)=(mask*COVARIANCE*mask')^.5/sum(F);
    end
else
    standevf=ones(round(endj/2))*NaN;
end

clear COVARIANCE COVa COVb comparezero df dlogic logic mask aL endj
%*********************************************************************
