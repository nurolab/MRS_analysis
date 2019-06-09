% MRS Partial volume estimation script
% Date: January 21, 2019 [ Deepak@INMASS ]

ws  = 'data_ws.rda';
nws   = 'data_nws.rda';
anat = 'data.nii';

% Display settings

warning('off')
clc; clear MRS_struct; close all;

% MRS partial volume estimation
try
    MRS_struct = GannetLoad({ws nws}); % First file will be coregistered on anatomical
    MRS_struct = GannetFit(MRS_struct);
    MRS_struct = GannetCoRegister(MRS_struct, {anat});
    MRS_struct = GannetSegment(MRS_struct);
catch
    disp('An error occurred.');
end
