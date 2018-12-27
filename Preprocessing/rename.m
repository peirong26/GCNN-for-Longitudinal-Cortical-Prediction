% Rename for all month-combinations

clear;
close all;
clc;
 
n_vert = 10242;

% Paths for pre-renamed datasets
paths.main   = '/Users/peirong/Documents/Cycle/TotalData/datasets';
paths.for_00 = fullfile(paths.main,'00');
paths.for_03 = fullfile(paths.main,'03');
paths.for_06 = fullfile(paths.main,'06');
paths.for_09 = fullfile(paths.main,'09');
paths.for_12 = fullfile(paths.main,'12');

paths.for_00_patch          = fullfile(paths.for_00,'patch_coord');
paths.for_00_desc           = fullfile(paths.for_00,'desc');
paths.for_00_desc_coord     = fullfile(paths.for_00_desc,'coord');
paths.for_00_desc_out_in    = fullfile(paths.for_00_desc,'out_in');
paths.for_00_desc_rel_coord = fullfile(paths.for_00_desc,'rel_coord');
paths.for_00_desc_curvature = fullfile(paths.for_00_desc,'curvature');
paths.for_00_desc_curvIn    = fullfile(paths.for_00_desc,'curvInflate');
paths.for_00_desc_convexity = fullfile(paths.for_00_desc,'convexity');
paths.for_00_desc_thickness = fullfile(paths.for_00_desc,'thickness');
paths.for_00_desc_rel_thick = fullfile(paths.for_00_desc,'rel_thick');

paths.for_03_patch          = fullfile(paths.for_03,'patch_coord');
paths.for_03_desc           = fullfile(paths.for_03,'desc');
paths.for_03_desc_coord     = fullfile(paths.for_03_desc,'coord');
paths.for_03_desc_out_in    = fullfile(paths.for_03_desc,'out_in');
paths.for_03_desc_rel_coord = fullfile(paths.for_03_desc,'rel_coord');
paths.for_03_desc_curvature = fullfile(paths.for_03_desc,'curvature');
paths.for_03_desc_curvIn    = fullfile(paths.for_03_desc,'curvInflate');
paths.for_03_desc_convexity = fullfile(paths.for_03_desc,'convexity');
paths.for_03_desc_thickness = fullfile(paths.for_03_desc,'thickness');
paths.for_03_desc_rel_thick = fullfile(paths.for_03_desc,'rel_thick');
paths.for_03_flags          = fullfile(paths.for_03,'flags');

paths.for_06_patch          = fullfile(paths.for_06,'patch_coord');
paths.for_06_desc           = fullfile(paths.for_06,'desc');
paths.for_06_desc_coord     = fullfile(paths.for_06_desc,'coord');
paths.for_06_desc_out_in    = fullfile(paths.for_06_desc,'out_in');
paths.for_06_desc_rel_coord = fullfile(paths.for_06_desc,'rel_coord');
paths.for_06_desc_curvIn    = fullfile(paths.for_06_desc,'curvInflate');
paths.for_06_desc_convexity = fullfile(paths.for_06_desc,'convexity');
paths.for_06_desc_curvature = fullfile(paths.for_06_desc,'curvature');
paths.for_06_desc_thickness = fullfile(paths.for_06_desc,'thickness');
paths.for_06_desc_rel_thick = fullfile(paths.for_06_desc,'rel_thick');
paths.for_06_flags          = fullfile(paths.for_06,'flags');

paths.for_09_patch          = fullfile(paths.for_09,'patch_coord');
paths.for_09_desc           = fullfile(paths.for_09,'desc');
paths.for_09_desc_coord     = fullfile(paths.for_09_desc,'coord');
paths.for_09_desc_out_in    = fullfile(paths.for_09_desc,'out_in');
paths.for_09_desc_rel_coord = fullfile(paths.for_09_desc,'rel_coord');
paths.for_09_desc_curvature = fullfile(paths.for_09_desc,'curvature');
paths.for_09_desc_curvIn    = fullfile(paths.for_09_desc,'curvInflate');
paths.for_09_desc_convexity = fullfile(paths.for_09_desc,'convexity');
paths.for_09_desc_thickness = fullfile(paths.for_09_desc,'thickness');
paths.for_09_desc_rel_thick = fullfile(paths.for_09_desc,'rel_thick');
paths.for_09_flags          = fullfile(paths.for_09,'flags');

paths.for_12_patch          = fullfile(paths.for_12,'patch_coord');
paths.for_12_desc           = fullfile(paths.for_12,'desc');
paths.for_12_desc_coord     = fullfile(paths.for_12_desc,'coord');
paths.for_12_desc_out_in    = fullfile(paths.for_12_desc,'out_in');
paths.for_12_desc_rel_coord = fullfile(paths.for_12_desc,'rel_coord');
paths.for_12_desc_curvature = fullfile(paths.for_12_desc,'curvature');
paths.for_12_desc_curvIn    = fullfile(paths.for_12_desc,'curvInflate');
paths.for_12_desc_convexity = fullfile(paths.for_12_desc,'convexity');
paths.for_12_desc_thickness = fullfile(paths.for_12_desc,'thickness');
paths.for_12_desc_rel_thick = fullfile(paths.for_12_desc,'rel_thick');
paths.for_12_flags          = fullfile(paths.for_12,'flags');


% Paths for renamed datasets
paths.main_re   = '/Users/peirong/Documents/Cycle/TotalData/renamed';
paths.for_00_re = fullfile(paths.main_re,'00');
paths.for_03_re = fullfile(paths.main_re,'03');
paths.for_06_re = fullfile(paths.main_re,'06');
paths.for_09_re = fullfile(paths.main_re,'09');
paths.for_12_re = fullfile(paths.main_re,'12');

paths.for_00_patch_re          = fullfile(paths.for_00_re,'patch_coord');
paths.for_00_desc_re           = fullfile(paths.for_00_re,'desc');
paths.for_00_desc_coord_re     = fullfile(paths.for_00_desc_re,'coord');
paths.for_00_desc_out_in_re    = fullfile(paths.for_00_desc_re,'out_in');
paths.for_00_desc_rel_coord_re = fullfile(paths.for_00_desc_re,'rel_coord');
paths.for_00_desc_curvature_re = fullfile(paths.for_00_desc_re,'curvature');
paths.for_00_desc_curvIn_re    = fullfile(paths.for_00_desc_re,'curvInflate');
paths.for_00_desc_convexity_re = fullfile(paths.for_00_desc_re,'convexity');
paths.for_00_desc_thickness_re = fullfile(paths.for_00_desc_re,'thickness');
paths.for_00_desc_rel_thick_re = fullfile(paths.for_00_desc_re,'rel_thick');

paths.for_03_patch_re          = fullfile(paths.for_03_re,'patch_coord');
paths.for_03_desc_re           = fullfile(paths.for_03_re,'desc');
paths.for_03_desc_coord_re     = fullfile(paths.for_03_desc_re,'coord');
paths.for_03_desc_out_in_re    = fullfile(paths.for_03_desc_re,'out_in');
paths.for_03_desc_rel_coord_re = fullfile(paths.for_03_desc_re,'rel_coord');
paths.for_03_desc_curvature_re = fullfile(paths.for_03_desc_re,'curvature');
paths.for_03_desc_curvIn_re    = fullfile(paths.for_03_desc_re,'curvInflate');
paths.for_03_desc_convexity_re = fullfile(paths.for_03_desc_re,'convexity');
paths.for_03_desc_thickness_re = fullfile(paths.for_03_desc_re,'thickness');
paths.for_03_desc_rel_thick_re = fullfile(paths.for_03_desc_re,'rel_thick');
paths.for_03_flags_re          = fullfile(paths.for_03_re,'flags');

paths.for_06_patch_re          = fullfile(paths.for_06_re,'patch_coord');
paths.for_06_desc_re           = fullfile(paths.for_06_re,'desc');
paths.for_06_desc_coord_re     = fullfile(paths.for_06_desc_re,'coord');
paths.for_06_desc_out_in_re    = fullfile(paths.for_06_desc_re,'out_in');
paths.for_06_desc_rel_coord_re = fullfile(paths.for_06_desc_re,'rel_coord');
paths.for_06_desc_curvature_re = fullfile(paths.for_06_desc_re,'curvature');
paths.for_06_desc_curvIn_re    = fullfile(paths.for_06_desc_re,'curvInflate');
paths.for_06_desc_convexity_re = fullfile(paths.for_06_desc_re,'convexity');
paths.for_06_desc_thickness_re = fullfile(paths.for_06_desc_re,'thickness');
paths.for_06_desc_rel_thick_re = fullfile(paths.for_06_desc_re,'rel_thick');
paths.for_06_flags_re          = fullfile(paths.for_06_re,'flags');

paths.for_09_patch_re          = fullfile(paths.for_09_re,'patch_coord');
paths.for_09_desc_re           = fullfile(paths.for_09_re,'desc');
paths.for_09_desc_coord_re     = fullfile(paths.for_09_desc_re,'coord');
paths.for_09_desc_out_in_re    = fullfile(paths.for_09_desc_re,'out_in');
paths.for_09_desc_rel_coord_re = fullfile(paths.for_09_desc_re,'rel_coord');
paths.for_09_desc_curvature_re = fullfile(paths.for_09_desc_re,'curvature');
paths.for_09_desc_curvIn_re    = fullfile(paths.for_09_desc_re,'curvInflate');
paths.for_09_desc_convexity_re = fullfile(paths.for_09_desc_re,'convexity');
paths.for_09_desc_thickness_re = fullfile(paths.for_09_desc_re,'thickness');
paths.for_09_desc_rel_thick_re = fullfile(paths.for_09_desc_re,'rel_thick');
paths.for_09_flags_re          = fullfile(paths.for_09_re,'flags');

paths.for_12_patch_re          = fullfile(paths.for_12_re,'patch_coord');
paths.for_12_desc_re           = fullfile(paths.for_12_re,'desc');
paths.for_12_desc_coord_re     = fullfile(paths.for_12_desc_re,'coord');
paths.for_12_desc_out_in_re    = fullfile(paths.for_12_desc_re,'out_in');
paths.for_12_desc_rel_coord_re = fullfile(paths.for_12_desc_re,'rel_coord');
paths.for_12_desc_curvature_re = fullfile(paths.for_12_desc_re,'curvature');
paths.for_12_desc_curvIn_re    = fullfile(paths.for_12_desc_re,'curvInflate');
paths.for_12_desc_convexity_re = fullfile(paths.for_12_desc_re,'convexity');
paths.for_12_desc_thickness_re = fullfile(paths.for_12_desc_re,'thickness');
paths.for_12_desc_rel_thick_re = fullfile(paths.for_12_desc_re,'rel_thick');
paths.for_12_flags_re          = fullfile(paths.for_12_re,'flags');


% Write 00 left inner surface in order
folders_for_00_patch = dir(fullfile(paths.for_00_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_00_patch)
    
    old_name = folders_for_00_patch(i).name;
    
    if (old_name(11) == 'r' || old_name(14) == 'O') 
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    % Write down old-new name correspondence for later references
    fprintf('%s -> %s.\n', old_name, new_name);
    
    
    load(fullfile(paths.for_00_patch, old_name));
    save(fullfile(paths.for_00_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_00_desc_coord, old_name));
    save(fullfile(paths.for_00_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_out_in, old_name));
    save(fullfile(paths.for_00_desc_out_in_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_rel_coord, old_name));
    save(fullfile(paths.for_00_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvature, old_name));
    save(fullfile(paths.for_00_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvIn, old_name));
    save(fullfile(paths.for_00_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_convexity, old_name));
    save(fullfile(paths.for_00_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_thickness, old_name));
    save(fullfile(paths.for_00_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_rel_thick, old_name));
    save(fullfile(paths.for_00_desc_rel_thick_re,new_name),'desc','-v7.3');
    
end

% Write 00 left outer surface in order
folders_for_00_patch = dir(fullfile(paths.for_00_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_00_patch)
    
    old_name = folders_for_00_patch(i).name;
    
    if (old_name(11) == 'r' || old_name(14) == 'I') 
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    % Write down old-new name correspondence for later references
    fprintf('%s -> %s.\n', old_name, new_name);
    
    
    load(fullfile(paths.for_00_patch, old_name));
    save(fullfile(paths.for_00_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_00_desc_coord, old_name));
    save(fullfile(paths.for_00_desc_coord_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_00_desc_out_in, old_name));
    save(fullfile(paths.for_00_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_00_desc_rel_coord, old_name));
    save(fullfile(paths.for_00_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvature, old_name));
    save(fullfile(paths.for_00_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvIn, old_name));
    save(fullfile(paths.for_00_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_convexity, old_name));
    save(fullfile(paths.for_00_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_thickness, old_name));
    save(fullfile(paths.for_00_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_rel_thick, old_name));
    save(fullfile(paths.for_00_desc_rel_thick_re,new_name),'desc','-v7.3');
    
end

% Write 03 left inner surface in order
folders_for_03_patch = dir(fullfile(paths.for_03_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_03_patch)
    
    old_name = folders_for_03_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_03_patch, old_name));
    save(fullfile(paths.for_03_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_03_desc_coord, old_name));
    save(fullfile(paths.for_03_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_out_in, old_name));
    save(fullfile(paths.for_03_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_03_desc_rel_coord, old_name));
    save(fullfile(paths.for_03_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvature, old_name));
    save(fullfile(paths.for_03_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvIn, old_name));
    save(fullfile(paths.for_03_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_convexity, old_name));
    save(fullfile(paths.for_03_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_thickness, old_name));
    save(fullfile(paths.for_03_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_rel_thick, old_name));
    save(fullfile(paths.for_03_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_flags, old_name));
    save(fullfile(paths.for_03_flags_re,new_name),'flag','-v7.3');
end

% Write 03 left outer surface in order
idx = 0;
for i = 1:length(folders_for_03_patch)
    
    old_name = folders_for_03_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_03_patch, old_name));
    save(fullfile(paths.for_03_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_03_desc_coord, old_name));
    save(fullfile(paths.for_03_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_out_in, old_name));
    save(fullfile(paths.for_03_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_03_desc_rel_coord, old_name));
    save(fullfile(paths.for_03_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvature, old_name));
    save(fullfile(paths.for_03_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvIn, old_name));
    save(fullfile(paths.for_03_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_convexity, old_name));
    save(fullfile(paths.for_03_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_thickness, old_name));
    save(fullfile(paths.for_03_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_rel_thick, old_name));
    save(fullfile(paths.for_03_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_flags, old_name));
    save(fullfile(paths.for_03_flags_re,new_name),'flag','-v7.3');
end

% Write 06 left inner surface in order
folders_for_06_patch = dir(fullfile(paths.for_06_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_06_patch)
    
    old_name = folders_for_06_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_06_patch, old_name));
    save(fullfile(paths.for_06_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_06_desc_coord, old_name));
    save(fullfile(paths.for_06_desc_coord_re,new_name),'desc','-v7.3'); 
    
    load(fullfile(paths.for_06_desc_out_in, old_name));
    save(fullfile(paths.for_06_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_06_desc_rel_coord, old_name));
    save(fullfile(paths.for_06_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvature, old_name));
    save(fullfile(paths.for_06_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvIn, old_name));
    save(fullfile(paths.for_06_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_convexity, old_name));
    save(fullfile(paths.for_06_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_thickness, old_name));
    save(fullfile(paths.for_06_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_rel_thick, old_name));
    save(fullfile(paths.for_06_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_flags, old_name));
    save(fullfile(paths.for_06_flags_re,new_name),'flag','-v7.3');
end

% Write 06 left outer surface in order
idx = 0;
for i = 1:length(folders_for_06_patch)
    
    old_name = folders_for_06_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_06_patch, old_name));
    save(fullfile(paths.for_06_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_06_desc_coord, old_name));
    save(fullfile(paths.for_06_desc_coord_re,new_name),'desc','-v7.3'); 
    
    load(fullfile(paths.for_06_desc_out_in, old_name));
    save(fullfile(paths.for_06_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_06_desc_rel_coord, old_name));
    save(fullfile(paths.for_06_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvature, old_name));
    save(fullfile(paths.for_06_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvIn, old_name));
    save(fullfile(paths.for_06_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_convexity, old_name));
    save(fullfile(paths.for_06_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_thickness, old_name));
    save(fullfile(paths.for_06_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_rel_thick, old_name));
    save(fullfile(paths.for_06_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_flags, old_name));
    save(fullfile(paths.for_06_flags_re,new_name),'flag','-v7.3');
end

% Write 09 left inner surface in order
folders_for_09_patch = dir(fullfile(paths.for_09_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_09_patch)
    
    old_name = folders_for_09_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_09_patch, old_name));
    save(fullfile(paths.for_09_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_09_desc_coord, old_name));
    save(fullfile(paths.for_09_desc_coord_re,new_name),'desc','-v7.3');    
    
    load(fullfile(paths.for_09_desc_out_in, old_name));
    save(fullfile(paths.for_09_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_09_desc_rel_coord, old_name));
    save(fullfile(paths.for_09_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvature, old_name));
    save(fullfile(paths.for_09_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvIn, old_name));
    save(fullfile(paths.for_09_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_convexity, old_name));
    save(fullfile(paths.for_09_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_thickness, old_name));
    save(fullfile(paths.for_09_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_rel_thick, old_name));
    save(fullfile(paths.for_09_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_flags, old_name));
    save(fullfile(paths.for_09_flags_re,new_name),'flag','-v7.3');
end

% Write 09 left outer surface in order
idx = 0;
for i = 1:length(folders_for_09_patch)
    
    old_name = folders_for_09_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_09_patch, old_name));
    save(fullfile(paths.for_09_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_09_desc_coord, old_name));
    save(fullfile(paths.for_09_desc_coord_re,new_name),'desc','-v7.3');    

    load(fullfile(paths.for_09_desc_out_in, old_name));
    save(fullfile(paths.for_09_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_09_desc_rel_coord, old_name));
    save(fullfile(paths.for_09_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvature, old_name));
    save(fullfile(paths.for_09_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvIn, old_name));
    save(fullfile(paths.for_09_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_convexity, old_name));
    save(fullfile(paths.for_09_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_thickness, old_name));
    save(fullfile(paths.for_09_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_rel_thick, old_name));
    save(fullfile(paths.for_09_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_flags, old_name));
    save(fullfile(paths.for_09_flags_re,new_name),'flag','-v7.3');
end

% Write 12 left inner surface in order
folders_for_12_patch = dir(fullfile(paths.for_12_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_12_patch)
    
    old_name = folders_for_12_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_12_patch, old_name));
    save(fullfile(paths.for_12_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_12_desc_coord, old_name));
    save(fullfile(paths.for_12_desc_coord_re,new_name),'desc','-v7.3');  

    load(fullfile(paths.for_12_desc_out_in, old_name));
    save(fullfile(paths.for_12_desc_out_in_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_rel_coord, old_name));
    save(fullfile(paths.for_12_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvature, old_name));
    save(fullfile(paths.for_12_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvIn, old_name));
    save(fullfile(paths.for_12_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_convexity, old_name));
    save(fullfile(paths.for_12_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_thickness, old_name));
    save(fullfile(paths.for_12_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_rel_thick, old_name));
    save(fullfile(paths.for_12_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_flags, old_name));
    save(fullfile(paths.for_12_flags_re,new_name),'flag','-v7.3');
end

% Write 12 left outer surface in order
idx = 0;
for i = 1:length(folders_for_12_patch)
    
    old_name = folders_for_12_patch(i).name;
    if (old_name(11) == 'r' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_12_patch, old_name));
    save(fullfile(paths.for_12_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_12_desc_coord, old_name));
    save(fullfile(paths.for_12_desc_coord_re,new_name),'desc','-v7.3');  
    
    load(fullfile(paths.for_12_desc_out_in, old_name));
    save(fullfile(paths.for_12_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_12_desc_rel_coord, old_name));
    save(fullfile(paths.for_12_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvature, old_name));
    save(fullfile(paths.for_12_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvIn, old_name));
    save(fullfile(paths.for_12_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_convexity, old_name));
    save(fullfile(paths.for_12_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_thickness, old_name));
    save(fullfile(paths.for_12_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_rel_thick, old_name));
    save(fullfile(paths.for_12_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_flags, old_name));
    save(fullfile(paths.for_12_flags_re,new_name),'flag','-v7.3');
end

fprintf('------------Border for left & right------------\n');

% Write 00 right inner surface in order
folders_for_00_patch = dir(fullfile(paths.for_00_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_00_patch)
    
    old_name = folders_for_00_patch(i).name;
    
    if (old_name(11) == 'l' || old_name(14) == 'O') 
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    % Write down old-new name correspondence for later references
    fprintf('%s -> %s.\n', old_name, new_name);
    
    
    load(fullfile(paths.for_00_patch, old_name));
    save(fullfile(paths.for_00_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_00_desc_coord, old_name));
    save(fullfile(paths.for_00_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_out_in, old_name));
    save(fullfile(paths.for_00_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_00_desc_rel_coord, old_name));
    save(fullfile(paths.for_00_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvature, old_name));
    save(fullfile(paths.for_00_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvIn, old_name));
    save(fullfile(paths.for_00_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_convexity, old_name));
    save(fullfile(paths.for_00_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_thickness, old_name));
    save(fullfile(paths.for_00_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_rel_thick, old_name));
    save(fullfile(paths.for_00_desc_rel_thick_re,new_name),'desc','-v7.3');
    
end

% Write 00 right outer surface in order
folders_for_00_patch = dir(fullfile(paths.for_00_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_00_patch)
    
    old_name = folders_for_00_patch(i).name;
    
    if (old_name(11) == 'l' || old_name(14) == 'I') 
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    % Write down old-new name correspondence for later references
    fprintf('%s -> %s.\n', old_name, new_name);
    
    
    load(fullfile(paths.for_00_patch, old_name));
    save(fullfile(paths.for_00_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_00_desc_coord, old_name));
    save(fullfile(paths.for_00_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_out_in, old_name));
    save(fullfile(paths.for_00_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_00_desc_rel_coord, old_name));
    save(fullfile(paths.for_00_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvature, old_name));
    save(fullfile(paths.for_00_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_curvIn, old_name));
    save(fullfile(paths.for_00_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_convexity, old_name));
    save(fullfile(paths.for_00_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_thickness, old_name));
    save(fullfile(paths.for_00_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_00_desc_rel_thick, old_name));
    save(fullfile(paths.for_00_desc_rel_thick_re,new_name),'desc','-v7.3');
    
end

% Write 03 right inner surface in order
folders_for_03_patch = dir(fullfile(paths.for_03_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_03_patch)
    
    old_name = folders_for_03_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_03_patch, old_name));
    save(fullfile(paths.for_03_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_03_desc_coord, old_name));
    save(fullfile(paths.for_03_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_out_in, old_name));
    save(fullfile(paths.for_03_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_03_desc_rel_coord, old_name));
    save(fullfile(paths.for_03_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvature, old_name));
    save(fullfile(paths.for_03_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvIn, old_name));
    save(fullfile(paths.for_03_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_convexity, old_name));
    save(fullfile(paths.for_03_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_thickness, old_name));
    save(fullfile(paths.for_03_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_rel_thick, old_name));
    save(fullfile(paths.for_03_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_flags, old_name));
    save(fullfile(paths.for_03_flags_re,new_name),'flag','-v7.3');
end

% Write 03 right outer surface in order
idx = 0;
for i = 1:length(folders_for_03_patch)
    
    old_name = folders_for_03_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_03_patch, old_name));
    save(fullfile(paths.for_03_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_03_desc_coord, old_name));
    save(fullfile(paths.for_03_desc_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_out_in, old_name));
    save(fullfile(paths.for_03_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_03_desc_rel_coord, old_name));
    save(fullfile(paths.for_03_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvature, old_name));
    save(fullfile(paths.for_03_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_curvIn, old_name));
    save(fullfile(paths.for_03_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_convexity, old_name));
    save(fullfile(paths.for_03_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_thickness, old_name));
    save(fullfile(paths.for_03_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_desc_rel_thick, old_name));
    save(fullfile(paths.for_03_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_03_flags, old_name));
    save(fullfile(paths.for_03_flags_re,new_name),'flag','-v7.3');
end

% Write 06 right inner surface in order
folders_for_06_patch = dir(fullfile(paths.for_06_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_06_patch)
    
    old_name = folders_for_06_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_06_patch, old_name));
    save(fullfile(paths.for_06_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_06_desc_coord, old_name));
    save(fullfile(paths.for_06_desc_coord_re,new_name),'desc','-v7.3'); 
    
    load(fullfile(paths.for_06_desc_out_in, old_name));
    save(fullfile(paths.for_06_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_06_desc_rel_coord, old_name));
    save(fullfile(paths.for_06_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvature, old_name));
    save(fullfile(paths.for_06_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvIn, old_name));
    save(fullfile(paths.for_06_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_convexity, old_name));
    save(fullfile(paths.for_06_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_thickness, old_name));
    save(fullfile(paths.for_06_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_rel_thick, old_name));
    save(fullfile(paths.for_06_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_flags, old_name));
    save(fullfile(paths.for_06_flags_re,new_name),'flag','-v7.3');
end

% Write 06 right outer surface in order
idx = 0;
for i = 1:length(folders_for_06_patch)
    
    old_name = folders_for_06_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_06_patch, old_name));
    save(fullfile(paths.for_06_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_06_desc_coord, old_name));
    save(fullfile(paths.for_06_desc_coord_re,new_name),'desc','-v7.3'); 
    
    load(fullfile(paths.for_06_desc_out_in, old_name));
    save(fullfile(paths.for_06_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_06_desc_rel_coord, old_name));
    save(fullfile(paths.for_06_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvature, old_name));
    save(fullfile(paths.for_06_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_curvIn, old_name));
    save(fullfile(paths.for_06_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_convexity, old_name));
    save(fullfile(paths.for_06_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_thickness, old_name));
    save(fullfile(paths.for_06_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_desc_rel_thick, old_name));
    save(fullfile(paths.for_06_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_06_flags, old_name));
    save(fullfile(paths.for_06_flags_re,new_name),'flag','-v7.3');
end

% Write 09 right inner surface in order
folders_for_09_patch = dir(fullfile(paths.for_09_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_09_patch)
    
    old_name = folders_for_09_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_09_patch, old_name));
    save(fullfile(paths.for_09_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_09_desc_coord, old_name));
    save(fullfile(paths.for_09_desc_coord_re,new_name),'desc','-v7.3');    
    
    load(fullfile(paths.for_09_desc_out_in, old_name));
    save(fullfile(paths.for_09_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_09_desc_rel_coord, old_name));
    save(fullfile(paths.for_09_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvature, old_name));
    save(fullfile(paths.for_09_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvIn, old_name));
    save(fullfile(paths.for_09_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_convexity, old_name));
    save(fullfile(paths.for_09_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_thickness, old_name));
    save(fullfile(paths.for_09_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_rel_thick, old_name));
    save(fullfile(paths.for_09_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_flags, old_name));
    save(fullfile(paths.for_09_flags_re,new_name),'flag','-v7.3');
end

% Write 09 right outer surface in order
idx = 0;
for i = 1:length(folders_for_09_patch)
    
    old_name = folders_for_09_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_09_patch, old_name));
    save(fullfile(paths.for_09_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_09_desc_coord, old_name));
    save(fullfile(paths.for_09_desc_coord_re,new_name),'desc','-v7.3');    
    
    load(fullfile(paths.for_09_desc_out_in, old_name));
    save(fullfile(paths.for_09_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_09_desc_rel_coord, old_name));
    save(fullfile(paths.for_09_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvature, old_name));
    save(fullfile(paths.for_09_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_curvIn, old_name));
    save(fullfile(paths.for_09_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_convexity, old_name));
    save(fullfile(paths.for_09_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_thickness, old_name));
    save(fullfile(paths.for_09_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_desc_rel_thick, old_name));
    save(fullfile(paths.for_09_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_09_flags, old_name));
    save(fullfile(paths.for_09_flags_re,new_name),'flag','-v7.3');
end

% Write 12 right inner surface in order
folders_for_12_patch = dir(fullfile(paths.for_12_patch,'*.mat'));
idx = 0;
for i = 1:length(folders_for_12_patch)
    
    old_name = folders_for_12_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'O')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_12_patch, old_name));
    save(fullfile(paths.for_12_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_12_desc_coord, old_name));
    save(fullfile(paths.for_12_desc_coord_re,new_name),'desc','-v7.3');  
    
    load(fullfile(paths.for_12_desc_out_in, old_name));
    save(fullfile(paths.for_12_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_12_desc_rel_coord, old_name));
    save(fullfile(paths.for_12_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvature, old_name));
    save(fullfile(paths.for_12_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvIn, old_name));
    save(fullfile(paths.for_12_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_convexity, old_name));
    save(fullfile(paths.for_12_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_thickness, old_name));
    save(fullfile(paths.for_12_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_rel_thick, old_name));
    save(fullfile(paths.for_12_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_flags, old_name));
    save(fullfile(paths.for_12_flags_re,new_name),'flag','-v7.3');
end

% Write 12 right outer surface in order
idx = 0;
for i = 1:length(folders_for_12_patch)
    
    old_name = folders_for_12_patch(i).name;
    if (old_name(11) == 'l' || old_name(14) == 'I')
        continue;
    end
    
    keep = old_name(11:26);
    new_name = sprintf('M%.3d_%s',idx,keep);
    idx = idx + 1;
    
    load(fullfile(paths.for_12_patch, old_name));
    save(fullfile(paths.for_12_patch_re,new_name),'patch_coord','-v7.3');
    
    load(fullfile(paths.for_12_desc_coord, old_name));
    save(fullfile(paths.for_12_desc_coord_re,new_name),'desc','-v7.3');  
    
    load(fullfile(paths.for_12_desc_out_in, old_name));
    save(fullfile(paths.for_12_desc_out_in_re,new_name),'desc','-v7.3');

    load(fullfile(paths.for_12_desc_rel_coord, old_name));
    save(fullfile(paths.for_12_desc_rel_coord_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvature, old_name));
    save(fullfile(paths.for_12_desc_curvature_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_curvIn, old_name));
    save(fullfile(paths.for_12_desc_curvIn_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_convexity, old_name));
    save(fullfile(paths.for_12_desc_convexity_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_thickness, old_name));
    save(fullfile(paths.for_12_desc_thickness_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_desc_rel_thick, old_name));
    save(fullfile(paths.for_12_desc_rel_thick_re,new_name),'desc','-v7.3');
    
    load(fullfile(paths.for_12_flags, old_name));
    save(fullfile(paths.for_12_flags_re,new_name),'flag','-v7.3');
end