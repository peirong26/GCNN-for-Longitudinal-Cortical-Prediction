clear;
clear;
clc;

n_vert = 0;
paths.sur = '/Users/peirong/Documents/Codes/Infant_Pred/Entire_Datasets_10242';
paths.patch = '/Users/peirong/Documents/Codes/Infant_Pred/Patch_Coord_All';
 
paths.syn_sur   = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All';
paths.syn_patch = '/Users/peirong/Documents/Cycle/TotalData/Patch_Coord_All';
paths.flags     = '/Users/peirong/Documents/Cycle/TotalData/Flags';

folders_subj_patch = dir(fullfile(paths.patch));

for sub_patch_start = 1:length(folders_subj_patch)
    na = folders_subj_patch(sub_patch_start).name;
    if na(1) == 'M'
        break
    end
end
        
for i = sub_patch_start:length(folders_subj_patch)
    
    subj_name = folders_subj_patch(i).name;
    paths.subj_patch = fullfile(paths.patch, subj_name);
    paths.subj_sur  = fullfile(paths.sur, subj_name);
    
    if ~exist(fullfile(paths.subj_patch,'00'),'dir')
        fprintf('Subject ''%s'': baseline unavailable, skipping.\n', subj_name);
        continue;        
    end
    
    % Create subj_paths to synthesized-including folders
    paths.subj_syn_patch = fullfile(paths.syn_patch,subj_name);
    if ~exist(paths.subj_syn_patch, 'dir')
        mkdir(paths.subj_syn_patch);
    end
    
    paths.subj_syn_sur = fullfile(paths.syn_sur,subj_name);
    if ~exist(paths.subj_syn_sur, 'dir')
        mkdir(paths.subj_syn_sur);
    end
    
    % Month 00
    li_name = sprintf('%s_00_lh.InnerSurf.mat',subj_name);
    ri_name = sprintf('%s_00_rh.InnerSurf.mat',subj_name);
    lo_name = sprintf('%s_00_lh.OuterSurf.mat',subj_name);
    ro_name = sprintf('%s_00_rh.OuterSurf.mat',subj_name);
    
    % Save subj_00 patch_coord
    
    paths.subj_patch_00 = fullfile(paths.subj_patch,'00');
    paths.subj_syn_patch_00 = fullfile(paths.subj_syn_patch,'00');
    if ~exist(paths.subj_syn_patch_00, 'dir')
        mkdir(paths.subj_syn_patch_00);
    end
    
    load(fullfile(paths.subj_patch_00, li_name));
    save(fullfile(paths.subj_syn_patch_00, li_name),'patch_coord','-v7.3');
    patch_coord_li0 = patch_coord;
    load(fullfile(paths.subj_patch_00, lo_name));
    save(fullfile(paths.subj_syn_patch_00, lo_name),'patch_coord','-v7.3');
    patch_coord_lo0 = patch_coord;
    load(fullfile(paths.subj_patch_00, ri_name));
    save(fullfile(paths.subj_syn_patch_00, ri_name),'patch_coord','-v7.3');
    patch_coord_ri0 = patch_coord;
    load(fullfile(paths.subj_patch_00, ro_name));
    save(fullfile(paths.subj_syn_patch_00, ro_name),'patch_coord','-v7.3');
    patch_coord_ro0 = patch_coord;
    
    % Save subj_00 surface
    
    paths.subj_sur_00 = fullfile(paths.subj_sur,'00');
    paths.subj_syn_sur_00 = fullfile(paths.subj_syn_sur,'00');
    if ~exist(paths.subj_syn_sur_00, 'dir')
        mkdir(paths.subj_syn_sur_00);
    end
    
    load(fullfile(paths.subj_sur_00, li_name));
    save(fullfile(paths.subj_syn_sur_00, li_name),'surface','-v7.3');
    surface_li0 = surface;
    
    load(fullfile(paths.subj_sur_00, lo_name));
    save(fullfile(paths.subj_syn_sur_00, lo_name),'surface','-v7.3');
    surface_lo0 = surface;
    
    load(fullfile(paths.subj_sur_00, ri_name));
    save(fullfile(paths.subj_syn_sur_00, ri_name),'surface','-v7.3');
    surface_ri0 = surface;
    
    load(fullfile(paths.subj_sur_00, ro_name));
    save(fullfile(paths.subj_syn_sur_00, ro_name),'surface','-v7.3');
    surface_ro0 = surface;
    
    
    % Month 03
    paths.subj_syn_patch_03 = fullfile(paths.subj_syn_patch,'03');
    if ~exist(paths.subj_syn_patch_03, 'dir')
        mkdir(paths.subj_syn_patch_03);
    end
    paths.subj_syn_sur_03 = fullfile(paths.subj_syn_sur,'03');
    if ~exist(paths.subj_syn_sur_03, 'dir')
        mkdir(paths.subj_syn_sur_03);
    end
    paths.flags_3  = fullfile(paths.flags, '03');
    if ~exist(paths.flags_3, 'dir')
        mkdir(paths.flags_3);
    end

    li_name = sprintf('%s_03_lh.InnerSurf.mat',subj_name);
    ri_name = sprintf('%s_03_rh.InnerSurf.mat',subj_name);
    lo_name = sprintf('%s_03_lh.OuterSurf.mat',subj_name);
    ro_name = sprintf('%s_03_rh.OuterSurf.mat',subj_name);
    
    if ~exist(fullfile(paths.subj_patch,'03'),'dir')
        fprintf('Subject ''%s'': month 03 unavailable, synthesizing.\n', subj_name); 
        flag = 0;
        
        save(fullfile(paths.flags_3, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_3, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_3, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_3, ro_name),'flag','-v7.3');
        
        % save pseudo subj_03 patch
        patch_coord = patch_coord_li0;
        patch_coord_li3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, li_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ri0;
        patch_coord_ri3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, ri_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_lo0;
        patch_coord_lo3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, lo_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ro0;
        patch_coord_ro3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, ro_name),'patch_coord','-v7.3');
        
        % save pseudo subj_03 surface
        surface = surface_li0;
        surface_li3 = surface;
        save(fullfile(paths.subj_syn_sur_03, li_name),'surface','-v7.3');
        surface = surface_ri0;
        surface_ri3 = surface;
        save(fullfile(paths.subj_syn_sur_03, ri_name),'surface','-v7.3');
        surface = surface_lo0;
        surface_lo3 = surface;
        save(fullfile(paths.subj_syn_sur_03, lo_name),'surface','-v7.3');
        surface = surface_ro0;
        surface_ro3 = surface;
        save(fullfile(paths.subj_syn_sur_03, ro_name),'surface','-v7.3');
        
    else
        flag = 1;
        
        save(fullfile(paths.flags_3, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_3, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_3, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_3, ro_name),'flag','-v7.3');
        
        paths.subj_patch_03 = fullfile(paths.subj_patch,'03');
        paths.subj_sur_03   = fullfile(paths.subj_sur,'03');
        
        load(fullfile(paths.subj_patch_03, li_name));
        patch_coord_li3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, li_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_03, ri_name));
        patch_coord_ri3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, ri_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_03, lo_name));
        patch_coord_lo3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, lo_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_03, ro_name));
        patch_coord_ro3 = patch_coord;
        save(fullfile(paths.subj_syn_patch_03, ro_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_sur_03, li_name));
        surface_li3 = surface;
        save(fullfile(paths.subj_syn_sur_03, li_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_03, ri_name));
        surface_ri3 = surface;
        save(fullfile(paths.subj_syn_sur_03, ri_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_03, lo_name));
        surface_lo3 = surface;
        save(fullfile(paths.subj_syn_sur_03, lo_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_03, ro_name));
        surface_ro3 = surface;
        save(fullfile(paths.subj_syn_sur_03, ro_name),'surface','-v7.3');
    
    end
    
    % Month 06
    paths.subj_syn_patch_06 = fullfile(paths.subj_syn_patch,'06');
    if ~exist(paths.subj_syn_patch_06, 'dir')
        mkdir(paths.subj_syn_patch_06);
    end
    paths.subj_syn_sur_06 = fullfile(paths.subj_syn_sur,'06');
    if ~exist(paths.subj_syn_sur_06, 'dir')
        mkdir(paths.subj_syn_sur_06);
    end
    paths.flags_6  = fullfile(paths.flags, '06');
    if ~exist(paths.flags_6, 'dir')
        mkdir(paths.flags_6);
    end

    li_name = sprintf('%s_06_lh.InnerSurf.mat',subj_name);
    ri_name = sprintf('%s_06_rh.InnerSurf.mat',subj_name);
    lo_name = sprintf('%s_06_lh.OuterSurf.mat',subj_name);
    ro_name = sprintf('%s_06_rh.OuterSurf.mat',subj_name);
    
    if ~exist(fullfile(paths.subj_patch,'06'),'dir')
        fprintf('Subject ''%s'': month 06 unavailable, synthesizing.\n', subj_name); 
        flag = 0;
        
        save(fullfile(paths.flags_6, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_6, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_6, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_6, ro_name),'flag','-v7.3');
        
        % save pseudo subj_06 patch
        patch_coord = patch_coord_li3;
        patch_coord_li6  = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, li_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ri3;
        patch_coord_ri6  = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, ri_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_lo3;
        patch_coord_lo6  = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, lo_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ro3;
        patch_coord_ro6  = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, ro_name),'patch_coord','-v7.3');
        
        % save pseudo subj_06 surface
        surface = surface_li3;
        surface_li6 = surface;
        save(fullfile(paths.subj_syn_sur_06, li_name),'surface','-v7.3');
        surface = surface_ri3;
        surface_ri6 = surface;
        save(fullfile(paths.subj_syn_sur_06, ri_name),'surface','-v7.3');
        surface = surface_lo3;
        surface_lo6 = surface;
        save(fullfile(paths.subj_syn_sur_06, lo_name),'surface','-v7.3');
        surface = surface_ro3;
        surface_ro6 = surface;
        save(fullfile(paths.subj_syn_sur_06, ro_name),'surface','-v7.3');
        
    else
        flag = 1;
        
        save(fullfile(paths.flags_6, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_6, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_6, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_6, ro_name),'flag','-v7.3');
        
        paths.subj_patch_06 = fullfile(paths.subj_patch,'06');
        paths.subj_sur_06   = fullfile(paths.subj_sur,'06');
        
        load(fullfile(paths.subj_patch_06, li_name));
        patch_coord_li6 = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, li_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_06, ri_name));
        patch_coord_ri6 = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, ri_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_06, lo_name));
        patch_coord_lo6 = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, lo_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_06, ro_name));
        patch_coord_ro6 = patch_coord;
        save(fullfile(paths.subj_syn_patch_06, ro_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_sur_06, li_name));
        surface_li6 = surface;
        save(fullfile(paths.subj_syn_sur_06, li_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_06, ri_name));
        surface_ri6 = surface;
        save(fullfile(paths.subj_syn_sur_06, ri_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_06, lo_name));
        surface_lo6 = surface;
        save(fullfile(paths.subj_syn_sur_06, lo_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_06, ro_name));
        surface_ro6 = surface;
        save(fullfile(paths.subj_syn_sur_06, ro_name),'surface','-v7.3');
    
    end
    
    % Month 09
    paths.subj_syn_patch_09 = fullfile(paths.subj_syn_patch,'09');
    if ~exist(paths.subj_syn_patch_09, 'dir')
        mkdir(paths.subj_syn_patch_09);
    end
    paths.subj_syn_sur_09 = fullfile(paths.subj_syn_sur,'09');
    if ~exist(paths.subj_syn_sur_09, 'dir')
        mkdir(paths.subj_syn_sur_09);
    end
    paths.flags_9  = fullfile(paths.flags, '09');
    if ~exist(paths.flags_9, 'dir')
        mkdir(paths.flags_9);
    end

    li_name = sprintf('%s_09_lh.InnerSurf.mat',subj_name);
    ri_name = sprintf('%s_09_rh.InnerSurf.mat',subj_name);
    lo_name = sprintf('%s_09_lh.OuterSurf.mat',subj_name);
    ro_name = sprintf('%s_09_rh.OuterSurf.mat',subj_name);
    
    if ~exist(fullfile(paths.subj_patch,'09'),'dir')
        fprintf('Subject ''%s'': month 09 unavailable, synthesizing.\n', subj_name); 
        flag = 0;
        
        save(fullfile(paths.flags_9, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_9, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_9, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_9, ro_name),'flag','-v7.3');
        
        % save pseudo subj_09 patch
        patch_coord = patch_coord_li6;
        patch_coord_li9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, li_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ri6;
        patch_coord_ri9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, ri_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_lo6;
        patch_coord_lo9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, lo_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ro6;
        patch_coord_ro9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, ro_name),'patch_coord','-v7.3');
        
        % save pseudo subj_09 surface
        surface = surface_li6;
        surface_li9 = surface;
        save(fullfile(paths.subj_syn_sur_09, li_name),'surface','-v7.3');
        surface = surface_ri6;
        surface_ri9 = surface;
        save(fullfile(paths.subj_syn_sur_09, ri_name),'surface','-v7.3');
        surface = surface_lo6;
        surface_lo9 = surface;
        save(fullfile(paths.subj_syn_sur_09, lo_name),'surface','-v7.3');
        surface = surface_ro6;
        surface_ro9 = surface;
        save(fullfile(paths.subj_syn_sur_09, ro_name),'surface','-v7.3');
        
    else
        flag = 1;
        
        save(fullfile(paths.flags_9, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_9, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_9, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_9, ro_name),'flag','-v7.3');
        
        paths.subj_patch_09 = fullfile(paths.subj_patch,'09');
        paths.subj_sur_09 = fullfile(paths.subj_sur,'09');
        
        load(fullfile(paths.subj_patch_09, li_name));
        patch_coord_li9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, li_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_09, ri_name));
        patch_coord_ri9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, ri_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_09, lo_name));
        patch_coord_lo9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, lo_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_09, ro_name));
        patch_coord_ro9 = patch_coord;
        save(fullfile(paths.subj_syn_patch_09, ro_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_sur_09, li_name));
        surface_li9 = surface;
        save(fullfile(paths.subj_syn_sur_09, li_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_09, ri_name));
        surface_ri9 = surface;
        save(fullfile(paths.subj_syn_sur_09, ri_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_09, lo_name));
        surface_lio9 = surface;
        save(fullfile(paths.subj_syn_sur_09, lo_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_09, ro_name));
        surface_ro9 = surface;
        save(fullfile(paths.subj_syn_sur_09, ro_name),'surface','-v7.3');
    
    end
    
    % Month 12
    paths.subj_syn_patch_12 = fullfile(paths.subj_syn_patch,'12');
    if ~exist(paths.subj_syn_patch_12, 'dir')
        mkdir(paths.subj_syn_patch_12);
    end
    paths.subj_syn_sur_12 = fullfile(paths.subj_syn_sur,'12');
    if ~exist(paths.subj_syn_sur_12, 'dir')
        mkdir(paths.subj_syn_sur_12);
    end
    paths.flags_12  = fullfile(paths.flags, '12');
    if ~exist(paths.flags_12, 'dir')
        mkdir(paths.flags_12);
    end

    li_name = sprintf('%s_12_lh.InnerSurf.mat',subj_name);
    ri_name = sprintf('%s_12_rh.InnerSurf.mat',subj_name);
    lo_name = sprintf('%s_12_lh.OuterSurf.mat',subj_name);
    ro_name = sprintf('%s_12_rh.OuterSurf.mat',subj_name);
    
    if ~exist(fullfile(paths.subj_patch,'12'),'dir')
        fprintf('Subject ''%s'': month 12 unavailable, synthesizing.\n', subj_name); 
        flag = 0;
        
        save(fullfile(paths.flags_12, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_12, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_12, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_12, ro_name),'flag','-v7.3');
        
        % save pseudo subj_12 patch
        patch_coord = patch_coord_li9;
        patch_coord_li12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, li_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ri9;
        patch_coord_ri12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, ri_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_lo9;
        patch_coord_loi12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, lo_name),'patch_coord','-v7.3');
        patch_coord = patch_coord_ro9;
        patch_coord_ro12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, ro_name),'patch_coord','-v7.3');
        
        % save pseudo subj_12 surface
        surface = surface_li9;
        surface_li12 = surface;
        save(fullfile(paths.subj_syn_sur_12, li_name),'surface','-v7.3');
        surface = surface_ri9;
        surface_ri12 = surface;
        save(fullfile(paths.subj_syn_sur_12, ri_name),'surface','-v7.3');
        surface = surface_lo9;
        surface_lo12 = surface;
        save(fullfile(paths.subj_syn_sur_12, lo_name),'surface','-v7.3');
        surface = surface_ro9;
        surface_ro12 = surface;
        save(fullfile(paths.subj_syn_sur_12, ro_name),'surface','-v7.3');
        
    else
        flag = 1;
        
        save(fullfile(paths.flags_12, li_name),'flag','-v7.3');
        save(fullfile(paths.flags_12, ri_name),'flag','-v7.3');
        save(fullfile(paths.flags_12, lo_name),'flag','-v7.3');
        save(fullfile(paths.flags_12, ro_name),'flag','-v7.3');
        
        paths.subj_patch_12 = fullfile(paths.subj_patch,'12');
        paths.subj_sur_12 = fullfile(paths.subj_sur,'12');
        
        load(fullfile(paths.subj_patch_12, li_name));
        patch_coord_li12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, li_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_12, ri_name));
        patch_coord_ri12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, ri_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_12, lo_name));
        patch_coord_lo12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, lo_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_patch_12, ro_name));
        patch_coord_ro12 = patch_coord;
        save(fullfile(paths.subj_syn_patch_12, ro_name),'patch_coord','-v7.3');
        
        load(fullfile(paths.subj_sur_12, li_name));
        surface_li12 = surface;
        save(fullfile(paths.subj_syn_sur_12, li_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_12, ri_name));
        surface_ri12 = surface;
        save(fullfile(paths.subj_syn_sur_12, ri_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_12, lo_name));
        surface_lo12 = surface;
        save(fullfile(paths.subj_syn_sur_12, lo_name),'surface','-v7.3');
        
        load(fullfile(paths.subj_sur_12, ro_name));
        surface_ro12 = surface;
        save(fullfile(paths.subj_syn_sur_12, ro_name),'surface','-v7.3');
    
    end
end
