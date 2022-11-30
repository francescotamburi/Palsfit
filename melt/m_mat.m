% m_mat.m

startana=firstchannel+1-left_of_max;	    % first bin of analysis matrix
stopana=startana+ND-1;				    % last bin of analysis matrix
 
TCC=TC(startana:stopana,1:Ntau);	    % define the portion of the analysis
for ijk=1:Ntau				            % matrix to be used.
TCC(:,ijk)=TCC(:,ijk)/sum(TC(:,ijk));	% normalize matrix vectors
end
 
%*********************************************************************
