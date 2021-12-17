%% 1) Export a source map from a sample Brainstorm (BS) database to Matlab, and call the varaible, "Source."

%% 2) read (and visualize) FreeSurfer-based atlases (e.g., Destrieux),
atlas = ft_read_atlas('tess_cortex_pial_low.mat'); % from BS
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

%% 3) Update source values using color-coded parcel values. Save the updated (dummy) source in BS matlab file format.
sdir = './data/Group_analysis/@intra'; % BS directory
savetag1 = fullfile(sdir, 'results_atlas_DK');
source.ImageGridAmp  = atlas.desikan_killiany;
source.Comment =  'atlas DK';
save(fullfile(savetag1),'-struct', 'source'),

%% 4) Reload the BS database, the dummy source should be appreared in the panel.  
%% 5) From the processing window export the source file to nii (volume) using BS (export to SPM8/12). This process can done using process_export_spmvol in BS.
%% 6) Check the exported file example script
see Demo.m