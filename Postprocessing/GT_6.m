clear
% path for writing vtk results
path_write_vtk_6 = '/Users/peirong/Documents/Cycle/036/Results/06';

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

GT_Lh_Inner.faces = gt_li.TRIV;
GT_Lh_Outer.faces = gt_lo.TRIV;
GT_Rh_Inner.faces = gt_ri.TRIV;
GT_Rh_Outer.faces = gt_ro.TRIV;

GT_Lh_Inner.vertices = [gt_li.X,gt_li.Y,gt_li.Z];
GT_Lh_Outer.vertices = [gt_lo.X,gt_lo.Y,gt_lo.Z];
GT_Rh_Inner.vertices = [gt_ri.X,gt_ri.Y,gt_ri.Z];
GT_Rh_Outer.vertices = [gt_ro.X,gt_ro.Y,gt_ro.Z];

GT_Lh_Inner.Thickness = gt_li.thickness;
GT_Lh_Outer.Thickness = gt_lo.thickness;
GT_Rh_Inner.Thickness = gt_ri.thickness;
GT_Rh_Outer.Thickness = gt_ro.thickness;

% Eudlidean distance
n_vert = 10242;
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

GT_Lh_Inner.ED = Ed_li;
GT_Lh_Outer.ED = Ed_lo;

GT_Rh_Inner.ED = Ed_ri;
GT_Rh_Outer.ED = Ed_ro;

% ROI averaged
ROI_l = gt_li.par_fs;
ROI_r = gt_ri.par_fs;

ROI_ED_li = zeros(n_vert,1);
ROI_ED_lo = zeros(n_vert,1);
ROI_ED_ri = zeros(n_vert,1);
ROI_ED_ro = zeros(n_vert,1); 
ROI_thick_l = zeros(n_vert,1);
ROI_thick_r = zeros(n_vert,1);

for par = 1:length(ROI_l)
    [row,~] = find(gt_li.par_fs == ROI_l(par));
    ROI_tmp_thick_l = [];
    ROI_tmp_ED_li = [];
    ROI_tmp_ED_lo = [];
    
    for i = 1:length(row)
        ROI_tmp_thick_l = [ROI_tmp_thick_l, gt_li.thickness(row(i))];
        ROI_tmp_ED_li = [ROI_tmp_ED_li, Ed_li(row(i))];
        ROI_tmp_ED_lo = [ROI_tmp_ED_lo, Ed_lo(row(i))];
    end
    ROI_thick_l(row) = mean(ROI_tmp_thick_l);
    ROI_ED_li(row) = mean(ROI_tmp_ED_li);
    ROI_ED_lo(row) = mean(ROI_tmp_ED_lo);
end

for par = 1:length(ROI_r)
    [row,~] = find(gt_ri.par_fs == ROI_r(par));
    ROI_tmp_ED_ri = [];   
    ROI_tmp_ED_ro = [];
    ROI_tmp_thick_r = [];
    for i = 1:length(row)
        ROI_tmp_thick_r = [ROI_tmp_thick_r, gt_ri.thickness(row(i))];
        ROI_tmp_ED_ri = [ROI_tmp_ED_ri, Ed_ri(row(i))];
        ROI_tmp_ED_ro = [ROI_tmp_ED_ro, Ed_ro(row(i))];
    end
    ROI_thick_r(row) = mean(ROI_tmp_thick_r);
    ROI_ED_ri(row) = mean(ROI_tmp_ED_ri);
    ROI_ED_ro(row) = mean(ROI_tmp_ED_ro);
end

GT_Lh_Inner.ROI_CT = ROI_thick_l;
GT_Lh_Outer.ROI_CT = ROI_thick_l;
GT_Rh_Inner.ROI_CT = ROI_thick_r;
GT_Rh_Outer.ROI_CT = ROI_thick_r;

GT_Lh_Inner.ROI_ED = ROI_ED_li;
GT_Lh_Outer.ROI_ED = ROI_ED_lo;
GT_Rh_Inner.ROI_ED = ROI_ED_ri;
GT_Rh_Outer.ROI_ED = ROI_ED_ro;

% Write vtk
path_write_vtk_gt_li = fullfile(path_write_vtk_6, ['GT_LI6','.vtk']);
path_write_vtk_gt_lo = fullfile(path_write_vtk_6, ['GT_LO6','.vtk']);
path_write_vtk_gt_ri = fullfile(path_write_vtk_6, ['GT_RI6','.vtk']);
path_write_vtk_gt_ro = fullfile(path_write_vtk_6, ['GT_RO6','.vtk']);

mvtk_write(GT_Lh_Inner, path_write_vtk_gt_li);
mvtk_write(GT_Lh_Outer, path_write_vtk_gt_lo);
mvtk_write(GT_Rh_Inner, path_write_vtk_gt_ri);
mvtk_write(GT_Rh_Outer, path_write_vtk_gt_ro);
