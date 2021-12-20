function do_sourcevisualization(cfg_main, input)

cfg                = [];
cfg.method         = 'ortho';
cfg.funparameter   = cfg_main.mask;
cfg.funcolorlim    = 'maxabs';
cfg.opacitymap     = 'rampup';
cfg.crosshair      = 'no';
cfg.camlight       = 'no';
cfg.funcolormap    =  brewermap(256, '*RdYlBu');
cfg.projthresh     = cfg_main.thre;

cfg.method = 'surface';
cfg.surfinflated   = 'surface_inflated_both.mat';

ft_sourceplot(cfg, input);
view([90 0]);
camlight; material dull;

set(gcf,'name',cfg_main.subj,'numbertitle','off')

if cfg_main.saveflag ==1
    pause(0.5)
    set(gcf,'Color','w')
    print([cfg_main.subj,'_R'],'-dpng');
end

ft_sourceplot(cfg, input);
view([-90 0]); camlight; material dull;

set(gcf,'name',cfg_main.subj,'numbertitle','off')
if cfg_main.saveflag== 1
    pause(0.5)
    set(gcf,'Color','w')
    print([cfg_main.subj,'_L'],'-dpng');
end