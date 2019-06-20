% MRS Partial volume estimation script
% Date: January 21, 2019 [ Deepak@INMASS ]

ws  = 'csf_ws.rda';
nws   = 'csf_nws.rda';
anat = 'deepak.nii';

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

%% FSL based calculation

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

%% Now run FSL's segmentation (FAST)

system('bet deepak.nii deepak_brain.nii -R -f 0.3 -g 0 -c 117 156 82 -o -m -s');

%% Now run FSL's segmentation (FAST)

% FAST -t 1 = Using T1 image
system('fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o seg deepak_brain.nii.gz');

%% Count contribution of mask in segmented image

disp('CSF partial volume')
system('fslstats -t seg_pve_0.nii.gz -k csf_ws_mask.nii -m');
disp('csf matter partial volume')
system('fslstats -t seg_pve_1.nii.gz -k csf_ws_mask.nii -m');
disp('csf matter partial volume')
system('fslstats -t seg_pve_2.nii.gz -k csf_ws_mask.nii -m');



