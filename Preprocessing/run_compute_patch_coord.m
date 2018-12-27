function run_compute_patch_coord(paths,params)
 
% shape instances
tmp   = dir(fullfile(paths.input,'*.mat'));
names = sort({tmp.name}); clear tmp; % sort the including elements in ascending order
 
% loop over the shape instances
% par
for idx_shape = 1:length(names)
    
    % re-assigning structs variables to avoid parfor errors
    paths_  = paths;
    params_ = params;
    
    % current shape
    name = names{idx_shape}(1:end-4);
    
    if ~params_.flag_recompute
        % avoid unnecessary computations
        if exist(fullfile(paths_.output,[name,'.mat']),'file')
            fprintf('[i] Shape ''%s'' already processed, skipping\n',name);
            continue;
        end
    end
    
    if name(14) == 'S'
       fprintf('[i] We do not process sphere surfaces, skipping\n');
       continue;
    end
    
    if name(14) == 'M'
       fprintf('[i] We do not process middle surfaces, skipping\n');
       continue;
    end
    
    if name(8:9) == '18'   
       fprintf('[i] We do not process 18th month surfaces, skipping\n');
       continue;
    end
    
    if name(8:9) == '24'   
       fprintf('[i] We do not process 24th month surfaces, skipping\n');
       continue;
    end
    
    if name(8:9) == '36'   
       fprintf('[i] We do not process 36th month surfaces, skipping\n');
       continue;
    end
    
    if name(8:9) == '48'   
       fprintf('[i] We do not process 48th month surfaces, skipping\n');
       continue;
    end
    
    if name(8:9) == '60'   
       fprintf('[i] We do not process 60th month surfaces, skipping\n');
       continue;
    end
    
    if name(8:9) == '72'   
       fprintf('[i] We do not process 72nd month surfaces, skipping\n');
       continue;
    end
    
    if name(11) == 'l'   
       fprintf('[i] We do not process left surfaces, skipping\n');
       continue;
    else
        if name(11) == 'r'
            fprintf('Process\n')
        else
            fprintf('Not a surface, skipping\n')
            continue;
        end
    end
    
    % display info
    fprintf('[i] processing shape ''%s'' (%3.0d/%3.0d)... ',name,idx_shape,length(names));
    time_start = tic;
    
    % load current shape
    tmp = load(fullfile(paths_.input,[name,'.mat']));
    shape = tmp.surface;  %tmp.shape
    
    if isfield(params_,'flag_rescale')
        if isfield(params_,'diam')
            if params_.diam == 1
                % rescale shape to unit diameter
                scale_factor = 1/200;
                shape = scale_shape(shape,scale_factor);
                shape.Z = shape.Z + 0.5;
            end
        end
    end
 
    % compute local areas
    [~, A] = calcLB(shape);
    areas_loc = diag(A);
    
    % compute the patches
    [patch_rho,patch_theta] = compute_patch_coord(shape,areas_loc,params);
    patch_coord = [sparse(patch_rho),sparse(patch_theta)];
    
    % saving
    if ~exist(paths_.output,'dir')
        mkdir(paths_.output);
    end
    par_save(fullfile(paths_.output,[name,'.mat']),patch_coord);
    
    % display info
    fprintf('%2.0fs\n',toc(time_start));
    
end
 
end
 
function par_save(path,patch_coord)
save(path,'patch_coord','-v7.3');
end
 
