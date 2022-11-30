function [tau]=m_tgrid(tausteps,taumin,taumax)
%function [tau]=taugridexp(nend,const,increment)
% THIS FILE TO BE SAVED AS m_tgrid.m
% makes the exponentially increasing grid of lifetimes as used in m_tcmat.
%
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch

tauconst=log(taumin);
tauinc=log(taumax/taumin)/(tausteps-1);

tau=exp(tauconst+([1:tausteps]-1)*tauinc);
 
%*********************************************************************
