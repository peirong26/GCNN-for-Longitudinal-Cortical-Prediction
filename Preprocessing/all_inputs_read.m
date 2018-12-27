% Compute inputs for all month-combinations

clear;
close all;
clc;
 
n_vert = 10242;
 
paths.syn_sur   = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All';
paths.syn_patch = '/Users/peirong/Documents/Cycle/TotalData/Patch_Coord_All';
paths.flags_3   = '/Users/peirong/Documents/Cycle/TotalData/Flags/03';
paths.flags_6   = '/Users/peirong/Documents/Cycle/TotalData/Flags/06';
paths.flags_9   = '/Users/peirong/Documents/Cycle/TotalData/Flags/09';
paths.flags_12  = '/Users/peirong/Documents/Cycle/TotalData/Flags/12';
 
paths.main   = '/Users/peirong/Documents/Cycle/TotalData/datasets';
paths.for_00 = fullfile(paths.main,'00');
paths.for_03 = fullfile(paths.main,'03');
paths.for_06 = fullfile(paths.main,'06');
paths.for_09 = fullfile(paths.main,'09');
paths.for_12 = fullfile(paths.main,'12');

paths.for_00_patch = fullfile(paths.for_00,'patch_coord');
paths.for_00_desc = fullfile(paths.for_00,'desc');
paths.for_00_desc_coord = fullfile(paths.for_00_desc,'coord'); % Set 00 In/Out as origin
paths.for_00_desc_out_in = fullfile(paths.for_00_desc,'out_in'); % Set 00 Inner as origin
paths.for_00_desc_rel_coord = fullfile(paths.for_00_desc,'rel_coord'); % Set previous In/Out as origin
paths.for_00_desc_curvature = fullfile(paths.for_00_desc,'curvature');
paths.for_00_desc_curvIn    = fullfile(paths.for_00_desc,'curvInflate');
paths.for_00_desc_convexity = fullfile(paths.for_00_desc,'convexity');
paths.for_00_desc_thickness = fullfile(paths.for_00_desc,'thickness');
paths.for_00_desc_rel_thick = fullfile(paths.for_00_desc,'rel_thick'); % Set previous as origin

paths.for_03_patch = fullfile(paths.for_03,'patch_coord');
paths.for_03_desc = fullfile(paths.for_03,'desc');
paths.for_03_desc_coord = fullfile(paths.for_03_desc,'coord');
paths.for_03_desc_rel_coord = fullfile(paths.for_03_desc,'rel_coord');
paths.for_03_desc_out_in = fullfile(paths.for_03_desc,'out_in');
paths.for_03_desc_curvature = fullfile(paths.for_03_desc,'curvature');
paths.for_03_desc_curvIn    = fullfile(paths.for_03_desc,'curvInflate');
paths.for_03_desc_convexity = fullfile(paths.for_03_desc,'convexity');
paths.for_03_desc_thickness = fullfile(paths.for_03_desc,'thickness');
paths.for_03_desc_rel_thick = fullfile(paths.for_03_desc,'rel_thick');
paths.for_03_flags = fullfile(paths.for_03,'flags');

paths.for_06_patch = fullfile(paths.for_06,'patch_coord');
paths.for_06_desc = fullfile(paths.for_06,'desc');
paths.for_06_desc_coord = fullfile(paths.for_06_desc,'coord');
paths.for_06_desc_rel_coord = fullfile(paths.for_06_desc,'rel_coord');
paths.for_06_desc_out_in = fullfile(paths.for_06_desc,'out_in');
paths.for_06_desc_curvature = fullfile(paths.for_06_desc,'curvature');
paths.for_06_desc_curvIn    = fullfile(paths.for_06_desc,'curvInflate');
paths.for_06_desc_convexity = fullfile(paths.for_06_desc,'convexity');
paths.for_06_desc_thickness = fullfile(paths.for_06_desc,'thickness');
paths.for_06_desc_rel_thick = fullfile(paths.for_06_desc,'rel_thick');
paths.for_06_flags = fullfile(paths.for_06,'flags');

paths.for_09_patch = fullfile(paths.for_09,'patch_coord');
paths.for_09_desc = fullfile(paths.for_09,'desc');
paths.for_09_desc_coord = fullfile(paths.for_09_desc,'coord');
paths.for_09_desc_rel_coord = fullfile(paths.for_09_desc,'rel_coord');
paths.for_09_desc_out_in = fullfile(paths.for_09_desc,'out_in');
paths.for_09_desc_curvature = fullfile(paths.for_09_desc,'curvature');
paths.for_09_desc_curvIn    = fullfile(paths.for_09_desc,'curvInflate');
paths.for_09_desc_convexity = fullfile(paths.for_09_desc,'convexity');
paths.for_09_desc_thickness = fullfile(paths.for_09_desc,'thickness');
paths.for_09_desc_rel_thick = fullfile(paths.for_09_desc,'rel_thick');
paths.for_09_flags = fullfile(paths.for_09,'flags');

paths.for_12_patch = fullfile(paths.for_12,'patch_coord');
paths.for_12_desc = fullfile(paths.for_12,'desc');
paths.for_12_desc_coord = fullfile(paths.for_12_desc,'coord');
paths.for_12_desc_rel_coord = fullfile(paths.for_12_desc,'rel_coord');
paths.for_12_desc_out_in = fullfile(paths.for_12_desc,'out_in');
paths.for_12_desc_curvature = fullfile(paths.for_12_desc,'curvature');
paths.for_12_desc_curvIn    = fullfile(paths.for_12_desc,'curvInflate');
paths.for_12_desc_convexity = fullfile(paths.for_12_desc,'convexity');
paths.for_12_desc_thickness = fullfile(paths.for_12_desc,'thickness');
paths.for_12_desc_rel_thick = fullfile(paths.for_12_desc,'rel_thick');
paths.for_12_flags = fullfile(paths.for_12,'flags');

folders_subj_surface = dir(fullfile(paths.syn_sur));
 
for I_start = 1:length(folders_subj_surface)
    na = folders_subj_surface(I_start).name;
    if na(1) == 'M'
        break
    end
end
        
for i = I_start:length(folders_subj_surface)
    
    subj_name = folders_subj_surface(i).name;
    
    paths.subj_sur = fullfile(paths.syn_sur,subj_name);
    paths.subj_patch = fullfile(paths.syn_patch,subj_name);
    
    months_all = dir(fullfile(paths.subj_patch));
    
    % For 00 month
    paths.month_sur_00 = fullfile(paths.subj_sur, '00'); 
    paths.month_patch_00 = fullfile(paths.subj_patch, '00');
    li_name_00 = sprintf('%s_00_lh.InnerSurf.mat',subj_name);
    ri_name_00 = sprintf('%s_00_rh.InnerSurf.mat',subj_name);
    lo_name_00 = sprintf('%s_00_lh.OuterSurf.mat',subj_name);
    ro_name_00 = sprintf('%s_00_rh.OuterSurf.mat',subj_name);
    
    % Save baseline patch_coord
    load(fullfile(paths.month_patch_00,li_name_00))
    save(fullfile(paths.for_00_patch,li_name_00),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_00,ri_name_00))
    save(fullfile(paths.for_00_patch,ri_name_00),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_00,lo_name_00))
    save(fullfile(paths.for_00_patch,lo_name_00),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_00,ro_name_00))
    save(fullfile(paths.for_00_patch,ro_name_00),'patch_coord','-v7.3');
    
    % Save baseline desc (li)
    load(fullfile(paths.month_sur_00,li_name_00))
    coord_00_li = [surface.X, surface.Y, surface.Z];
    thick_00_li = surface.thickness;
    curv_00_li  = surface.curvature;
    curvIn_00_li= surface.curvInflate;
    conv_00_li  = surface.convexity;
    % Save baseline desc (lo)
    load(fullfile(paths.month_sur_00,lo_name_00))
    coord_00_lo  = [surface.X, surface.Y, surface.Z];
    thick_00_lo  = surface.thickness;
    curv_00_lo   = surface.curvature;
    curvIn_00_lo = surface.curvInflate;
    conv_00_lo   = surface.convexity;
    
    out_in_00_lo  = coord_00_lo - coord_00_li;
    
    % Save baseline desc (ri)
    load(fullfile(paths.month_sur_00,ri_name_00))
    coord_00_ri = [surface.X, surface.Y, surface.Z];
    thick_00_ri = surface.thickness;
    curv_00_ri  = surface.curvature;
    curvIn_00_ri= surface.curvInflate;
    conv_00_ri  = surface.convexity;
    % Save baseline desc (ro)
    load(fullfile(paths.month_sur_00,ro_name_00))
    coord_00_ro = [surface.X, surface.Y, surface.Z];
    thick_00_ro = surface.thickness;
    curv_00_ro  = surface.curvature;
    curvIn_00_ro= surface.curvInflate;
    conv_00_ro  = surface.convexity;
    
    out_in_00_ro  = coord_00_ro - coord_00_ri;
    
    desc = zeros(n_vert,3) + (1e-14);
    save(fullfile(paths.for_00_desc_coord,li_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_coord,li_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_coord,ri_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_coord,ri_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_coord,lo_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_coord,lo_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_coord,ro_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_coord,ro_name_00),'desc','-v7.3');

    save(fullfile(paths.for_00_desc_out_in,li_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_out_in,ri_name_00),'desc','-v7.3');
    
    desc = zeros(n_vert,1) + (1e-14);
    save(fullfile(paths.for_00_desc_rel_thick,li_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_thick,ri_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_thick,lo_name_00),'desc','-v7.3');
    save(fullfile(paths.for_00_desc_rel_thick,ro_name_00),'desc','-v7.3');
    
    desc = curv_00_li;
    save(fullfile(paths.for_00_desc_curvature,li_name_00),'desc','-v7.3');
    desc = curv_00_ri;
    save(fullfile(paths.for_00_desc_curvature,ri_name_00),'desc','-v7.3');
    desc = curv_00_lo;
    save(fullfile(paths.for_00_desc_curvature,lo_name_00),'desc','-v7.3');
    desc = curv_00_ro;
    save(fullfile(paths.for_00_desc_curvature,ro_name_00),'desc','-v7.3');
    
    desc = curvIn_00_li;
    save(fullfile(paths.for_00_desc_curvIn,li_name_00),'desc','-v7.3');
    desc = curvIn_00_ri;
    save(fullfile(paths.for_00_desc_curvIn,ri_name_00),'desc','-v7.3');
    desc = curvIn_00_lo;
    save(fullfile(paths.for_00_desc_curvIn,lo_name_00),'desc','-v7.3');
    desc = curvIn_00_ro;
    save(fullfile(paths.for_00_desc_curvIn,ro_name_00),'desc','-v7.3');
    
    desc = conv_00_li;
    save(fullfile(paths.for_00_desc_convexity,li_name_00),'desc','-v7.3');
    desc = conv_00_ri;
    save(fullfile(paths.for_00_desc_convexity,ri_name_00),'desc','-v7.3');
    desc = conv_00_lo;
    save(fullfile(paths.for_00_desc_convexity,lo_name_00),'desc','-v7.3');
    desc = conv_00_ro;
    save(fullfile(paths.for_00_desc_convexity,ro_name_00),'desc','-v7.3');
    
    desc = thick_00_li;
    save(fullfile(paths.for_00_desc_thickness,li_name_00),'desc','-v7.3');
    desc = thick_00_ri;
    save(fullfile(paths.for_00_desc_thickness,ri_name_00),'desc','-v7.3');
    desc = thick_00_lo;
    save(fullfile(paths.for_00_desc_thickness,lo_name_00),'desc','-v7.3');
    desc = thick_00_ro;
    save(fullfile(paths.for_00_desc_thickness,ro_name_00),'desc','-v7.3');
    
    desc = out_in_00_lo;
    save(fullfile(paths.for_00_desc_out_in,lo_name_00),'desc','-v7.3');
    desc = out_in_00_ro;
    save(fullfile(paths.for_00_desc_out_in,ro_name_00),'desc','-v7.3');
    
    
    % For 03 month
    paths.month_sur_03 = fullfile(paths.subj_sur, '03'); 
    paths.month_patch_03 = fullfile(paths.subj_patch, '03');
    li_name_03 = sprintf('%s_03_lh.InnerSurf.mat',subj_name);
    ri_name_03 = sprintf('%s_03_rh.InnerSurf.mat',subj_name);
    lo_name_03 = sprintf('%s_03_lh.OuterSurf.mat',subj_name);
    ro_name_03 = sprintf('%s_03_rh.OuterSurf.mat',subj_name);
    
    % Save patch_coord
    load(fullfile(paths.month_patch_03,li_name_03))
    save(fullfile(paths.for_03_patch,li_name_03),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_03,ri_name_03))
    save(fullfile(paths.for_03_patch,ri_name_03),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_03,lo_name_03))
    save(fullfile(paths.for_03_patch,lo_name_03),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_03,ro_name_03))
    save(fullfile(paths.for_03_patch,ro_name_03),'patch_coord','-v7.3');
    
    % Save all desc (li)
    load(fullfile(paths.month_sur_03,li_name_03))
    desc = [surface.X, surface.Y, surface.Z] - coord_00_li;
    coord_li3 = [surface.X, surface.Y, surface.Z];
    thick_li3 = surface.thickness;
    save(fullfile(paths.for_03_desc_coord,li_name_03),'desc','-v7.3');
    save(fullfile(paths.for_03_desc_rel_coord,li_name_03),'desc','-v7.3');
    save(fullfile(paths.for_03_desc_out_in,li_name_03),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_03_desc_curvature,li_name_03),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_03_desc_curvIn,li_name_03),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_03_desc_convexity,li_name_03),'desc','-v7.3');
    desc = surface.thickness - thick_00_li;
    save(fullfile(paths.for_03_desc_rel_thick,li_name_03),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_03_desc_thickness,li_name_03),'desc','-v7.3');
    
    % Save all desc (lo)
    load(fullfile(paths.month_sur_03,lo_name_03))
    desc = [surface.X, surface.Y, surface.Z] - coord_00_lo;
    coord_lo3 = [surface.X, surface.Y, surface.Z];
    thick_lo3 = surface.thickness;
    save(fullfile(paths.for_03_desc_coord,lo_name_03),'desc','-v7.3');
    save(fullfile(paths.for_03_desc_rel_coord,lo_name_03),'desc','-v7.3');
    
    desc = coord_lo3 - coord_00_li;
    save(fullfile(paths.for_03_desc_out_in,lo_name_03),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_03_desc_curvature,lo_name_03),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_03_desc_curvIn,lo_name_03),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_03_desc_convexity,lo_name_03),'desc','-v7.3');
    desc = surface.thickness - thick_00_lo;
    save(fullfile(paths.for_03_desc_rel_thick,lo_name_03),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_03_desc_thickness,lo_name_03),'desc','-v7.3');
    
    % Save all desc (ri)
    load(fullfile(paths.month_sur_03,ri_name_03))
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ri;
    coord_ri3 = [surface.X, surface.Y, surface.Z];
    thick_ri3 = surface.thickness;
    save(fullfile(paths.for_03_desc_coord,ri_name_03),'desc','-v7.3');
    save(fullfile(paths.for_03_desc_rel_coord,ri_name_03),'desc','-v7.3');
    save(fullfile(paths.for_03_desc_out_in,ri_name_03),'desc','-v7.3');

    desc = surface.curvature;
    save(fullfile(paths.for_03_desc_curvature,ri_name_03),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_03_desc_curvIn,ri_name_03),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_03_desc_convexity,ri_name_03),'desc','-v7.3');
    desc = surface.thickness - thick_00_ri;
    save(fullfile(paths.for_03_desc_rel_thick,ri_name_03),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_03_desc_thickness,ri_name_03),'desc','-v7.3');
    
    % Save all desc (ro)
    load(fullfile(paths.month_sur_03,ro_name_03))
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ro;
    coord_ro3 = [surface.X, surface.Y, surface.Z];
    thick_ro3 = surface.thickness;
    save(fullfile(paths.for_03_desc_coord,ro_name_03),'desc','-v7.3');
    save(fullfile(paths.for_03_desc_rel_coord,ro_name_03),'desc','-v7.3');
    
    desc = coord_ro3 - coord_00_ri;
    save(fullfile(paths.for_03_desc_out_in,ro_name_03),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_03_desc_curvature,ro_name_03),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_03_desc_curvIn,ro_name_03),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_03_desc_convexity,ro_name_03),'desc','-v7.3');
    desc = surface.thickness - thick_00_ro;
    save(fullfile(paths.for_03_desc_rel_thick,ro_name_03),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_03_desc_thickness,ro_name_03),'desc','-v7.3');
    
    % Save flag_3
    load(fullfile(paths.flags_3, li_name_03));
    save(fullfile(paths.for_03_flags, li_name_03),'flag','-v7.3');
    load(fullfile(paths.flags_3, ri_name_03));
    save(fullfile(paths.for_03_flags, ri_name_03),'flag','-v7.3');
    load(fullfile(paths.flags_3, lo_name_03));
    save(fullfile(paths.for_03_flags, lo_name_03),'flag','-v7.3');
    load(fullfile(paths.flags_3, ro_name_03));
    save(fullfile(paths.for_03_flags, ro_name_03),'flag','-v7.3');
    
    
    % For 06 month
    paths.month_sur_06 = fullfile(paths.subj_sur, '06'); 
    paths.month_patch_06 = fullfile(paths.subj_patch, '06');
    li_name_06 = sprintf('%s_06_lh.InnerSurf.mat',subj_name);
    ri_name_06 = sprintf('%s_06_rh.InnerSurf.mat',subj_name);
    lo_name_06 = sprintf('%s_06_lh.OuterSurf.mat',subj_name);
    ro_name_06 = sprintf('%s_06_rh.OuterSurf.mat',subj_name);
    
    % Save patch_coord
    load(fullfile(paths.month_patch_06,li_name_06))
    save(fullfile(paths.for_06_patch,li_name_06),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_06,ri_name_06))
    save(fullfile(paths.for_06_patch,ri_name_06),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_06,lo_name_06))
    save(fullfile(paths.for_06_patch,lo_name_06),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_06,ro_name_06))
    save(fullfile(paths.for_06_patch,ro_name_06),'patch_coord','-v7.3');
    
    % Save all desc (li)
    load(fullfile(paths.month_sur_06,li_name_06))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_li;
    coord_li6 = [surface.X, surface.Y, surface.Z];
    thick_li6 = surface.thickness;
    save(fullfile(paths.for_06_desc_coord,li_name_06),'desc','-v7.3');
    save(fullfile(paths.for_06_desc_out_in,li_name_06),'desc','-v7.3');

    desc = [surface.X, surface.Y, surface.Z] - coord_li3;
    save(fullfile(paths.for_06_desc_rel_coord,li_name_06),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_06_desc_curvature,li_name_06),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_06_desc_curvIn,li_name_06),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_06_desc_convexity,li_name_06),'desc','-v7.3');
    desc = surface.thickness - thick_li3;
    save(fullfile(paths.for_06_desc_rel_thick,li_name_06),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_06_desc_thickness,li_name_06),'desc','-v7.3');
    
    % Save all desc (lo)
    load(fullfile(paths.month_sur_06,lo_name_06))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_lo;
    coord_lo6 = [surface.X, surface.Y, surface.Z];
    thick_lo6 = surface.thickness;
    save(fullfile(paths.for_06_desc_coord,lo_name_06),'desc','-v7.3');
    desc = [surface.X, surface.Y, surface.Z] - coord_lo3;
    save(fullfile(paths.for_06_desc_rel_coord,lo_name_06),'desc','-v7.3');
    
    desc = coord_lo6 - coord_00_li;
    save(fullfile(paths.for_06_desc_out_in,lo_name_06),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_06_desc_curvature,lo_name_06),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_06_desc_curvIn,lo_name_06),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_06_desc_convexity,lo_name_06),'desc','-v7.3');
    desc = surface.thickness - thick_lo3;
    save(fullfile(paths.for_06_desc_rel_thick,lo_name_06),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_06_desc_thickness,lo_name_06),'desc','-v7.3');
    
    % Save all desc (ri)
    load(fullfile(paths.month_sur_06,ri_name_06))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ri;
    coord_ri6 = [surface.X, surface.Y, surface.Z];
    thick_ri6 = surface.thickness;
    save(fullfile(paths.for_06_desc_coord,ri_name_06),'desc','-v7.3');
    save(fullfile(paths.for_06_desc_out_in,ri_name_06),'desc','-v7.3');

    desc = [surface.X, surface.Y, surface.Z] - coord_ri3;
    save(fullfile(paths.for_06_desc_rel_coord,ri_name_06),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_06_desc_curvature,ri_name_06),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_06_desc_curvIn,ri_name_06),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_06_desc_convexity,ri_name_06),'desc','-v7.3');
    desc = surface.thickness - thick_ri3;
    save(fullfile(paths.for_06_desc_rel_thick,ri_name_06),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_06_desc_thickness,ri_name_06),'desc','-v7.3');
    
    % Save all desc (ro)
    load(fullfile(paths.month_sur_06,ro_name_06))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ro;
    coord_ro6 = [surface.X, surface.Y, surface.Z];
    thick_ro6 = surface.thickness;
    save(fullfile(paths.for_06_desc_coord,ro_name_06),'desc','-v7.3');
    desc = [surface.X, surface.Y, surface.Z] - coord_ro3;
    save(fullfile(paths.for_06_desc_rel_coord,ro_name_06),'desc','-v7.3');
    
    desc = coord_ro6 - coord_00_ri;
    save(fullfile(paths.for_06_desc_out_in,ro_name_06),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_06_desc_curvature,ro_name_06),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_06_desc_curvIn,ro_name_06),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_06_desc_convexity,ro_name_06),'desc','-v7.3');
    desc = surface.thickness - thick_ro3;
    save(fullfile(paths.for_06_desc_rel_thick,ro_name_06),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_06_desc_thickness,ro_name_06),'desc','-v7.3');
    
    % Save flag_6
    load(fullfile(paths.flags_6, li_name_06));
    save(fullfile(paths.for_06_flags, li_name_06),'flag','-v7.3');
    load(fullfile(paths.flags_6, ri_name_06));
    save(fullfile(paths.for_06_flags, ri_name_06),'flag','-v7.3');
    load(fullfile(paths.flags_6, lo_name_06));
    save(fullfile(paths.for_06_flags, lo_name_06),'flag','-v7.3');
    load(fullfile(paths.flags_6, ro_name_06));
    save(fullfile(paths.for_06_flags, ro_name_06),'flag','-v7.3');
    
    
    % For 09 month
    paths.month_sur_09 = fullfile(paths.subj_sur, '09'); 
    paths.month_patch_09 = fullfile(paths.subj_patch, '09');
    li_name_09 = sprintf('%s_09_lh.InnerSurf.mat',subj_name);
    ri_name_09 = sprintf('%s_09_rh.InnerSurf.mat',subj_name);
    lo_name_09 = sprintf('%s_09_lh.OuterSurf.mat',subj_name);
    ro_name_09 = sprintf('%s_09_rh.OuterSurf.mat',subj_name);
    
    % Save patch_coord
    load(fullfile(paths.month_patch_09,li_name_09))
    save(fullfile(paths.for_09_patch,li_name_09),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_09,ri_name_09))
    save(fullfile(paths.for_09_patch,ri_name_09),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_09,lo_name_09))
    save(fullfile(paths.for_09_patch,lo_name_09),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_09,ro_name_09))
    save(fullfile(paths.for_09_patch,ro_name_09),'patch_coord','-v7.3');
    
    % Save all desc (li)
    load(fullfile(paths.month_sur_09,li_name_09))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_li;
    coord_li9 = [surface.X, surface.Y, surface.Z]; 
    thick_li9 = surface.thickness;
    save(fullfile(paths.for_09_desc_coord,li_name_09),'desc','-v7.3');
    save(fullfile(paths.for_09_desc_out_in,li_name_09),'desc','-v7.3');

    desc = [surface.X, surface.Y, surface.Z] - coord_li6;
    save(fullfile(paths.for_09_desc_rel_coord,li_name_09),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_09_desc_curvature,li_name_09),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_09_desc_curvIn,li_name_09),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_09_desc_convexity,li_name_09),'desc','-v7.3');
    desc = surface.thickness - thick_li6;
    save(fullfile(paths.for_09_desc_rel_thick,li_name_09),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_09_desc_thickness,li_name_09),'desc','-v7.3');
    
     % Save all desc (lo)
    load(fullfile(paths.month_sur_09,li_name_09))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_lo;
    coord_lo9 = [surface.X, surface.Y, surface.Z]; 
    thick_lo9 = surface.thickness;
    save(fullfile(paths.for_09_desc_coord,lo_name_09),'desc','-v7.3');
    desc = [surface.X, surface.Y, surface.Z] - coord_lo6;
    save(fullfile(paths.for_09_desc_rel_coord,lo_name_09),'desc','-v7.3');
    
    desc = coord_lo9 - coord_00_li;
    save(fullfile(paths.for_09_desc_out_in,lo_name_09),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_09_desc_curvature,lo_name_09),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_09_desc_curvIn,lo_name_09),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_09_desc_convexity,lo_name_09),'desc','-v7.3');
    desc = surface.thickness - thick_lo6;
    save(fullfile(paths.for_09_desc_rel_thick,lo_name_09),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_09_desc_thickness,lo_name_09),'desc','-v7.3');
    
    % Save all desc (ri)
    load(fullfile(paths.month_sur_09,ri_name_09))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ri;
    coord_ri9 = [surface.X, surface.Y, surface.Z];
    thick_ri9 = surface.thickness;
    save(fullfile(paths.for_09_desc_coord,ri_name_09),'desc','-v7.3');
    save(fullfile(paths.for_09_desc_out_in,ri_name_09),'desc','-v7.3');

    desc = [surface.X, surface.Y, surface.Z] - coord_ri6;
    save(fullfile(paths.for_09_desc_rel_coord,ri_name_09),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_09_desc_curvature,ri_name_09),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_09_desc_curvIn,ri_name_09),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_09_desc_convexity,ri_name_09),'desc','-v7.3');
    desc = surface.thickness - thick_ri6;
    save(fullfile(paths.for_09_desc_rel_thick,ri_name_09),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_09_desc_thickness,ri_name_09),'desc','-v7.3');
    
     % Save all desc (ro)
    load(fullfile(paths.month_sur_09,ro_name_09))
    
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ro;
    coord_ro9 = [surface.X, surface.Y, surface.Z];
    thick_ro9 = surface.thickness;
    save(fullfile(paths.for_09_desc_coord,ro_name_09),'desc','-v7.3');
    desc = [surface.X, surface.Y, surface.Z] - coord_ro6;
    save(fullfile(paths.for_09_desc_rel_coord,ro_name_09),'desc','-v7.3');
    
    desc = coord_ro9 - coord_00_ri;
    save(fullfile(paths.for_09_desc_out_in,ro_name_09),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_09_desc_curvature,ro_name_09),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_09_desc_curvIn,ro_name_09),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_09_desc_convexity,ro_name_09),'desc','-v7.3');
    desc = surface.thickness - thick_ro6;
    save(fullfile(paths.for_09_desc_rel_thick,ro_name_09),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_09_desc_thickness,ro_name_09),'desc','-v7.3');
    
    % Save flag_9
    load(fullfile(paths.flags_9, li_name_09));
    save(fullfile(paths.for_09_flags, li_name_09),'flag','-v7.3');
    load(fullfile(paths.flags_9, ri_name_09));
    save(fullfile(paths.for_09_flags, ri_name_09),'flag','-v7.3');
    load(fullfile(paths.flags_9, lo_name_09));
    save(fullfile(paths.for_09_flags, lo_name_09),'flag','-v7.3');
    load(fullfile(paths.flags_9, ro_name_09));
    save(fullfile(paths.for_09_flags, ro_name_09),'flag','-v7.3');
    
    
    % For 12 month
    paths.month_sur_12 = fullfile(paths.subj_sur, '12'); 
    paths.month_patch_12 = fullfile(paths.subj_patch, '12');
    li_name_12 = sprintf('%s_12_lh.InnerSurf.mat',subj_name);
    ri_name_12 = sprintf('%s_12_rh.InnerSurf.mat',subj_name);
    lo_name_12 = sprintf('%s_12_lh.OuterSurf.mat',subj_name);
    ro_name_12 = sprintf('%s_12_rh.OuterSurf.mat',subj_name);
    
    % Save patch_coord
    load(fullfile(paths.month_patch_12,li_name_12))
    save(fullfile(paths.for_12_patch,li_name_12),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_12,ri_name_12))
    save(fullfile(paths.for_12_patch,ri_name_12),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_12,lo_name_12))
    save(fullfile(paths.for_12_patch,lo_name_12),'patch_coord','-v7.3');
    load(fullfile(paths.month_patch_12,ro_name_12))
    save(fullfile(paths.for_12_patch,ro_name_12),'patch_coord','-v7.3');
    
    % Save all desc (li)
    load(fullfile(paths.month_sur_12,li_name_12))
    coord_li12 = [surface.X, surface.Y, surface.Z];
    desc = [surface.X, surface.Y, surface.Z] - coord_00_li;
    save(fullfile(paths.for_12_desc_coord,li_name_12),'desc','-v7.3');
    save(fullfile(paths.for_12_desc_out_in,li_name_12),'desc','-v7.3');

    desc = [surface.X, surface.Y, surface.Z] - coord_li9;
    save(fullfile(paths.for_12_desc_rel_coord,li_name_12),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_12_desc_curvature,li_name_12),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_12_desc_curvIn,li_name_12),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_12_desc_convexity,li_name_12),'desc','-v7.3');
    desc = surface.thickness - thick_li9;
    save(fullfile(paths.for_12_desc_rel_thick,li_name_12),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_12_desc_thickness,li_name_12),'desc','-v7.3');
    
    % Save all desc (lo)
    load(fullfile(paths.month_sur_12,lo_name_12))
    coord_lo12 = [surface.X, surface.Y, surface.Z];
    desc = [surface.X, surface.Y, surface.Z] - coord_00_lo;
    save(fullfile(paths.for_12_desc_coord,lo_name_12),'desc','-v7.3');
    desc = [surface.X, surface.Y, surface.Z] - coord_lo9;
    save(fullfile(paths.for_12_desc_rel_coord,lo_name_12),'desc','-v7.3');
    
    desc = coord_lo12 - coord_00_li;
    save(fullfile(paths.for_12_desc_out_in,lo_name_12),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_12_desc_curvature,lo_name_12),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_12_desc_curvIn,lo_name_12),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_12_desc_convexity,lo_name_12),'desc','-v7.3');
    desc = surface.thickness - thick_lo9;
    save(fullfile(paths.for_12_desc_rel_thick,lo_name_12),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_12_desc_thickness,lo_name_12),'desc','-v7.3');
    
    % Save all desc (ri)
    load(fullfile(paths.month_sur_12,ri_name_12))
    coord_ri12 = [surface.X, surface.Y, surface.Z];
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ri;
    save(fullfile(paths.for_12_desc_coord,ri_name_12),'desc','-v7.3');
    save(fullfile(paths.for_12_desc_out_in,ri_name_12),'desc','-v7.3');

    desc = [surface.X, surface.Y, surface.Z] - coord_ri9;
    save(fullfile(paths.for_12_desc_rel_coord,ri_name_12),'desc','-v7.3');
    desc = surface.curvature;
    save(fullfile(paths.for_12_desc_curvature,ri_name_12),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_12_desc_curvIn,ri_name_12),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_12_desc_convexity,ri_name_12),'desc','-v7.3');
    desc = surface.thickness - thick_ri9;
    save(fullfile(paths.for_12_desc_rel_thick,ri_name_12),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_12_desc_thickness,ri_name_12),'desc','-v7.3');
    
     % Save all desc (ro)
    load(fullfile(paths.month_sur_12,ro_name_12))
    coord_ro12 = [surface.X, surface.Y, surface.Z];
    desc = [surface.X, surface.Y, surface.Z] - coord_00_ro;
    save(fullfile(paths.for_12_desc_coord,ro_name_12),'desc','-v7.3');
    desc = [surface.X, surface.Y, surface.Z] - coord_ro9;
    save(fullfile(paths.for_12_desc_rel_coord,ro_name_12),'desc','-v7.3');
    
    desc = coord_ro12 - coord_00_ri;
    save(fullfile(paths.for_12_desc_out_in,ro_name_12),'desc','-v7.3');
    
    desc = surface.curvature;
    save(fullfile(paths.for_12_desc_curvature,ro_name_12),'desc','-v7.3');
    desc = surface.curvInflate;
    save(fullfile(paths.for_12_desc_curvIn,ro_name_12),'desc','-v7.3');
    desc = surface.convexity;
    save(fullfile(paths.for_12_desc_convexity,ro_name_12),'desc','-v7.3');
    desc = surface.thickness - thick_ro9;
    save(fullfile(paths.for_12_desc_rel_thick,ro_name_12),'desc','-v7.3');
    desc = surface.thickness;
    save(fullfile(paths.for_12_desc_thickness,ro_name_12),'desc','-v7.3');
    
    % Save flag_12
    load(fullfile(paths.flags_12, li_name_12));
    save(fullfile(paths.for_12_flags, li_name_12),'flag','-v7.3');
    load(fullfile(paths.flags_12, ri_name_12));
    save(fullfile(paths.for_12_flags, ri_name_12),'flag','-v7.3');
    load(fullfile(paths.flags_12, lo_name_12));
    save(fullfile(paths.for_12_flags, lo_name_12),'flag','-v7.3');
    load(fullfile(paths.flags_12, ro_name_12));
    save(fullfile(paths.for_12_flags, ro_name_12),'flag','-v7.3');
end
