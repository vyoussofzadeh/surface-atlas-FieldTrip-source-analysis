# Export-Desikan-Killiany-surface-atlas-from-BrainStorm-to-FieldTrip-toolbox
Surface-based atlas for source analysis
Steps, 

1) export a source map from BS to Matlab and call it Source
2) read surface atlas and color-coding

atlas = ft_read_atlas('./anat/@default_subject/tess_cortex_pial_low.mat');
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

% aa = atlas.desikan_killiany;

4)  

