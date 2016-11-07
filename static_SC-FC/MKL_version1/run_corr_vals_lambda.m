close all
clear
clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions, loading all good subjects working with version1.

%% parameters
m = 10;
[~, n, num_subs] = size(sCall);
epsilon = 0.0;

%% scale set

% exp_values = linspace(0.2, 0.99, 100);
scl = linspace(0.0001, 4, num_scl);
%{
for 68 regions data scale range is [0.01, 4]
for 188 regions data scale range is [0.01, 12]
%}

%% 