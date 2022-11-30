% m_iter.m
% see: shukla, peter and hoffmann NIM A 335 (1993) 310.
% iteration procedure for the maximisation of Q,the difference between the 
% entropy and likelihood functions using the quantified maximum entropy 
% principle. (see Bryan in Maximum Entropy and Bayesian Methods, Kluwer,
% Dordrecht, 1990, p221) 
% calculates the lifetime intensity vector F and the model
% reconstruction MOD. a pre-filtering stage applies a linear filter
% (see hoffmann, shukla, peter, barbiellinni and manuel NIM A 335 (1993) 276.)
% to the data, filters noise and provides an a-priori solution for F.
% this pre-filtering stage stabilizes the iteration in the maxent algorithm
% which is sometimes unstable due to the non-linearity introduced by the
% exponential term.
% the iteration loop is automatically exited on convergence.
%
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch
 
% the input parameters of the fitting procedure
tolsing=eval(cutoff);			% singular value cutoff
 
% apply inverse linear filter on data. m_iter then uses the filtered data
% Df and the intensity vector f for further calculations. this increases
% both stability and precision.

P=eye(Ntau)/Ntau;
Cn=diag(D);
%Cn=single(diag(D));
Ci=sum(D-bg)^2*eye(Ntau);
Cs=TCC*Ci*P*TCC';
%Cs=single(TCC*Ci*P*TCC');
Csn=Cs+Cn;
clear Cs Cn
%Csn=double(Csn);
%pack
f=Ci*P*TCC'/Csn*(D-bg); %f=Ci*P*TCC'*inv(Csn)*(D-bg);
Df=TCC*f;
Df=round(Df+bg);
Ds=Df(1:NDs);
clear Csn Ci P
%%%%%%
 
f=(f+abs(f))/2;				% fix negative values to 0 and create
maxf=max(f);				% a better a priori F than the flat 
for sortfi=1:Ntau			% prior with the help of the linear 
    if f(sortfi)<maxf/5;	% filter
        f(sortfi)=maxf/5;
    end
end
F=f/sum(f);				% normalized kick-off solution.
Finit=F;

% singular value decomposition of TCC.
% delimit the singular space of the problem (s), calculate matrices which remain
% constant during the iteration. f index signifies the full matrix, without this
% index the matrix with only the first s columns is considered.
[Vf,Sf,Uf]=svd(TCC);
s=rank(TCC,tolsing);
U=Uf(:,1:s);
S=Sf(1:s,1:s);
Vb=Vf(:,1:s);
V=Vf(1:NDs,1:s);

%clear TC
clear TCC Uf Sf Vf griddat gridres i ii iii iiii j k;
%%%%%

% prepare for entropy iteration
entit=0;
clear chi2saves convsaves FCs chi2s convs
clear successes Fs FCs as chi2s nits ents ng1s ng2s pas pfs pfas 
clear MODss chi2saves convsaves lims standevfs Yis

if strcmp(entsteps,'1')
    alogs=log10(eval(entmin))
else
    alogs=log10(eval(entmin)):eval(['(log10(',entmax,')-log10(',entmin,'))/(',entsteps,'-1)']):log10(eval(entmax));
end

for alog=alogs

%%%%%%%%%%%%%%%%%%%%%%%%%%%% ENTROPY ITERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=10^alog;
entit=entit+1;    
F=Finit;
chi2save=zeros(1,enditer);
convsave=zeros(1,enditer);
%xxsave
%fsave
nit=0;					% initialize iteration count
chi2=0;
success=0;

INIMAP=F;				% reference for calculation of entropy
DDL=diag((Ds).\ones(NDs,1));		% 2nd derivative of likelihood function
 
M=S*V'*DDL*V*S;				% M constant as MOD=TC*F is linear
NEWUU=ones(Ntau,1);			% initialisation

if verbose
    fprintf(['*MELT info* No ',num2str(entit),'/',num2str(entsteps),' ent = ',num2str(a),'\nIter.\t chi2\n'])
end

while (nit<enditer);			% fix number of iteration steps
 
%%%%%%%%%%%%%%%%%%%%%%%%%% BEGIN ITERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    
nit=nit+1;                          % iteration count
 
MOD=Vb*S*U'*F;                      % construct model with initial F
 
if nit==1,                          % preliminary adjustements
    vol=sum(D-bg)/sum(MOD);			% adjust volumes:data/'normalized model'
    F=vol*F;                        % adjust F accordingly
    INIMAP=vol*INIMAP;          	% adjust initial map :entropy reference
    UU=U\(log(INIMAP.\F));			% UU for the first iteration (zeros)
    MOD=vol*MOD;
end
 
MOD=round(MOD+bg);			% whole numbers
MODs=MOD(1:NDs);
 
% diagonalise K, K is now of dimension s*s.
K=U'*diag(F)*U;
 
if sum(sum(isnan(K)))+sum(sum(isinf(K)))~0;
    if verbose==1
        fprintf('*MELT error* convergence problems!\n')
    end
    error('WARNING: Convergence problems!')
    break
end
 
K=triu(K)-diag(diag(K))+triu(K)';	    % correct slight assymetries
[P,DK]=eig(K,'nobalance');		        % eigendecomposition of K
DK=diag(diag(DK));
for i=1:s				                % correct slightly negative eigenvalues 
	if DK(i,i)< 0,			            % to zero and calculate the square roots
        DK(i,i)=0;			                % of the other eigenvalues
	else DK(i,i)=(DK(i,i))^0.5;
	end
end
J=DK*P'*M*P*DK;
J=triu(J)-diag(diag(J))+triu(J)';	    % correct slight assymetries
[R,DJ]=eig(J,'nobalance');		        % eigendecomposition of J
DJ=diag(diag(DJ));
Yi=R'*DK*P'; 					
 
%%%%%%%%%%%%%%%%%%%%%%%%% maximise Q
G=S*V'*(Ds.\(MODs-Ds));	                % singular space gradient
 
% calculate X, used to calculate iterative correction on UU. xx=step length.
% a=alpha(entropy weight),b=mu(step length restriction), to be adjusted such
% that sum(INIMAP)~xx.

X=((a+b)*eye(s)+DJ)\(-a*Yi*UU-Yi*G);		
xx=X'*X;
xxsave(nit)=xx;
 
DELUU=(-a*UU-G-M*Yi'*X)/(a+b);	        % iterative correction on UU
UUBUF=UU;
UU=UU+DELUU;
 
NEWUUBUF=NEWUU;				            % store the exponent of the exponential
NEWUU=U*UU;				                % useful for troubleshooting
 
F=((exp(NEWUU)).*INIMAP);		        % reconstruct F
fsave(:,nit)=sum(F);
 
if (exist('b'))&(~isnan(xx))
    stepb=xx/sum(INIMAP);		            % adjust iteration step b:  xx <= sum(INIMAP)
    if b<a
        b=b/stepb;
    else
        b=b*stepb;
    end
end
 
% test for convergence
UUG=-a*UU-G;
conv=2*((K*UUG)'*UUG)^2/(a*((K*UU)'*UU) + ((K*G)'*G))^2;
 
if exist('sourcetime')==1,
    chi2=(sum(((MOD-D).^2)./(MOD+sourcecorr)))/ND;	% normalised chi square value
else
    chi2=(sum(((MOD-D).^2)./MOD))/ND;		        % normalised chi square value
end
 
% store parameters indicating convergence history. useful for troubleshooting
chi2save(nit)=chi2;
convsave(nit)=conv;

if verbose==1
    fprintf('%4.0f\t %4.4f\n',nit,chi2)
end;

if nit>lastiter
    if mean(chi2save(nit-lastiter:nit))<maxchi & std(chi2save(nit-lastiter:nit))<itermaxdev
        success=1;
        if exist('m_gui_iter','file')
            m_gui_iter(NaN)
        end
        break
    end
end

catch
    fprintf(['*MELT error* ',lasterr])
    if exist('m_gui_iter','file')
        m_gui_iter(lasterr)
    end
    break
end

end

if nit==enditer
    if exist('m_gui_iter','file')
        m_gui_iter('WARNING: Number of iterations exceeded!')
    end
end

%store all for this entropy
successes(entit)=success;
if success
    FC=F/sum(F);
    m_res;
    m_ltint;
    %Fs(entit,:)=F;
    FCs(entit,:)=FC;
    as(entit)=a;
    chi2s(entit)=chi2;
    nits(entit)=nit;
    ents(entit)=ent;
    ng1s(entit)=ng1;
    ng2s(entit)=ng2;
    pas(entit)=pa;
    pfs(entit)=pf;
    pfas(entit)=pfa;
    MODss(entit,:)=MOD;
    chi2saves(entit,:)=chi2save;
    convsaves(entit,:)=convsave;
    %xxsave
    %fsave
    %lims{entit}=lim;
    %standevfs{entit}=standevf;
    %Yis{entit}=Yi;
    taumeans{entit}=taumean;
    intensitys{entit}=intensity;
    interrors{entit}=interror;
end

%clear F a chi2 nit ent ng1 ng2 pa pf pfa MOD chi2save convsave lim standevf Yi

end

%clear DDL Vb V U UU Df DJ DK J K M P R S Y Finit f G L X alog conv entit
%*********************************************************************
