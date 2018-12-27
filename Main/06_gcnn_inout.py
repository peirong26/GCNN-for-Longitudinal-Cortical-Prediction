# coding: utf-8

#In[1]
import os
import time
import pickle as cPickle
import numpy as np
import scipy.sparse as sp
import scipy.io as io
import matplotlib.pyplot as plt
from theano.tensor.signal.pool import pool_2d
import theano
import theano.tensor as T
import theano.sparse as Tsp
import lasagne as L  
import lasagne.init as LI
import lasagne.layers as LL
import lasagne.objectives as LO  
import lasagne.regularization as LR

import utilities_shape_036
from utilities_model_036 import GaussianWeightsLayer, ApplyDescLayer, ApplyDescLayerMask
from utilities_dataset_36inout import Dataset

np.random.seed(42)

# editable parameters:

# main path
path_main = '/Users/peirong/Documents/Cycle/036'

# path to the experiment information
path_exp_info = os.path.join(path_main, 'exp_info')
path_dumps    = os.path.join(path_main, 'dumps')


# main path to the entire datasets
path_datasets =  '/Users/peirong/Documents/Cycle/TotalData/renamed'

# path to the input descriptors
path_descs_0  = os.path.join(path_datasets, '00/desc/out_in') 
# path to the patches
path_patches  = os.path.join(path_datasets, '00/patch_coord') 
# path to the labels
path_labels_6 = os.path.join(path_datasets, '06/desc/out_in') 
path_thick_6  = os.path.join(path_datasets, '06/desc/thickness') 
# path to flags
path_flags_6  =  os.path.join(path_datasets, '06/flags') 

print("06_inout")

# train / test splitting:
files_train_in  = open(os.path.join(path_exp_info, 'files_train_06_in.txt'), 'w')
files_test_in   = open(os.path.join(path_exp_info, 'files_test_06_in.txt'), 'w')
files_train_out = open(os.path.join(path_exp_info, 'files_train_06_out.txt'), 'w')
files_test_out  = open(os.path.join(path_exp_info, 'files_test_06_out.txt'), 'w')

# train/test set 
for idx in range(0,38):
    files_train_in.write('M%.3d_lh.InnerSurf.mat\n' % (idx))
    files_train_in.write('M%.3d_rh.InnerSurf.mat\n' % (idx))

    files_train_out.write('M%.3d_lh.OuterSurf.mat\n' % (idx)) 
    files_train_out.write('M%.3d_rh.OuterSurf.mat\n' % (idx)) 

for idx in range(38,39):
    files_test_in.write('M%.3d_lh.InnerSurf.mat\n' % (idx))
    files_test_in.write('M%.3d_rh.InnerSurf.mat\n' % (idx))

    files_test_out.write('M%.3d_lh.OuterSurf.mat\n' % (idx))
    files_test_out.write('M%.3d_rh.OuterSurf.mat\n' % (idx))

files_train_in.close()
files_test_in.close()
files_train_out.close()
files_test_out.close()

# dataset loading
ds = Dataset(os.path.join(path_exp_info, 'files_train_06_in.txt'), os.path.join(path_exp_info, 'files_train_06_out.txt'),
             os.path.join(path_exp_info, 'files_test_06_in.txt'), os.path.join(path_exp_info, 'files_test_06_out.txt'),
             path_flags_6,
             path_descs_0,
             path_patches,
             path_labels_6,
             path_thick_6)
 
#Here the definition of the model begins

# architecture definition:

n_vert = 10242
n_fin  = ds.descs_0_train_in[0].shape[1] # shape[0]: return total number of input features (input descriptor dimension)

P_rho       = LL.InputLayer(shape=(None, None), input_var=T.fmatrix('P_rho_in'))  
P_theta     = LL.InputLayer(shape=(None, None), input_var=T.fmatrix('P_theta_in'))  # creates one float32-matrix with name 'P_theta'
P_rho       = LL.InputLayer(shape=(None, None), input_var=T.fmatrix('P_rho_out'))  
P_theta     = LL.InputLayer(shape=(None, None), input_var=T.fmatrix('P_theta_out'))  # creates one float32-matrix with name 'P_theta'

idx_node_l1_m3      = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_node_l1_m3')) #indexes of the nodes to take as valid in output in the third convolution
idx_neighbors_l1_m3 = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_neighbors_l1_m3')) #indexes of the neighbors of the nodes to take as valid in output in the third convolution

idx_node_l2_m3      = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_node_l2_m3')) #indexes of the nodes to take as valid in output in the third convolution
idx_neighbors_l2_m3 = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_neighbors_l2_m3')) #indexes of the neighbors of the nodes to take as valid in output in the third convolution

idx_node_l1_m6      = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_node_l1_m6')) #indexes of the nodes to take as valid in output in the third convolution
idx_neighbors_l1_m6 = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_neighbors_l1_m6')) #indexes of the neighbors of the nodes to take as valid in output in the third convolution

idx_node_l2_m6      = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_node_l2_m6')) #indexes of the nodes to take as valid in output in the third convolution
idx_neighbors_l2_m6 = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_neighbors_l2_m6')) #indexes of the neighbors of the nodes to take as valid in output in the third convolution

idx_node_l3_m6      = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_node_l3_m6')) #indexes of the nodes to take as valid in output in the third convolution
idx_neighbors_l3_m6 = LL.InputLayer(shape=(None,), input_var=T.ivector('idx_neighbors_l3_m6')) #indexes of the neighbors of the nodes to take as valid in output in the third convolution

desc_0_in             = LL.InputLayer(shape=(None,n_fin), input_var=T.fmatrix('desc_0_in'))
desc_0_out            = LL.InputLayer(shape=(None,n_fin), input_var=T.fmatrix('desc_0_out'))

# number of rho and theta we want to have in the patch operator
n_rho   = 5  
n_theta = 12 

# number of features in output in each layer
n_fout1 = 36
n_fout2 = 72
n_fout3 = 36
n_fout4 = 18
n_fout5 = 9 
n_fout6 = 3

n_out   = 3

# dimensionality reduction layer
#desc_red = LL.DenseLayer(desc, 3)  # Reduce SHOT description's 544 dimension to # 16 dimension

# computation of the memberships
# tensor containing the membership of each vertex wrt to any other in various bins
net = GaussianWeightsLayer([P_rho, P_theta], n_rho, n_theta) 

# Inner
# Step 1: patch operator layer
net1_1_1_in  = ApplyDescLayer([net, desc_0_in]) 
# Step 2: convolution layer
net1_1_2_in  = LL.DenseLayer(net1_1_1_in, n_fout1, nonlinearity=None)

# Step 1: patch operator layer
net1_2_1_in  = ApplyDescLayerMask([net, net1_1_2_in, idx_node_l1_m3, idx_neighbors_l1_m3])
# Step 2: convolution layer
net1_2_2_in  = LL.DenseLayer(net1_2_1_in, n_fout2, nonlinearity=None) 

# Step 1: patch operator layer
net1_3_1_in  = ApplyDescLayerMask([net, net1_2_2_in, idx_node_l2_m3, idx_neighbors_l2_m3])
# Step 2: convolution layer
net1_3_2_in  = LL.DenseLayer(net1_3_1_in, n_fout3, nonlinearity=None) 

# Step 1: patch operator layer
net2_1_1_in  = ApplyDescLayerMask([net, net1_3_2_in, idx_node_l1_m6, idx_neighbors_l1_m6]) 
# Step 2: convolution layer
net2_1_2_in  = LL.DenseLayer(net2_1_1_in, n_fout4, nonlinearity=None) 

# Step 1: patch operator layer
net2_2_1_in  = ApplyDescLayerMask([net, desc_3_in, idx_node_l2_m6, idx_neighbors_l2_m6]) 
# Step 2: convolution layer
net2_2_2_in  = LL.DenseLayer(net2_2_1_in, n_fout5, nonlinearity=None) 

# Step 1: patch operator layer
net2_3_1_in  = ApplyDescLayerMask([net, net2_2_2_in, idx_node_l3_m6, idx_neighbors_l3_m6]) 
# Step 2: convolution layer
net2_3_2_in  = LL.DenseLayer(net2_3_1_in, n_fout6, nonlinearity=None) 


############ BRIDGE ############
desc_6_in = LL.DenseLayer(net2_3_2_in, n_out, nonlinearity = None)
################################


# Outer
# Step 1: patch operator layer
net1_1_1_out  = ApplyDescLayer([net, desc_0_out]) 
# Step 2: convolution layer
net1_1_2_out  = LL.DenseLayer(net1_1_1_out, n_fout1, nonlinearity=None)

# Step 1: patch operator layer
net1_2_1_out  = ApplyDescLayerMask([net, net1_1_2_out, idx_node_l1_m3, idx_neighbors_l1_m3])
# Step 2: convolution layer
net1_2_2_out  = LL.DenseLayer(net1_2_1_out, n_fout2, nonlinearity=None) 

# Step 1: patch operator layer
net1_3_1_out  = ApplyDescLayerMask([net, net1_2_2_out, idx_node_l2_m3, idx_neighbors_l2_m3])
# Step 2: convolution layer
net1_3_2_out  = LL.DenseLayer(net1_3_1_out, n_fout3, nonlinearity=None) 

# Step 1: patch operator layer
net2_1_1_out  = ApplyDescLayerMask([net, net1_3_2_out, idx_node_l1_m6, idx_neighbors_l1_m6]) 
# Step 2: convolution layer
net2_1_2_out  = LL.DenseLayer(net2_1_1_out, n_fout4, nonlinearity=None) 

# Step 1: patch operator layer
net2_2_1_out  = ApplyDescLayerMask([net, net2_1_2_out, idx_node_l2_m6, idx_neighbors_l2_m6]) 
# Step 2: convolution layer
net2_2_2_out  = LL.DenseLayer(net2_2_1_out, n_fout5, nonlinearity=None) 

# Step 1: patch operator layer
net2_3_1_out  = ApplyDescLayerMask([net, net2_2_2_out, idx_node_l3_m6, idx_neighbors_l3_m6]) 
# Step 2: convolution layer
net2_3_2_out  = LL.DenseLayer(net2_3_1_out, n_fout6, nonlinearity=None) 


############ BRIDGE ############
desc_6_out = LL.DenseLayer(net2_3_2_out, n_out, nonlinearity = None)
################################


# functions definitions:
flag_6       = T.dscalar('flag_6')
target_6_in  = T.fmatrix('target_6_in')  
target_6_out = T.fmatrix('target_6_out')  
thick_6      = T.fmatrix('thick_6')

pred_3_in, pred_3_out, pred_6_in, pred_6_out = LL.get_output([desc_3_in, desc_3_out, desc_6_in, desc_6_out], deterministic=True) 

# raw cost

def compute_cost(pred, target, flag):
    cost_dataterm = T.maximum((((pred - target)**2).sum(axis = 1)).mean(), ((((pred - target)**2).sum(axis = 1))**(1.0/2.0)).mean())
    cost_dataterm = flag * cost_dataterm
    return cost_dataterm

def compute_thickness_cost(pred_in, pred_out, thickness, flag):
    tmp_1  = (pred_in[:,:1] - pred_out[:,:1]) ** 2
    tmp_2 = (pred_in[:,1:2] - pred_out[:,1:2]) ** 2
    tmp_3 = (pred_in[:,2:3] - pred_out[:,2:3]) ** 2
    thick_pred = np.sqrt(tmp_1 + tmp_2 + tmp_3)
    cost_thickness = T.maximum(((thick_pred - thickness)**2).mean(), (abs(thick_pred - thickness)).mean())
    cost_thickness = flag * cost_thickness
    print(thickness)
    return cost_thickness

cost_dataterm_6_in  = compute_cost(pred_6_in, target_6_in, flag_6)
cost_dataterm_6_out = compute_cost(pred_6_out, target_6_out, flag_6)
cost_dataterm_6_thick = compute_thickness_cost(pred_6_in, pred_6_out, thick_6, flag_6)
print("cost = max(L1, L2)")
 
# regularization
mu = 0 #0.1
print("reg_mu = %01.1f" % mu)
cost_reg = mu * LR.regularize_network_params(net, LR.l2)

# cost function: final cost
cost = cost_dataterm_6_in + cost_dataterm_6_out + cost_dataterm_6_thick + cost_reg

# get params
params  = LL.get_all_params([desc_6_in, desc_6_out]) 
print(params)

# gradient definition
grad   = T.grad(cost, params)
grad_norm = T.nlinalg.norm(T.concatenate([g.flatten() for g in grad]), 2)

# updates definition
updates_f = L.updates.adam(grad, params, learning_rate=1e-4)
updates_s = L.updates.adam(grad, params, learning_rate=1e-5)

learning_rate_f = 1e-4
learning_rate_s = 1e-5
print("fast learning rate = %.1e, slow learning rate = %.1e" % (learning_rate_f, learning_rate_s))

# train / test functions
funcs = dict()
funcs['train_f'] = theano.function([flag_6, desc_0_in.input_var, desc_0_out.input_var, P_rho.input_var, P_theta.input_var, target_6_in, target_6_out, thick_6, \
                                 idx_node_l1_m3.input_var, idx_neighbors_l1_m3.input_var, idx_node_l2_m3.input_var, idx_neighbors_l2_m3.input_var, \
                                 idx_node_l1_m6.input_var, idx_neighbors_l1_m6.input_var, idx_node_l2_m6.input_var, idx_neighbors_l2_m6.input_var, idx_node_l3_m6.input_var, idx_neighbors_l3_m6.input_var],
                                [cost, cost_dataterm_6_in, cost_dataterm_6_out, cost_dataterm_6_thick, cost_reg, grad_norm], 
                                updates = updates_f, 
                                allow_input_downcast='True',
                                on_unused_input = 'warn')

funcs['train_s'] = theano.function([flag_6, desc_0_in.input_var, desc_0_out.input_var, P_rho.input_var, P_theta.input_var, target_6_in, target_6_out, thick_6, \
                                 idx_node_l1_m3.input_var, idx_neighbors_l1_m3.input_var, idx_node_l2_m3.input_var, idx_neighbors_l2_m3.input_var, \
                                 idx_node_l1_m6.input_var, idx_neighbors_l1_m6.input_var, idx_node_l2_m6.input_var, idx_neighbors_l2_m6.input_var, idx_node_l3_m6.input_var, idx_neighbors_l3_m6.input_var],
                                [cost, cost_dataterm_6_in, cost_dataterm_6_out, cost_dataterm_6_thick, cost_reg, grad_norm], 
                                updates = updates_s, 
                                allow_input_downcast='True',
                                on_unused_input = 'warn')

funcs['pred'] = theano.function([flag_6, desc_0_in.input_var, desc_0_out.input_var, P_rho.input_var, P_theta.input_var, target_6_in, target_6_out, thick_6, \
                                 idx_node_l1_m3.input_var, idx_neighbors_l1_m3.input_var, idx_node_l2_m3.input_var, idx_neighbors_l2_m3.input_var, \
                                 idx_node_l1_m6.input_var, idx_neighbors_l1_m6.input_var, idx_node_l2_m6.input_var, idx_neighbors_l2_m6.input_var, idx_node_l3_m6.input_var, idx_neighbors_l3_m6.input_var],
                                [cost, cost_dataterm_6_in, cost_dataterm_6_out, cost_dataterm_6_thick, cost_reg, grad_norm, pred_6_in, pred_6_out], 
                                no_default_updates=True,
                                allow_input_downcast='True',
                                on_unused_input='ignore')

#Definition of the test model
def test_model(x_, n_vert):
    
    flag_6 = x_[0]
    cPr    = x_[10]
    cPt    = x_[11]

    perm_vert = range(n_vert)
    idx_analyzed_vert = []
    cPr.setdiag(1e-14)

    overall_cost = 0 
    cost_6_in    = 0
    cost_6_out   = 0
    cost_6_thick = 0

    all_pred_6_in  = np.zeros((n_vert, n_out))
    all_pred_6_out = np.zeros((n_vert, n_out)) 
    
    while(1):
        if (len(perm_vert)==0):
            break
            
        list_selected_nodes, list_all_neighbors, compute_label_mask_l2_m3_rt, mask_neighbors_l2_m3_rt, compute_label_mask_l1_m3_rt, mask_neighbors_l1_m3_rt, compute_label_mask_l3_m6_rt, mask_neighbors_l3_m6_rt, compute_label_mask_l2_m6_rt, mask_neighbors_l2_m6_rt, compute_label_mask_l1_m6_rt, mask_neighbors_l1_m6_rt = utilities_shape_36.exctract_portion_shape(cPr, perm_vert[0], idx_analyzed_vert, x_[12], min_dim_batch=100)
 
        #Computation of the indexes of the selected vertices from the masks
        idx_mask_neighbors_l1_m3 = np.squeeze(np.asarray(np.where(mask_neighbors_l1_m3_rt)))
        idx_compute_label_mask_l1_m3 = np.squeeze(np.asarray(np.where(compute_label_mask_l1_m3_rt)))
        idx_mask_neighbors_l2_m3 = np.squeeze(np.asarray(np.where(mask_neighbors_l2_m3_rt)))
        idx_compute_label_mask_l2_m3 = np.squeeze(np.asarray(np.where(compute_label_mask_l2_m3_rt)))
        
        idx_mask_neighbors_l1_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l1_m6_rt)))
        idx_compute_label_mask_l1_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l1_m6_rt)))
        idx_mask_neighbors_l2_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l2_m6_rt)))
        idx_compute_label_mask_l2_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l2_m6_rt)))
        idx_mask_neighbors_l3_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l3_m6_rt)))
        idx_compute_label_mask_l3_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l3_m6_rt)))

        #Extraction of the portion of the shape we should exploit in the test phase
        cPr_sel = cPr[:, list_all_neighbors][list_selected_nodes, :].todense()
        cPt_sel = cPt[:, list_all_neighbors][list_selected_nodes, :].todense()

        #Extraction of the descriptors and labels we should exploit in the test phase
        desc_in_sel      = x_[1][list_all_neighbors, :]
        desc_out_sel     = x_[2][list_all_neighbors, :]

        target_6_in_sel  = x_[7][list_selected_nodes]
        target_6_out_sel = x_[8][list_selected_nodes]
        thick_6_sel      = x_[9][list_selected_nodes]
             
        if (idx_compute_label_mask_l3_m6.shape!=()):
            target_6_in_sel  = np.asarray(target_6_in_sel)[idx_compute_label_mask_l3_m6] 
            target_6_out_sel = np.asarray(target_6_out_sel)[idx_compute_label_mask_l3_m6]
            thick_6_sel      = np.asarray(thick_6_sel)[idx_compute_label_mask_l3_m6]
        else: 
            target_6_in_sel  = [np.asarray(target_6_in_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]
            target_6_out_sel = [np.asarray(target_6_out_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]
            thick_6_sel      = [np.asarray(thick_6_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]

            idx_compute_label_mask_l3_m6 = [np.asscalar(idx_compute_label_mask_l3_m6)]
        
        list_selected_nodes = np.asarray(list_selected_nodes)
        
        #Testing
        parameters_test = (flag_3, flag_6, desc_in_sel, desc_out_sel, cPr_sel, cPt_sel, target_3_in_sel, target_3_out_sel, target_6_in_sel, target_6_out_sel, thick_3_sel, thick_6_sel, \
                           idx_compute_label_mask_l1_m3, idx_mask_neighbors_l1_m3, idx_compute_label_mask_l2_m3, idx_mask_neighbors_l2_m3, \
                           idx_compute_label_mask_l1_m6, idx_mask_neighbors_l1_m6, idx_compute_label_mask_l2_m6, idx_mask_neighbors_l2_m6, idx_compute_label_mask_l3_m6, idx_mask_neighbors_l3_m6)
        tmp = funcs['pred'](*parameters_test)
 
        #Statistics computation
        all_pred_6_in[list_selected_nodes[idx_compute_label_mask_l2_m6],:]  = tmp[6] 
        all_pred_6_out[list_selected_nodes[idx_compute_label_mask_l2_m6],:] = tmp[7] 

        overall_cost += tmp[0]*len(idx_compute_label_mask_l2_m6)

        cost_6_in    += tmp[1]*len(idx_compute_label_mask_l2_m6)
        cost_6_out   += tmp[2]*len(idx_compute_label_mask_l2_m6)
        cost_6_thick += tmp[3]*len(idx_compute_label_mask_l2_m6)

        #Updating of the lists associated to the remaining vertices we still have to process
        perm_vert = list(set(perm_vert) - set(np.asarray(list_selected_nodes)[idx_compute_label_mask_l3_m6]))
        idx_analyzed_vert += np.asarray(list_selected_nodes)[idx_compute_label_mask_l3_m6].tolist()
    
    return [overall_cost*1.0/n_vert, cost_6_in*1.0/n_vert, cost_6_out*1.0/n_vert, cost_6_thick*1.0/n_vert, all_pred_6_in, all_pred_6_out]

#In[2]
# training:
np.random.seed(42)

iter_train             = 0
cost_train_avg         = []
cost_train_6_in_avg    = []
cost_train_6_out_avg   = []
cost_train_6_thick_avg = []
grad_norm_train_avg    = []

cost_test_avg         = []
cost_test_6_in_avg    = []
cost_test_6_out_avg   = []
cost_test_6_thick_avg = []

grad_norm_test_avg   = []
iter_test            = []

#training code
for x_ in ds.test_fwd(): #shape used as reference for checking the goodness of the trained models at training time
    test_shape = x_
    break

max_num_iter = 25000

num_fast_iter = 5000

batch_dim = 60 #100
test_interval = 50

print("max_num_iter = %d, batch_dim = %d, test_interval = %d" % (max_num_iter, batch_dim, test_interval))

reg_exp_dump_model = os.path.join(path_dumps, 'pkl/06/out_in/gcnn06_%d_epoch=%d.pkl')

path_output_6 = os.path.join(path_dumps, 'mat/06/out_in/gcnn06_batch_dim=%d') % (batch_dim)

if not os.path.exists(path_output_6):
    os.mkdir(path_output_6) 

perm_vert = np.random.permutation(n_vert)
idx_analyzed_vert = []

for i in range(max_num_iter):
    tic = time.time()
    cost_train          = []
    cost_train_6_in     = []
    cost_train_6_out    = []
    cost_train_6_thick  = []
    cost_test           = []
    cost_test_6_in      = []
    cost_test_6_out     = []
    cost_test_6_thick   = []
    grad_norm_train     = []
    grad_norm_test      = []

    num_tot_vert_analyzed = 0
    for x_ in ds.train_iter():    

        flag_6 = x_[0]
        cPr    = x_[10]
        cPt    = x_[11]
        cPr.setdiag(1e-14)
        
        if (len(perm_vert)<batch_dim):
            perm_vert = np.random.permutation(n_vert)
            idx_analyzed_vert = []
                
        list_selected_nodes, list_all_neighbors, compute_label_mask_l2_m3_rt, mask_neighbors_l2_m3_rt, compute_label_mask_l1_m3_rt, mask_neighbors_l1_m3_rt, compute_label_mask_l3_m6_rt, mask_neighbors_l3_m6_rt, compute_label_mask_l2_m6_rt, mask_neighbors_l2_m6_rt, compute_label_mask_l1_m6_rt, mask_neighbors_l1_m6_rt = utilities_shape_36.exctract_portion_shape(cPr, perm_vert[0], idx_analyzed_vert, x_[12], min_dim_batch=100)
 
        #Computation of the indexes of the selected vertices from the masks
        idx_mask_neighbors_l1_m3 = np.squeeze(np.asarray(np.where(mask_neighbors_l1_m3_rt)))
        idx_compute_label_mask_l1_m3 = np.squeeze(np.asarray(np.where(compute_label_mask_l1_m3_rt)))
        idx_mask_neighbors_l2_m3 = np.squeeze(np.asarray(np.where(mask_neighbors_l2_m3_rt)))
        idx_compute_label_mask_l2_m3 = np.squeeze(np.asarray(np.where(compute_label_mask_l2_m3_rt)))
        
        idx_mask_neighbors_l1_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l1_m6_rt)))
        idx_compute_label_mask_l1_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l1_m6_rt)))
        idx_mask_neighbors_l2_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l2_m6_rt)))
        idx_compute_label_mask_l2_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l2_m6_rt)))
        idx_mask_neighbors_l3_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l3_m6_rt)))
        idx_compute_label_mask_l3_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l3_m6_rt)))

        #Extraction of the portion of the shape we should exploit in the test phase
        cPr_sel = cPr[:, list_all_neighbors][list_selected_nodes, :].todense()
        cPt_sel = cPt[:, list_all_neighbors][list_selected_nodes, :].todense()

        #Extraction of the descriptors and labels we should exploit in the test phase
        desc_in_sel      = x_[1][list_all_neighbors, :]
        desc_out_sel     = x_[2][list_all_neighbors, :]

        target_6_in_sel  = x_[7][list_selected_nodes]
        target_6_out_sel = x_[8][list_selected_nodes]
        thick_6_sel      = x_[9][list_selected_nodes]
        
        if (idx_compute_label_mask_l3_m6.shape!=()):
            target_6_in_sel  = np.asarray(target_6_in_sel)[idx_compute_label_mask_l3_m6] 
            target_6_out_sel = np.asarray(target_6_out_sel)[idx_compute_label_mask_l3_m6]
            thick_6_sel      = np.asarray(thick_6_sel)[idx_compute_label_mask_l3_m6]
        else:
            target_6_in_sel  = [np.asarray(target_6_in_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]
            target_6_out_sel = [np.asarray(target_6_out_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]
            thick_6_sel      = [np.asarray(thick_6_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]

            idx_compute_label_mask_l2_m6 = [np.asscalar(idx_compute_label_mask_l3_m6)]
        
        #Training
        parameters_train = (flag_3, flag_6, desc_in_sel, desc_out_sel, cPr_sel, cPt_sel, target_3_in_sel, target_3_out_sel, target_6_in_sel, target_6_out_sel, thick_3_sel, thick_6_sel, \
                           idx_compute_label_mask_l1_m3, idx_mask_neighbors_l1_m3, idx_compute_label_mask_l2_m3, idx_mask_neighbors_l2_m3, \
                           idx_compute_label_mask_l1_m6, idx_mask_neighbors_l1_m6, idx_compute_label_mask_l2_m6, idx_mask_neighbors_l2_m6, idx_compute_label_mask_l3_m6, idx_mask_neighbors_l3_m6)
        
        if (i < num_fast_iter):
            tmp = funcs['train_f'](*parameters_train)
        else:
            tmp = funcs['train_s'](*parameters_train)

        
        #Statistics computation
        cost_train.append(tmp[0]*len(idx_compute_label_mask_l3_m6))
        cost_train_6_in.append(tmp[1]*len(idx_compute_label_mask_l3_m6))
        cost_train_6_out.append(tmp[2]*len(idx_compute_label_mask_l3_m6))
        cost_train_6_thick.append(tmp[3]*len(idx_compute_label_mask_l3_m6))

        grad_norm_train.append(tmp[5]*len(idx_compute_label_mask_l3_m6))
        num_tot_vert_analyzed += len(idx_compute_label_mask_l3_m6)
        
        #Updating of the lists associated to the remaining vertices we still have to process
        perm_vert = list(set(perm_vert) - set(np.asarray(list_selected_nodes)[idx_compute_label_mask_l3_m6]))
        idx_analyzed_vert += np.asarray(list_selected_nodes)[idx_compute_label_mask_l3_m6].tolist()
        
    if (i % 1) == 0: #printing the training statistics
        cost_train_avg.append(np.sum(cost_train)/num_tot_vert_analyzed)
        cost_train_6_in_avg.append(np.sum(cost_train_6_in)/num_tot_vert_analyzed)
        cost_train_6_out_avg.append(np.sum(cost_train_6_out)/num_tot_vert_analyzed)
        cost_train_6_thick_avg.append(np.sum(cost_train_6_thick)/num_tot_vert_analyzed)

        grad_norm_train_avg.append(np.sum(grad_norm_train)/num_tot_vert_analyzed)
        print("[TRN] epoch = %03i, cost = %3.2e, |grad| = %.2e (%03.2fs)" % (len(cost_train_avg), cost_train_avg[-1], grad_norm_train_avg[-1], time.time() - tic))
        print("      cost_6_in = %3.2e, cost_6_out = %3.2e, cost_6_thick = %3.2e" % (cost_train_6_in_avg[-1], cost_train_6_out_avg[-1], cost_train_6_thick_avg[-1]))

    if (len(cost_train_avg) % test_interval) == 0: #printing the test statistics
        for k,d in enumerate(ds.test_fwd()):
            iter_test.append(len(cost_train_avg))
            tic = time.time()
            cost_test, cost_test_6_in, cost_test_6_out, cost_test_6_thick, tmp_pred_6_in, tmp_pred_6_out = test_model(test_shape, n_vert)  
            
            cost_test_avg.append(cost_test)
            cost_test_6_in_avg.append(cost_test_6_in)
            cost_test_6_out_avg.append(cost_test_6_out)
            cost_test_6_thick_avg.append(cost_test_6_thick)
            
            fname_tmp_6_in  = os.path.join(path_output_6, "ep=%i_for_%s" % (len(cost_train_avg), ds.names_test_in[k]))
            print(fname_tmp_6_in)
            fname_tmp_6_out = os.path.join(path_output_6, "ep=%i_for_%s" % (len(cost_train_avg), ds.names_test_out[k]))
            print(fname_tmp_6_out)
            io.matlab.mio.savemat(fname_tmp_6_in, {'pred_6': tmp_pred_6_in})
            io.matlab.mio.savemat(fname_tmp_6_out, {'pred_6': tmp_pred_6_out})
            print("[TST] epoch = %03i, total cost = %3.2e (%03.2fs)" % (len(cost_train_avg), cost_train_avg[-1], time.time() - tic))
           print("      cost_6_in = %3.2e, cost_6_out = %3.2e, cost_6_thick = %3.2e)" % (cost_test_6_in_avg[-1], cost_test_6_out_avg[-1], cost_test_6_thick_avg[-1]))

            # save model
            params_opt  = LL.get_all_param_values([desc_6_in, desc_6_out]) 
            experiment_stuff  = [cost_train_avg, cost_test_avg, params_opt, desc_6_in, desc_6_out] 
            name_dump  = reg_exp_dump_model % (batch_dim, len(cost_train_avg))
            with open(name_dump, 'wb') as f: 
                cPickle.dump(experiment_stuff, f)
        


# Code for updating the learning rate if required for convergence
# available choices
updates = L.updates.adam(grad, params, learning_rate=1e-5) 
# updates = L.updates.momentum(grad, params, learning_rate=1.0, momentum=0.9)
# updates = L.updates.adagrad(grad, params, learning_rate=1e-4)
# updates = L.updates.adadelta(grad, params, learning_rate=1e-4)

funcs['train'] = theano.function([flag_6, desc_0_in.input_var, desc_0_out.input_var, P_rho.input_var, P_theta.input_var, target_6_in, target_6_out,thick_6, \
                                 idx_node_l1_m3.input_var, idx_neighbors_l1_m3.input_var, idx_node_l2_m3.input_var, idx_neighbors_l2_m3.input_var, \
                                 idx_node_l1_m6.input_var, idx_neighbors_l1_m6.input_var, idx_node_l2_m6.input_var, idx_neighbors_l2_m6.input_var, idx_node_l3_m6.input_var, idx_neighbors_l3_m6.input_var],
                                [cost, cost_dataterm_6_in, cost_dataterm_6_out, cost_dataterm_6_thick, cost_reg, grad_norm], 
                                updates = updates, 
                                allow_input_downcast='True',
                                on_unused_input = 'warn')


#Code required for computing the KIMs over the test set
def test_model_pred(x_, n_vert):
  
    flag_6 = x_[0]
    cPr    = x_[10]
    cPt    = x_[11]

    perm_vert = range(n_vert)
    idx_analyzed_vert = []
    cPr.setdiag(1e-14)

    overall_cost = 0 
    cost_6_in    = 0
    cost_6_out   = 0
    cost_6_thick = 0

    all_pred_6_in  = np.zeros((n_vert, n_out))
    all_pred_6_out = np.zeros((n_vert, n_out)) 
    
    while(1):
        if (len(perm_vert)==0):
            break
            
        list_selected_nodes, list_all_neighbors, compute_label_mask_l2_m3_rt, mask_neighbors_l2_m3_rt, compute_label_mask_l1_m3_rt, mask_neighbors_l1_m3_rt, compute_label_mask_l3_m6_rt, mask_neighbors_l3_m6_rt, compute_label_mask_l2_m6_rt, mask_neighbors_l2_m6_rt, compute_label_mask_l1_m6_rt, mask_neighbors_l1_m6_rt = utilities_shape_36.exctract_portion_shape(cPr, perm_vert[0], idx_analyzed_vert, x_[12], min_dim_batch=100)
 
        #Computation of the indexes of the selected vertices from the masks
        idx_mask_neighbors_l1_m3 = np.squeeze(np.asarray(np.where(mask_neighbors_l1_m3_rt)))
        idx_compute_label_mask_l1_m3 = np.squeeze(np.asarray(np.where(compute_label_mask_l1_m3_rt)))
        idx_mask_neighbors_l2_m3 = np.squeeze(np.asarray(np.where(mask_neighbors_l2_m3_rt)))
        idx_compute_label_mask_l2_m3 = np.squeeze(np.asarray(np.where(compute_label_mask_l2_m3_rt)))
        
        idx_mask_neighbors_l1_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l1_m6_rt)))
        idx_compute_label_mask_l1_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l1_m6_rt)))
        idx_mask_neighbors_l2_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l2_m6_rt)))
        idx_compute_label_mask_l2_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l2_m6_rt)))
        idx_mask_neighbors_l3_m6 = np.squeeze(np.asarray(np.where(mask_neighbors_l3_m6_rt)))
        idx_compute_label_mask_l3_m6 = np.squeeze(np.asarray(np.where(compute_label_mask_l3_m6_rt)))

        #Extraction of the portion of the shape we should exploit in the test phase
        cPr_sel = cPr[:, list_all_neighbors][list_selected_nodes, :].todense()
        cPt_sel = cPt[:, list_all_neighbors][list_selected_nodes, :].todense()

        #Extraction of the descriptors and labels we should exploit in the test phase
        desc_in_sel      = x_[1][list_all_neighbors, :]
        desc_out_sel     = x_[2][list_all_neighbors, :]

        target_6_in_sel  = x_[7][list_selected_nodes]
        target_6_out_sel = x_[8][list_selected_nodes]
        thick_6_sel      = x_[9][list_selected_nodes]
             
        if (idx_compute_label_mask_l3_m6.shape!=()):
            target_6_in_sel  = np.asarray(target_6_in_sel)[idx_compute_label_mask_l3_m6] 
            target_6_out_sel = np.asarray(target_6_out_sel)[idx_compute_label_mask_l3_m6]
            thick_6_sel      = np.asarray(thick_6_sel)[idx_compute_label_mask_l3_m6]
        else: 
            target_6_in_sel  = [np.asarray(target_6_in_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]
            target_6_out_sel = [np.asarray(target_6_out_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]
            thick_6_sel      = [np.asarray(thick_6_sel)[np.asscalar(idx_compute_label_mask_l3_m6)]]

            idx_compute_label_mask_l3_m6 = [np.asscalar(idx_compute_label_mask_l3_m6)]
        
        list_selected_nodes = np.asarray(list_selected_nodes)
        
        #Testing
        parameters_test = (flag_3, flag_6, desc_in_sel, desc_out_sel, cPr_sel, cPt_sel, target_3_in_sel, target_3_out_sel, target_6_in_sel, target_6_out_sel, thick_3_sel, thick_6_sel, \
                           idx_compute_label_mask_l1_m3, idx_mask_neighbors_l1_m3, idx_compute_label_mask_l2_m3, idx_mask_neighbors_l2_m3, \
                           idx_compute_label_mask_l1_m6, idx_mask_neighbors_l1_m6, idx_compute_label_mask_l2_m6, idx_mask_neighbors_l2_m6, idx_compute_label_mask_l3_m6, idx_mask_neighbors_l3_m6)
        tmp = funcs['pred'](*parameters_test)
 
        #Statistics computation
        all_pred_6_in[list_selected_nodes[idx_compute_label_mask_l2_m6],:]  = tmp[6] 
        all_pred_6_out[list_selected_nodes[idx_compute_label_mask_l2_m6],:] = tmp[7] 

        overall_cost += tmp[0]*len(idx_compute_label_mask_l2_m6)

        cost_6_in    += tmp[1]*len(idx_compute_label_mask_l2_m6)
        cost_6_out   += tmp[2]*len(idx_compute_label_mask_l2_m6)
        cost_6_thick += tmp[3]*len(idx_compute_label_mask_l2_m6)

        #Updating of the lists associated to the remaining vertices we still have to process
        perm_vert = list(set(perm_vert) - set(np.asarray(list_selected_nodes)[idx_compute_label_mask_l3_m6]))
        idx_analyzed_vert += np.asarray(list_selected_nodes)[idx_compute_label_mask_l3_m6].tolist()
    
    return [overall_cost*1.0/n_vert, cost_6_in*1.0/n_vert, cost_6_out*1.0/n_vert, cost_6_thick*1.0/n_vert, all_pred_6_in, all_pred_6_out]


#Code for saving the KIMs of the trained model      
for i,d in enumerate(ds.test_fwd()):
    fname_6_in  = os.path.join(path_output_6, "%s_final" % ds.names_test_in[i])
    fname_6_out = os.path.join(path_output_6, "%s_final" % ds.names_test_out[i])
    print(fname_6_in),
    print(fname_6_out),
    current_cost, current_cost_6_in, current_cost_6_out, current_cost_6_thick, current_pred_6_in, current_pred_6_out = test_model_pred(d, n_vert) 
    io.matlab.mio.savemat(fname_6_in, {'pred_6': current_pred_6_in})
    io.matlab.mio.savemat(fname_6_out, {'pred_6': current_pred_6_out})
    print("[PRED] pred_cost_6_in = %3.2e, pred_cost_6_out = %3.2e, pred_cost_6_thick = %3.2e" % (current_cost_6_in, current_cost_6_in, current_cost_6_thick))