# Desikan-Killiany-surface-atlas-for FieldTrip-analysis
Surface-based atlas for source analysis
Steps, 

1) export a source map from a sample Brainstorm (BS) database to Matlab. Call the varaible, Source
2) read (mapping) surface atlas and color-coding areas

```atlas = ft_read_atlas('./anat/@default_subject/tess_cortex_pial_low.mat');
nScouts = size(unique(atlas.desikan_killiany),1);
colr = hsv(nScouts); 
vertexcolor = zeros(size(atlas.pos,1), 3);
for iScout=1:nScouts       
   index = find(atlas.desikan_killiany==iScout);
   if ~isempty(index) 
      vertexcolor(index,:) = repmat(colr(iScout,:),  length(index), 1);
   end      
end    

% Visualisation Desikan_killiany
figure;
ft_plot_mesh(atlas, 'faecolor', 'brain',  'vertexcolor', ...
vertexcolor, 'facealpha', 0.5);
view(-3, 2);
```
3) update source values with color-coded parcels and import back the updated files to BS, e.g., 
```sdir = './data/Group_analysis/@intra'; % BS directory
savetag1 = fullfile(sdir, 'results_atlas_DK');
source.ImageGridAmp  = atlas.desikan_killiany;
source.Comment =  'atlas DK';
save(fullfile(savetag1),'-struct', 'source'),
```
4) Export file to nii using BS (export to SPM8/12)
This process can done using BS-GUI (File/Export to SPM8/12 (volume))

6) Cheking and example script
```
dkatlas = ft_read_atlas('xxx/Atlas_DK.nii');

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
```
