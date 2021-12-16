
clear, close all

%% Reading and plotting DK atlas
atlas = ft_read_atlas('tess_cortex_pial_low.mat');
nScouts = size(unique(atlas.desikan_killiany),1);
colr = hsv(nScouts);
vertexcolor = zeros(size(atlas.pos,1), 3);
for iScout=1:nScouts
    index = find(atlas.desikan_killiany==iScout);
    if ~isempty(index)
        vertexcolor(index,:) = repmat(colr(iScout,:),  length(index), 1);
    end
end

% Visualisation de l'atlas Desikan_killiany
figure;
ft_plot_mesh(atlas, 'faecolor', 'brain',  'vertexcolor', ...
    vertexcolor, 'facealpha', 0.5);
view(-3, 2);

%% Parcellation
load('DK_bs.mat')
dkatlas = ft_read_atlas('DK.nii');
dkatlas.parcellationlabel = atlas_DK1.dk_labels;


load('ft_sourcesample')
cfg = [];
cfg.parameter    = 'anatomy';
cfg.interpmethod = 'sphere_avg';
cfg.coordsys     = 'mni';
data_int  = ft_sourceinterpolate(cfg, ft_source, dkatlas);
% data_int1 = data_int;

cfg = [];
cfg.method      = 'mean';
D_par_DK = ft_sourceparcellate(cfg, data_int, dkatlas);
D_par_DK.powdimord =  'chan';


D_par_DK_val = zscore(D_par_DK.anatomy);
n = 5;

%-positive effects
[~, idx] = sort((D_par_DK_val),'descend');
D_par_DK.label(idx(1:n))
D_par_DK_val(idx(1:n))

%-negative effects
[l, idx] = sort((D_par_DK_val),'ascend');
D_par_DK.label(idx(1:n))
D_par_DK_val(idx(1:n))


%% Color-coding atlas
addpath './cbrewer'
nScouts = 68;
% colr = viridis(nScouts);
% colr = flipud(brewermap(nScouts,'RdBu'));
% colr = (brewermap(nScouts,'RdBu'));
colr = flipud(viridis(nScouts));

[a,b] = sort(D_par_DK.anatomy, 'descend');
colr1 = colr(b,:);

n = 68;
D_par_DK.label(b(1:n))

atlas.vertexcolor = colr1;
vertexcolor = zeros(size(atlas_DK1.pos,1), 3);
for iScout=1:n%nScouts
    index = find(atlas_DK1.dk == b(iScout));
    if ~isempty(index)
        vertexcolor(index,:) = repmat(colr(iScout,:),  length(index), 1);
    end
end


figure;
ft_plot_mesh(atlas_DK1, 'facecolor', 'brain',  'vertexcolor', ...
    vertexcolor, 'facealpha', 1);
view(180, 0);

figure;
ft_plot_mesh(atlas_DK1, 'facecolor', 'brain',  'vertexcolor', ...
    vertexcolor, 'facealpha', 1);
view(0, 0);
