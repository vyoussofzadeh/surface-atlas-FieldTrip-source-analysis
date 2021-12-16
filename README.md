# Desikan–Killiany-surface-atlas-for FieldTrip-analysis
Desikan-Killian surface atlas for FieldTrip analysis. 

Steps to genetate the surface atlas nii file [this process can be generalized to produce other Freesurfer surface atlases], 

1) Export a source map from a sample Brainstorm (BS) database to Matlab, and call the varaible, "Source"
2) Read (and visualize) FreeSurfer-based atlases (e.g., Destrieux),

```
atlas = ft_read_atlas('./anat/@default_subject/tess_cortex_pial_low.mat'); % from BS
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
3) Update source values using color-coded parcel values. Save the updated (dummy) source in BS matlab file format.
```sdir = './data/Group_analysis/@intra'; % BS directory
savetag1 = fullfile(sdir, 'results_atlas_DK');
source.ImageGridAmp  = atlas.desikan_killiany;
source.Comment =  'atlas DK';
save(fullfile(savetag1),'-struct', 'source'),
```
3) Reload the BS database, the dummy source should be appreared in the panel.  
4) From the processing window export the source file to nii (volume) using BS (export to SPM8/12). This process can done using process_export_spmvol in BS.
5) Check the exported file example script
```
dkatlas = ft_read_atlas('xxx/Atlas_DK.nii');
atlas_DK.parcellationlabel = DK_ROIs; % mat file is added to repostiry

cfg = [];
cfg.parameter    = 'anatomy';
cfg.interpmethod = 'sphere_avg';
cfg.coordsys     = 'mni';
data_int  = ft_sourceinterpolate(cfg, SOURCE, atlas_DK); % SOURCE should be generated before
% data_int1 = data_int;

cfg = [];
cfg.method      = 'mean';
D_par_DK = ft_sourceparcellate(cfg, data_int, atlas_DK);
D_par_DK.powdimord =  'chan';
D_par_DK.label = atlas_DK2.parcellationlabel;
```
