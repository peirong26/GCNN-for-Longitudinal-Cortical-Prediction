function [patch_rho,patch_theta] = compute_patch_coord(shape,areas_loc,params)

global geodesic_library;
geodesic_library = 'geodesic_matlab_api';

vertices = [shape.X,shape.Y,shape.Z];
faces    = shape.TRIV;


%%%%%%%%%%
[mesh, edge_to_vertex, edge_to_face] = geodesic_new_mesh(vertices,faces);
disp(fprintf('mesh has %d edges', length(edge_to_vertex))); % <--sprintf

algorithm = geodesic_new_algorithm(mesh, 'exact'); % initialize new geodesic algorithm
%%%%%%%%%%


% compute the principal curvatures
params.verb  = 1;
[Umin,Umax,Cmin,Cmax,~,~,normals] = compute_curvature(vertices',faces',params);
Umin    = Umin';
Umax    = Umax';
normals = normals';

patch_theta = zeros(size(vertices,1),size(vertices,1));
patch_rho   = zeros(size(vertices,1),size(vertices,1));

for idx_vertex = 1:size(vertices,1)
    
    if params.flag_adaptive
        params.perc = params.perc * exp(areas_loc(idx_vertex) ./ max(areas_loc));
    end
    
    source_points = {};
    source_points{1} = geodesic_create_surface_point('vertex',idx_vertex,vertices(idx_vertex,:));
    
    geodesic_propagate(algorithm,source_points); % propagation stage of the algorithm (the most time-consuming)
    
    [source_idxs, distances] = geodesic_distance_and_source(algorithm);
    
    % local frame
    t = Umin(idx_vertex,:)';
    n = normals(idx_vertex,:)';
    b = cross(t,n);
    t = t./norm(t);
    n = n./norm(n);
    b = b./norm(b);
    
    if isfield(params,'diam')
        diam = params.diam;
    else
        diam = max(distances);
    end
    mask        = distances <= (params.perc/100 * diam);
    idxs        = [1:size(vertices,1)]';
    idxs_neigh  = setdiff(idxs(mask),idx_vertex);
    
    destinations = {};
    paths        = {};
    thetas = zeros(length(idxs_neigh));
    
    for idx_neigh = 1:length(idxs_neigh)
        
        destinations{idx_neigh} = geodesic_create_surface_point('vertex',idxs_neigh(idx_neigh),vertices(idxs_neigh(idx_neigh),:));
        paths{idx_neigh}        = geodesic_trace_back(algorithm,destinations{idx_neigh});
        
        idx_target    = length(paths{idx_neigh})-1;
        vertex_target = [paths{idx_neigh}{idx_target}.x,paths{idx_neigh}{idx_target}.y,paths{idx_neigh}{idx_target}.z];
        
        tmp = [vertex_target(1)-vertices(idx_vertex,1),...
               vertex_target(2)-vertices(idx_vertex,2),...
               vertex_target(3)-vertices(idx_vertex,3)];
        v   = tmp' - (dot(tmp,n)./(norm(n)^2)) * n;
        clear tmp;

        thetas(idx_neigh) = atan2( norm(cross(v,t)), dot(v,t) ) * sign(dot(v,cross(n,t)));
        
        patch_theta(idx_vertex,idxs_neigh(idx_neigh)) = thetas(idx_neigh);
        patch_rho(idx_vertex,idxs_neigh(idx_neigh))   = distances(idxs_neigh(idx_neigh));
        
    end
    
    patch_theta(idx_vertex,idx_vertex) = eps;
    patch_rho(idx_vertex,idx_vertex)   = eps;
    
end

geodesic_delete;
