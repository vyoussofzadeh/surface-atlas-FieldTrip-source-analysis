clear
load('DK_bs.mat')
dkatlas = ft_read_atlas('DK.nii');
atlas_DK.parcellationlabel = atlas_DK1.dk_labels;


cfg = [];
cfg.parameter    = 'anatomy';
cfg.interpmethod = 'sphere_avg';
cfg.coordsys     = 'mni';
data_int  = ft_sourceinterpolate(cfg, weights, atlas_DK);
% data_int1 = data_int;

cfg = [];
cfg.method      = 'mean';
D_par_DK = ft_sourceparcellate(cfg, data_int, atlas_DK);
D_par_DK.powdimord =  'chan';
D_par_DK.label = atlas_DK2.parcellationlabel;
% D_par1 = D_par;

cfg = [];
cfg.subj = 'group';
cfg.mask = 'anatomy';
cfg.thre = 0;
cfg.saveflag  = 2;
cfg.savepath = [];
% vy_mapvisualisation(cfg, D_par_DK);
