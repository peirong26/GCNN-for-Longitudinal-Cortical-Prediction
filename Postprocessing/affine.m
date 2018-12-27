clear

n_vert = 10242;
path_save = '/Users/peirong/Documents/Cycle/036/Results/affine';

% Load inputs
load('/Users/peirong/Documents/Cycle/TotalData/renamed/00/desc/rel_coord/M038_lh.InnerSurf.mat');
li = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/00/desc/rel_coord/M038_lh.OuterSurf.mat');
lo = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/00/desc/rel_coord/M038_rh.InnerSurf.mat');
ri = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/00/desc/rel_coord/M038_rh.OuterSurf.mat');
ro = desc;

% Load labels
load('/Users/peirong/Documents/Cycle/TotalData/renamed/03/desc/rel_coord/M038_lh.InnerSurf.mat');
li_3 = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/03/desc/rel_coord/M038_lh.OuterSurf.mat');
lo_3 = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/03/desc/rel_coord/M038_rh.InnerSurf.mat');
ri_3 = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/03/desc/rel_coord/M038_rh.OuterSurf.mat');
ro_3 = desc;

load('/Users/peirong/Documents/Cycle/TotalData/renamed/06/desc/rel_coord/M038_lh.InnerSurf.mat');
li_6 = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/06/desc/rel_coord/M038_lh.OuterSurf.mat');
lo_6 = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/06/desc/rel_coord/M038_rh.InnerSurf.mat');
ri_6 = desc;
load('/Users/peirong/Documents/Cycle/TotalData/renamed/06/desc/rel_coord/M038_rh.OuterSurf.mat');
ro_6 = desc;

% Load GT_0, GT3 for references
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/00/M086-1_00_lh.InnerSurf.mat');
gt_li0 = [surface.X, surface.Y, surface.Z];
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/00/M086-1_00_lh.OuterSurf.mat');
gt_lo0 = [surface.X, surface.Y, surface.Z];
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/00/M086-1_00_rh.InnerSurf.mat');
gt_ri0 = [surface.X, surface.Y, surface.Z];
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/00/M086-1_00_rh.OuterSurf.mat');
gt_ro0 = [surface.X, surface.Y, surface.Z];

load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_lh.InnerSurf.mat');
gt_li3 = [surface.X, surface.Y, surface.Z];
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_lh.OuterSurf.mat');
gt_lo3 = [surface.X, surface.Y, surface.Z];
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_rh.InnerSurf.mat');
gt_ri3 = [surface.X, surface.Y, surface.Z];
load('/Users/peirong/Documents/Cycle/TotalData/Surfaces_All/M086-1/03/M086-1_03_rh.OuterSurf.mat');
gt_ro3 = [surface.X, surface.Y, surface.Z];


% pred_li3
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(li*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - li_3)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_3 = pred + gt_li0;
save(fullfile(path_save,'li_3.mat'), 'pred_3', '-v7.3');

% pred_lo3
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(lo*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - lo_3)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_3 = pred + gt_lo0;
save(fullfile(path_save,'lo_3.mat'), 'pred_3', '-v7.3');

% pred_ri3
 a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(ri*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - ri_3)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_3 = pred + gt_ri0;
save(fullfile(path_save,'ri_3.mat'), 'pred_3', '-v7.3');

% pred_ro3
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(ro*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - ro_3)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_3 = pred + gt_ro0;
save(fullfile(path_save,'ro_3.mat'), 'pred_3', '-v7.3');


% pred_li6
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(li*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - li_6)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_6 = pred + gt_li3;
save(fullfile(path_save,'li_6.mat'), 'pred_6', '-v7.3');

% pred_lo6
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(lo*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - lo_6)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_6 = pred + gt_lo3;
save(fullfile(path_save,'lo_6.mat'), 'pred_6', '-v7.3');

% pred_ri6
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(ri*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - ri_6)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_6 = pred + gt_ri3;
save(fullfile(path_save,'ri_6.mat'), 'pred_6', '-v7.3');

% pred_ro6
a = 1;b = 1;c = 1;d = 0;e = 0;f = 0;P(1:3,1:3) = diag([a b c]);P(:,4:6) = diag([d e f]);

ErrorFun = @(P) norm(ro*P(:,1:3) + ones(n_vert,3)*P(:,4:6) - ro_6)^2; 
Pout = fminsearch(ErrorFun, P);
pred = li*Pout(:,1:3) + ones(n_vert,3)*P(:,4:6);

pred_6 = pred + gt_ro3;
save(fullfile(path_save,'ro_6.mat'), 'pred_6', '-v7.3');

