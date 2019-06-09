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
    MRS_struct = GannetCoRegister(MRS_struct, {anat});
catch
    disp('An error occurred.');
end

% FSL based calculation
fsldir = '/usr/local/fsl';
setenv('FSLDIR',fsldir);  % this to tell where FSL folder is
setenv('FSLOUTPUTTYPE','NIFTI_GZ')
if ~exist(fsldir,'dir')
	error('%s: error fsldir (%s) not found',mfilename, fsldir);
end
setenv('PATH',sprintf('%s:%s',fullfile(fsldir,'bin'),getenv('PATH')));
bet = [fsldir '/bin/bet'];
if ~exist(bet)
	error('%s: error %s not found',mfilename,bet);
end

system('bet data.nii data_brain -R -f 0.512 -g 0 -c 80 108 172 -o -m -s');
% Now run FSL's segmentation (FAST)
%FAST -t 1 = Using T1 image
system('fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o seg data_brain.nii.gz');
disp('CSF partial volume')
system('fslstats -t seg_pve_0.nii.gz -k data_ws_mask.nii -m');
disp('Gray matter partial volume')
system('fslstats -t seg_pve_1.nii.gz -k data_ws_mask.nii -m');
disp('White matter partial volume')
system('fslstats -t seg_pve_2.nii.gz -k data_ws_mask.nii -m');
