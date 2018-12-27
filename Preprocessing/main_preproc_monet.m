clear;
close all;
clc;
 
params.flag_recompute = 0;
params.perc                = 5;
params.curvature_smoothing = 10;
params.flag_adaptive       = 0;
params.flag_rescale        = 1;
params.diam                = 1;
 
paths.subjects = '/Volumes/PEIRONG/Entire_Datasets_10242';
paths.output_raw = '/Volumes/PEIRONG/Patch_Coord_All';
 
all_subjects = dir(fullfile(paths.subjects));

    
for n_subjects = 46:length(all_subjects)
    
    subj_name = all_subjects(n_subjects).name;
    paths.subject = fullfile(paths.subjects,subj_name);
    months_all = dir(fullfile(paths.subject));
    
    paths.subject_out = fullfile(paths.output_raw,subj_name);
    if ~exist(paths.subject_out,'dir')
        mkdir(paths.subject_out);
    end
    
    for i_month = 1:length(months_all)
        month = months_all(i_month).name;
        if month(1) == '0'
            break;
        end
    end
            
    for n_month = i_month:length(months_all)
        
        month = months_all(n_month).name;
        paths.input = fullfile(paths.subject, month);
        paths.output = fullfile(paths.subject_out, month);
        
        if ~exist(paths.output,'dir')
            mkdir(paths.output);
        end
 
        run_compute_patch_coord(paths,params);
        
    end 
end