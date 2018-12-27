import numpy as np
import scipy.sparse as sp

########################################code for extracting portion of a shape########################################
def exctract_portion_shape(cPr, idx_sel_vert, idx_analyzed_vert, neighborsMat, min_dim_batch = 500):
    n_vert = cPr.shape[0]
    
    mask_sel_vert = neighborsMat[idx_sel_vert, :]
    
    _, idx_neighbors,_ = sp.find(mask_sel_vert) #only get the column value: the idx of neighbors

    list_all_neighbors = idx_neighbors.tolist() #neighbors of the selected nodes in the batch
    list_selected_nodes = [idx_sel_vert] #nodes in the batch
    list_usable_nodes = list(set(idx_neighbors) - set([idx_sel_vert]) - \
                             set(idx_analyzed_vert)) #new nodes that can be used in the batch

    #First part of the code. It extracts a set of vertices to exploit in the training (contained in list_selected_nodes) with
    #all the associated neighbors
    while (1):
        if (len(list_selected_nodes)>=min_dim_batch) or (len(list_usable_nodes)==0):
            break
        if (len(list_usable_nodes)> min_dim_batch - len(list_selected_nodes)):
            idx_sort = np.random.permutation(len(list_usable_nodes))
            idx_sort = idx_sort[:(min_dim_batch - len(list_selected_nodes))]
        else:
            idx_sort = range(len(list_usable_nodes))

        idx_selected_neighbors = [list_usable_nodes[i] for i in idx_sort]
        list_selected_nodes = list_selected_nodes + idx_selected_neighbors

        mask_sel_vert = neighborsMat[idx_selected_neighbors, :]
        _, idx_neighbors_col,_ = sp.find(mask_sel_vert)

        list_usable_nodes = list(set(list_usable_nodes + idx_neighbors_col.tolist()) - \
                                 set(list_selected_nodes) - set(idx_analyzed_vert))
        list_all_neighbors = list(set(list_all_neighbors + idx_neighbors_col.tolist()))

    #Second part of the code. It retrieves all the nodes required for applying a 3 layer convolution overt part of the shape.
    
    # For month 6
    #extraction nodes and mask for month 6 - 3rd convolution
    compute_label_mask_l3_m6 = [1]*len(list_selected_nodes) #this will be a mask that defines which nodes in the third convolution 
                                                         #should be taken as valid
    
    new_nodes = list(set(list_all_neighbors) - set(list_selected_nodes))
    list_selected_nodes += new_nodes
    compute_label_mask_l3_m6 += [0]*len(new_nodes)
    
    _, idx_all_required_neighbors, _ = sp.find(neighborsMat[list_selected_nodes,:])
    list_all_neighbors_tmp = idx_all_required_neighbors.tolist()
    new_neighbors = list(set(list_all_neighbors_tmp) - set(list_selected_nodes))
    list_all_neighbors  = list_selected_nodes + new_neighbors
    
    
    mask_neighbors_l3_m6 = np.zeros((len(list_all_neighbors), )) #this will be a mask that defines which nodes in the third convolution 
                                                              #should be taken as valid neighbors
    mask_neighbors_l3_m6[:len(list_selected_nodes)] = 1 #keep in the third convolution only the target nodes + neighbors
    
    #extraction nodes and mask for month 6 - 2nd convolution
    compute_label_mask_l2_m6 = [1]*len(list_selected_nodes) #this will be a mask that defines which nodes in the third convolution 
                                                         #should be taken as valid
    
    new_nodes = list(set(list_all_neighbors) - set(list_selected_nodes))
    list_selected_nodes += new_nodes
    compute_label_mask_l2_m6 += [0]*len(new_nodes)
    
    _, idx_all_required_neighbors, _ = sp.find(neighborsMat[list_selected_nodes,:])
    list_all_neighbors_tmp = idx_all_required_neighbors.tolist()
    new_neighbors = list(set(list_all_neighbors_tmp) - set(list_selected_nodes))
    list_all_neighbors  = list_selected_nodes + new_neighbors
    
    
    mask_neighbors_l2_m6 = np.zeros((len(list_all_neighbors), )) #this will be a mask that defines which nodes in the third convolution 
                                                              #should be taken as valid neighbors
    mask_neighbors_l2_m6[:len(list_selected_nodes)] = 1 #keep in the third convolution only the target nodes + neighbors
    
    #extraction nodes and mask for month 6 - 1st convolution
    compute_label_mask_l1_m6 = [1]*len(list_selected_nodes) #this will be a mask that defines which nodes in the third convolution 
                                                         #should be taken as valid
    
    new_nodes = list(set(list_all_neighbors) - set(list_selected_nodes))
    list_selected_nodes += new_nodes
    compute_label_mask_l1_m6 += [0]*len(new_nodes)
    
    _, idx_all_required_neighbors, _ = sp.find(neighborsMat[list_selected_nodes,:])
    list_all_neighbors_tmp = idx_all_required_neighbors.tolist()
    new_neighbors = list(set(list_all_neighbors_tmp) - set(list_selected_nodes))
    list_all_neighbors  = list_selected_nodes + new_neighbors
    
    
    mask_neighbors_l1_m6 = np.zeros((len(list_all_neighbors), )) #this will be a mask that defines which nodes in the third convolution 
                                                              #should be taken as valid neighbors
    mask_neighbors_l1_m6[:len(list_selected_nodes)] = 1 #keep in the third convolution only the target nodes + neighbors
    
     
    # For month 3
    #extraction nodes and mask for month 3 - 3rd convolution
    compute_label_mask_l2_m3 = [1]*len(list_selected_nodes) #this will be a mask that defines which nodes in the third convolution 
                                                         #should be taken as valid
    
    new_nodes = list(set(list_all_neighbors) - set(list_selected_nodes))
    list_selected_nodes += new_nodes
    compute_label_mask_l2_m3 += [0]*len(new_nodes)
    
    _, idx_all_required_neighbors, _ = sp.find(neighborsMat[list_selected_nodes,:])
    list_all_neighbors_tmp = idx_all_required_neighbors.tolist()
    new_neighbors = list(set(list_all_neighbors_tmp) - set(list_selected_nodes))
    list_all_neighbors  = list_selected_nodes + new_neighbors
    
    
    mask_neighbors_l2_m3 = np.zeros((len(list_all_neighbors), )) #this will be a mask that defines which nodes in the third convolution 
                                                              #should be taken as valid neighbors
    mask_neighbors_l2_m3[:len(list_selected_nodes)] = 1 #keep in the third convolution only the target nodes + neighbors
    
    #extraction nodes and mask for month 3 - 2nd convolution
    compute_label_mask_l1_m3 = [1]*len(list_selected_nodes) #this will be a mask that defines which nodes in the second convolution 
                                                         #should be taken as valid
    
    new_nodes = list(set(list_all_neighbors) - set(list_selected_nodes))
    list_selected_nodes = list_all_neighbors
    
    # Gather all together
    compute_label_mask_l1_m3 += [0]*len(new_nodes)
    compute_label_mask_l2_m3 += [0]*len(new_nodes)

    compute_label_mask_l1_m6 += [0]*len(new_nodes)
    compute_label_mask_l2_m6 += [0]*len(new_nodes)
    compute_label_mask_l3_m6 += [0]*len(new_nodes)
    

    _, idx_all_required_neighbors, _ = sp.find(neighborsMat[list_selected_nodes,:])
    list_all_neighbors_tmp = idx_all_required_neighbors.tolist()
    list_all_neighbors  = list(set(list_all_neighbors_tmp))
    
    mask_neighbors_l1_m3 = np.zeros((len(list_all_neighbors_tmp), )) #this will be a mask that defines which nodes in the second 
                                                                  #convolution should be taken as valid
    
    new_neighbors = list(set(list_all_neighbors_tmp) - set(list_all_neighbors))
    list_all_neighbors  = list_all_neighbors + new_neighbors

    mask_neighbors_l1_m3[:len(list_selected_nodes)] = 1 #keep in the second convolution only the target nodes + neighbors + neighbors of 
                                                     #the neighbors                                           
    # Gather all together
    mask_neighbors_l2_m3 = np.concatenate((mask_neighbors_l2_m3, np.zeros((len(new_neighbors),))))
    
    mask_neighbors_l1_m6 = np.concatenate((mask_neighbors_l1_m6, np.zeros((len(new_neighbors),))))
    mask_neighbors_l2_m6 = np.concatenate((mask_neighbors_l2_m6, np.zeros((len(new_neighbors),))))
    mask_neighbors_l3_m6 = np.concatenate((mask_neighbors_l3_m6, np.zeros((len(new_neighbors),))))

    return [list_selected_nodes, list_all_neighbors, \
            compute_label_mask_l2_m3, mask_neighbors_l2_m3, compute_label_mask_l1_m3, mask_neighbors_l1_m3, \
            compute_label_mask_l3_m6, mask_neighbors_l3_m6, compute_label_mask_l2_m6, mask_neighbors_l2_m6, compute_label_mask_l1_m6, mask_neighbors_l1_m6]

########################################################################################################################