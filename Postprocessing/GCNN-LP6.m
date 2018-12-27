clear 
%load(pred_li, pred_lo, pred_ri, pred_ro) results
load('/Users/peirong/Documents/Cycle/036/dumps/mat/06/out_in/test_batch_dim=60/ep=1200_for_M016_lh.InnerSurf.mat');
pred_li = pred_6;
load('/Users/peirong/Documents/Cycle/036/dumps/mat/06/out_in/test_batch_dim=60/ep=1200_for_M016_lh.OuterSurf.mat');
pred_lo = pred_3; % typo in python code
load('/Users/peirong/Documents/Cycle/036/dumps/mat/06/out_in/test_batch_dim=60/ep=1200_for_M016_rh.InnerSurf.mat');
pred_ri = pred_6;
load('/Users/peirong/Documents/Cycle/036/dumps/mat/06/out_in/test_batch_dim=60/ep=1200_for_M016_rh.OuterSurf.mat');
pred_ro = pred_3; % typo in python code

% path for writing vtk results
path_write_vtk = '/Users/peirong/Documents/Cycle/036/Results/06';

path_gt_li = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/06/M086-1_06_lh.InnerSurf.mat';
load(path_gt_li);
gt_li = surface;
path_gt_lo = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/06/M086-1_06_lh.OuterSurf.mat';
load(path_gt_lo);
gt_lo = surface;
path_gt_ri = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/06/M086-1_06_rh.InnerSurf.mat';
load(path_gt_ri);
gt_ri = surface;
path_gt_ro = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/06/M086-1_06_rh.OuterSurf.mat';
load(path_gt_ro);
gt_ro = surface;

% path for reference: 3 month
path_gt_li_3 = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_lh.InnerSurf.mat';
load(path_gt_li_3);
gt_li_3 = surface;
path_gt_lo_3 = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_lh.OuterSurf.mat';
load(path_gt_lo_3);
gt_lo_3 = surface;
path_gt_ri_3 = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_rh.InnerSurf.mat';
load(path_gt_ri_3);
gt_ri_3 = surface;
path_gt_ro_3 = '/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_rh.OuterSurf.mat';
load(path_gt_ro_3);
gt_ro_3 = surface;

GT_Lh_Inner.vertices = [gt_li.X,gt_li.Y,gt_li.Z];
GT_Lh_Outer.vertices = [gt_lo.X,gt_lo.Y,gt_lo.Z];
GT_Rh_Inner.vertices = [gt_ri.X,gt_ri.Y,gt_ri.Z];
GT_Rh_Outer.vertices = [gt_ro.X,gt_ro.Y,gt_ro.Z];

Lh_Inner.faces = gt_li.TRIV;
Lh_Outer.faces = gt_lo.TRIV;
Rh_Inner.faces = gt_ri.TRIV;
Rh_Outer.faces = gt_ro.TRIV;

Lh_Inner.vertices = [gt_li.X,gt_li.Y,gt_li.Z];
Lh_Outer.vertices = [gt_lo.X,gt_lo.Y,gt_lo.Z];
Rh_Inner.vertices = [gt_ri.X,gt_ri.Y,gt_ri.Z];
Rh_Outer.vertices = [gt_ro.X,gt_ro.Y,gt_ro.Z];


n_vert = 10242;

thick_l = pred_lo - pred_li;
thick_r = pred_ro - pred_ri;
thickness_l = zeros(n_vert,1);
thickness_r = zeros(n_vert,1);
for n = 1:10242
    thickness_l(n,1) = norm(thick_l(n,:));
    thickness_r(n,1) = norm(thick_r(n,:));
end

tmp_l = abs(thickness_l - gt_li.thickness);
tmp_r = abs(thickness_r - gt_ri.thickness);
Lh_Inner.Thickness_Error = sqrt(tmp_l) - mean(tmp_l);
Lh_Outer.Thickness_Error = sqrt(tmp_l) - mean(tmp_l);
Rh_Inner.Thickness_Error = sqrt(tmp_r) - mean(tmp_r);
Rh_Outer.Thickness_Error = sqrt(tmp_r) - mean(tmp_r);
Lh_Inner.Thickness_Absolute_Error = abs(Lh_Inner.Thickness_Error);
Lh_Outer.Thickness_Absolute_Error = abs(Lh_Outer.Thickness_Error);
Rh_Inner.Thickness_Absolute_Error = abs(Rh_Inner.Thickness_Error);
Rh_Outer.Thickness_Absolute_Error = abs(Rh_Outer.Thickness_Error);


%fprintf('Mean Left  Thickness Absolute Error = %.4f; Median Left  Thickness Absolute Error = %.4f; Left  Thickness MRE = %.4f%%. \n', mean(Lh_Inner.Thickness_Absolute_Error), median(Lh_Inner.Thickness_Absolute_Error), 100*mean(Lh_Inner.Thickness_Absolute_Error)/mean(gt_li.thickness));
%fprintf('Mean Right Thickness Absolute Error = %.4f; Median Right Thickness Absolute Error = %.4f; Right Thickness MRE = %.4f%%. \n', mean(Rh_Inner.Thickness_Absolute_Error), median(Rh_Inner.Thickness_Absolute_Error), 100*mean(Rh_Inner.Thickness_Absolute_Error)/mean(gt_ri.thickness));
%fprintf('Mean Thickness Absolute Error = %.4f; Thickness MRE = %.4f%%. \n', 0.5*(mean(Lh_Inner.Thickness_Absolute_Error) + mean(Rh_Inner.Thickness_Absolute_Error)), 50*(mean(Rh_Inner.Thickness_Absolute_Error)/mean(gt_ri.thickness) + mean(Rh_Inner.Thickness_Absolute_Error)/mean(gt_ri.thickness)));
fprintf('Median Thickness Absolute Error = %.4f; Thickness MeRE = %.4f%%. \n', 0.5*(median(Lh_Inner.Thickness_Absolute_Error) + median(Rh_Inner.Thickness_Absolute_Error)), 50*(median(Rh_Inner.Thickness_Absolute_Error)/median(gt_ri.thickness) + median(Rh_Inner.Thickness_Absolute_Error)/median(gt_ri.thickness)));

tmp_li = pred_li - ([gt_li.X,gt_li.Y,gt_li.Z] - [gt_li_3.X,gt_li_3.Y,gt_li_3.Z]);
tmp_lo = pred_lo - ([gt_lo.X,gt_lo.Y,gt_lo.Z] - [gt_lo_3.X,gt_lo_3.Y,gt_lo_3.Z]);
tmp_ri = pred_ri - ([gt_ri.X,gt_ri.Y,gt_ri.Z] - [gt_ri_3.X,gt_ri_3.Y,gt_ri_3.Z]);
tmp_ro = pred_ro - ([gt_ro.X,gt_ro.Y,gt_ro.Z] - [gt_ro_3.X,gt_ro_3.Y,gt_ro_3.Z]);

err_li = zeros(n_vert,1);
err_lo = zeros(n_vert,1);
err_ri = zeros(n_vert,1);
err_ro = zeros(n_vert,1);

for n = 1:n_vert
    
    err_li(n,1) = min(abs(tmp_li(n,:)));
    err_lo(n,1) = min(abs(tmp_lo(n,:)));
    err_ri(n,1) = min(abs(tmp_ri(n,:)));
    err_ro(n,1) = min(abs(tmp_ro(n,:)));
    
end

err_li = abs(err_li - mean(abs(err_li)));
err_lo = abs(err_lo - mean(abs(err_lo)));
err_ri = abs(err_ri - mean(abs(err_ri)));
err_ro = abs(err_ro - mean(abs(err_ro)));


Lh_Inner.Surface_Euclidean_Error = err_li;
Lh_Outer.Surface_Euclidean_Error = err_lo;
Rh_Inner.Surface_Euclidean_Error = err_ri;
Rh_Outer.Surface_Euclidean_Error = err_ro;


Ed_li = zeros(n_vert,1);
Ed_lo = zeros(n_vert,1);
Ed_ri = zeros(n_vert,1);
Ed_ro = zeros(n_vert,1);

for n = 1:n_vert
    Ed_li(n,1) = norm(GT_Lh_Inner.vertices(n,:));
    Ed_lo(n,1) = norm(GT_Lh_Outer.vertices(n,:));
    Ed_ri(n,1) = norm(GT_Rh_Inner.vertices(n,:));
    Ed_ro(n,1) = norm(GT_Rh_Outer.vertices(n,:));
end

mean_Ed_li = mean(Ed_li);
mean_Ed_lo = mean(Ed_lo);
mean_Ed_ri = mean(Ed_ri);
mean_Ed_ro = mean(Ed_ro);

median_Ed_li = median(Ed_li);
median_Ed_lo = median(Ed_lo);
median_Ed_ri = median(Ed_ri);
median_Ed_ro = median(Ed_ro);

%fprintf('Mean Left  Inner Surface Euclidean Error = %.4f; Median Left  Inner Surface Euclidean Error = %.4f; Left  Inner Surface MRE = %.4f%%. \n', mean(Lh_Inner.Surface_Euclidean_Error), median(Lh_Inner.Surface_Euclidean_Error), 100*mean(Lh_Inner.Surface_Euclidean_Error)/mean_Ed_li);
%fprintf('Mean Left  Outer Surface Euclidean Error = %.4f; Median Left  Outer Surface Euclidean Error = %.4f; Left  Outer Surface MRE = %.4f%%. \n', mean(Lh_Outer.Surface_Euclidean_Error), median(Lh_Outer.Surface_Euclidean_Error), 100*mean(Lh_Outer.Surface_Euclidean_Error)/mean_Ed_lo);
%fprintf('Mean Right Inner Surface Euclidean Error = %.4f; Median Right Inner Surface Euclidean Error = %.4f; Right Inner Surface MRE = %.4f%%. \n', mean(Rh_Inner.Surface_Euclidean_Error), median(Rh_Inner.Surface_Euclidean_Error), 100*mean(Rh_Inner.Surface_Euclidean_Error)/mean_Ed_ri);
%fprintf('Mean Right Outer Surface Euclidean Error = %.4f; Median Right Outer Surface Euclidean Error = %.4f; Right Outer Surface MRE = %.4f%%. \n', mean(Rh_Outer.Surface_Euclidean_Error), median(Rh_Outer.Surface_Euclidean_Error), 100*mean(Rh_Outer.Surface_Euclidean_Error)/mean_Ed_ro);
%fprintf('Mean Inner Surface Euclidean Error = %.4f; Inner Surface Euclidean MRE = %.4f%%. \n', 0.5*(mean(Lh_Inner.Surface_Euclidean_Error) + mean(Rh_Inner.Surface_Euclidean_Error)), 50*(mean(Lh_Inner.Surface_Euclidean_Error)/mean_Ed_li + mean(Rh_Inner.Surface_Euclidean_Error)/mean_Ed_ri));
%fprintf('Mean Outer Surface Euclidean Error = %.4f; Outer Surface Euclidean MRE = %.4f%%. \n', 0.5*(mean(Lh_Outer.Surface_Euclidean_Error) + mean(Rh_Outer.Surface_Euclidean_Error)), 50*(mean(Lh_Outer.Surface_Euclidean_Error)/mean_Ed_lo + mean(Rh_Outer.Surface_Euclidean_Error)/mean_Ed_ro));
fprintf('Median Inner Surface Euclidean Error = %.4f; Inner Surface Euclidean MeRE = %.4f%%. \n', 0.5*(median(Lh_Inner.Surface_Euclidean_Error) + median(Rh_Inner.Surface_Euclidean_Error)), 50*(median(Lh_Inner.Surface_Euclidean_Error)/median_Ed_li + median(Rh_Inner.Surface_Euclidean_Error)/median_Ed_ri));
fprintf('Median Outer Surface Euclidean Error = %.4f; Outer Surface Euclidean MeRE = %.4f%%. \n', 0.5*(median(Lh_Outer.Surface_Euclidean_Error) + median(Rh_Outer.Surface_Euclidean_Error)), 50*(median(Lh_Outer.Surface_Euclidean_Error)/median_Ed_lo + median(Rh_Outer.Surface_Euclidean_Error)/median_Ed_ro));

% Write ROI Error
ROI_l = gt_li.par_fs;
ROI_r = gt_ri.par_fs;

ROI_thick_err_l = zeros(n_vert,1);
ROI_surface_err_li = zeros(n_vert,1);
ROI_surface_err_lo = zeros(n_vert,1);
ROI_thick_err_r = zeros(n_vert,1);
ROI_surface_err_ri = zeros(n_vert,1);
ROI_surface_err_ro = zeros(n_vert,1);

for par = 1:length(ROI_l)
    [row,~] = find(gt_li.par_fs == ROI_l(par));
    ROI_tmp_thick_err_l = [];
    ROI_tmp_surface_err_li = [];
    ROI_tmp_surface_err_lo = [];
    for i = 1:length(row)
        ROI_tmp_thick_err_l = [ROI_tmp_thick_err_l, Lh_Inner.Thickness_Absolute_Error(row(i))];
        ROI_tmp_surface_err_li = [ROI_tmp_surface_err_li, Lh_Inner.Surface_Euclidean_Error(row(i))];
        ROI_tmp_surface_err_lo = [ROI_tmp_surface_err_lo, Lh_Outer.Surface_Euclidean_Error(row(i))];
    end
    ROI_thick_err_l(row) = median(ROI_tmp_thick_err_l);
    ROI_surface_err_li(row) = median(ROI_tmp_surface_err_li);
    ROI_surface_err_lo(row) = median(ROI_tmp_surface_err_lo);
end

for par = 1:length(ROI_r)
    [row,~] = find(gt_ri.par_fs == ROI_r(par));
    ROI_tmp_thick_err_r = [];
    ROI_tmp_surface_err_ri = [];
    ROI_tmp_surface_err_ro = [];
    for i = 1:length(row)
        ROI_tmp_thick_err_r = [ROI_tmp_thick_err_r, Rh_Inner.Thickness_Absolute_Error(row(i))];
        ROI_tmp_surface_err_ri = [ROI_tmp_surface_err_ri, Rh_Inner.Surface_Euclidean_Error(row(i))];
        ROI_tmp_surface_err_ro = [ROI_tmp_surface_err_ro, Rh_Outer.Surface_Euclidean_Error(row(i))];
    end
    ROI_thick_err_r(row) = median(ROI_tmp_thick_err_r);
    ROI_surface_err_ri(row) = median(ROI_tmp_surface_err_ri);
    ROI_surface_err_ro(row) = median(ROI_tmp_surface_err_ro);
end

Lh_Inner.ROI_Thickness_Absolute_Error = ROI_thick_err_l;
Lh_Outer.ROI_Thickness_Absolute_Error = ROI_thick_err_l;
Rh_Inner.ROI_Thickness_Absolute_Error = ROI_thick_err_r;
Rh_Outer.ROI_Thickness_Absolute_Error = ROI_thick_err_r;

Lh_Inner.ROI_Surface_Euclidean_Error = ROI_surface_err_li;
Lh_Outer.ROI_Surface_Euclidean_Error = ROI_surface_err_lo;
Rh_Inner.ROI_Surface_Euclidean_Error = ROI_surface_err_ri;
Rh_Outer.ROI_Surface_Euclidean_Error = ROI_surface_err_ro;

% Write vtk
path_write_vtk_li = fullfile(path_write_vtk, ['Lh_Inner_GSM6','.vtk']);
path_write_vtk_lo = fullfile(path_write_vtk, ['Lh_Outer_GSM6','.vtk']);
path_write_vtk_ri = fullfile(path_write_vtk, ['Rh_Inner_GSM6','.vtk']);
path_write_vtk_ro = fullfile(path_write_vtk, ['Rh_Outer_GSM6','.vtk']);

mvtk_write(Lh_Inner, path_write_vtk_li);
mvtk_write(Lh_Outer, path_write_vtk_lo);
mvtk_write(Rh_Inner, path_write_vtk_ri);
mvtk_write(Rh_Outer, path_write_vtk_ro);
