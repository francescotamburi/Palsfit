% melt.m
% a program for extracting lifetimes and intensities from a multiexponential
% decay curve as encountered in a positron lifetime experiment.
% see: shukla, peter and hoffmann NIM A 335 (1993) 310.
% uses the following matlab script files:
% m_input; m_data; m_mat1; m_mat2; m_scorr; m_iter; m_res m_save;
% the results may be visualised using m_plot
%
% version 3.1, november 1994
% abhay shukla, dpmc geneva university, 24 quai e. ansermet 1211 geneve 4
% shukla@scsun.unige.ch

path(path,fileparts(mfilename('fullpath')));
m_gui;

%*********************************************************************
