# auxiliary functions (used for importing matlab files in python):
import h5py
import numpy as np
import scipy.sparse as sp
import os
import pickle as cPickle

def load_matlab_file(path_file, name_field):
    """
    load '.mat' files
    inputs:
        path_file, string containing the file path
        name_field, string containig the field name (default='shape')
    warning:
        '.mat' files should be saved in the '-v7.3' format
    """
    db = h5py.File(path_file, 'r')
    ds = db[name_field]
    try:
        if 'ir' in ds.keys():
            data = np.asarray(ds['data'])
            ir   = np.asarray(ds['ir'])
            jc   = np.asarray(ds['jc'])
            out  = sp.csc_matrix((data, ir, jc)).astype(np.float32)
    except AttributeError:
        # Transpose in case is a dense matrix because of the row- vs column- major ordering between python and matlab
        out = np.asarray(ds).astype(np.float_).T  #float32

    db.close()

    return out

# stack 2D matrices into a 3D tensor
def stack_matrices(x):
    y = np.zeros((x.shape[0], x.shape[0], 2), dtype=np.float_) #float32  
    y[:,:,0] = x[:,:x.shape[1]//2]
    y[:,:,1] = x[:,x.shape[1]//2:]
    return y


# dataset loading

class Dataset(object):
    def __init__(self, files_train_in, files_train_out, files_test_in, files_test_out, path_flags_3, path_flags_6, path_descs_0, path_patches, path_labels_3, path_labels_6, path_thick_3, path_thick_6, epoch_size=10, #100
                 path_dump_neighbors='/Users/peirong/Documents/Cycle/036/dumps/036.pkl', max_dist_neighbor=2e-2):
        
        self.path_dump_neighbors = path_dump_neighbors # path to adjacency matrix
        self.max_dist_neighbor = max_dist_neighbor

        # train / test instances
        self.files_train_in  = files_train_in
        self.files_train_out = files_train_out
        self.files_test_in   = files_test_in
        self.files_test_out  = files_test_out

        # path to masks
        self.path_flags_3 = path_flags_3
        self.path_flags_6 = path_flags_6

        # path to (pre-computed) descriptors
        self.path_descs_0 = path_descs_0

        # path to (pre-computed) patches
        self.path_patches = path_patches

        # path to labels
        self.path_labels_3 = path_labels_3
        self.path_labels_6 = path_labels_6
        self.path_thick_3  = path_thick_3
        self.path_thick_6  = path_thick_6

        # epoch size
        self.epoch_size = epoch_size
        print(self.epoch_size)
        
        # loading train / test names
        with open(self.files_train_in, 'r') as f:
            self.names_train_in = [line.rstrip() for line in f]
        with open(self.files_test_in, 'r') as f:
            self.names_test_in = [line.rstrip() for line in f]
        with open(self.files_train_out, 'r') as f:
            self.names_train_out = [line.rstrip() for line in f]
        with open(self.files_test_out, 'r') as f:
            self.names_test_out = [line.rstrip() for line in f]
        
        # loading train / test flags
        self.flags_3_train = []
        self.flags_3_test  = []
        self.flags_6_train = []
        self.flags_6_test  = []

        print("[i] Loading train flags")
        for name in self.names_train_in:
            tmp_3 = load_matlab_file(os.path.join(self.path_flags_3, name), 'flag') 
            self.flags_3_train.append(self.compute_flags(tmp_3))
            tmp_6 = load_matlab_file(os.path.join(self.path_flags_6, name), 'flag') 
            self.flags_6_train.append(self.compute_flags(tmp_6))

        print("[i] Loading test  flags")
        for name in self.names_test_in:
            tmp_3 = load_matlab_file(os.path.join(self.path_flags_3, name), 'flag') 
            self.flags_3_test.append(self.compute_flags(tmp_3))
            tmp_6 = load_matlab_file(os.path.join(self.path_flags_6, name), 'flag') 
            self.flags_6_test.append(self.compute_flags(tmp_6))

        # loading the descriptors

        self.descs_0_train_in  = []
        self.descs_0_train_out = []
        self.descs_0_test_in   = []
        self.descs_0_test_out  = []
        
        print("[i] Loading train descs")
        for name in self.names_train_in:
            tmp = load_matlab_file(os.path.join(self.path_descs_0, name), 'desc')
            self.descs_0_train_in.append(tmp)
        for name in self.names_train_out:
            tmp = load_matlab_file(os.path.join(self.path_descs_0, name), 'desc')
            self.descs_0_train_out.append(tmp)
        print("[i] Loading test  descs")
        for name in self.names_test_in:
            tmp = load_matlab_file(os.path.join(self.path_descs_0, name), 'desc')
            self.descs_0_test_in.append(tmp)
        for name in self.names_test_out:
            tmp = load_matlab_file(os.path.join(self.path_descs_0, name), 'desc')
            self.descs_0_test_out.append(tmp)
        
        # loading the patches
        self.P_rho_data_train    = []
        self.P_rho_indices_train = []
        self.P_rho_indptr_train  = []
        
        self.P_theta_data_train    = []
        self.P_theta_indices_train = []
        self.P_theta_indptr_train  = []
        
        self.P_rho_data_test    = []
        self.P_rho_indices_test = []
        self.P_rho_indptr_test  = []
        
        self.P_theta_data_test    = []
        self.P_theta_indices_test = []
        self.P_theta_indptr_test  = []
        
        self.P_rho_train = []
        self.P_theta_train = []
        self.P_rho_test = []
        self.P_theta_test = []
        
        if (os.path.isfile(self.path_dump_neighbors)==False):
            self.neighbors_train = []
            self.neighbors_test = []
            compute_neighbors_flag = True
        else:
            compute_neighbors_flag = False
            with open(self.path_dump_neighbors, 'rb') as f:
                self.neighbors_train, self.neighbors_test = cPickle.load(f)
        
        n_vert = self.descs_0_train_in[0].shape[0]

        print("[i] Loading train patches")
        for name in self.names_train_in:
            P = load_matlab_file(os.path.join(self.path_patches, name), 'patch_coord') 
            self.P_rho_train.append(P[:,:n_vert])
            if (compute_neighbors_flag==True): 
                self.neighbors_train.append(self.compute_neighbors(P[:,:n_vert]))
            self.P_rho_data_train.append(P[:,:n_vert].data)
            self.P_rho_indices_train.append(P[:,:n_vert].indices.astype(np.int32))
            self.P_rho_indptr_train.append(P[:,:n_vert].indptr.astype(np.int32))
            self.P_theta_train.append(P[:,n_vert:])
            self.P_theta_data_train.append(P[:,n_vert:].data)
            self.P_theta_indices_train.append(P[:,n_vert:].indices.astype(np.int32))
            self.P_theta_indptr_train.append(P[:,n_vert:].indptr.astype(np.int32))
            
        print("[i] Loading test  patches")
        for name in self.names_test_in:
            P = load_matlab_file(os.path.join(self.path_patches, name), 'patch_coord')
            self.P_rho_test.append(P[:,:n_vert])
            if (compute_neighbors_flag==True):  
                self.neighbors_test.append(self.compute_neighbors(P[:,:n_vert]))
            self.P_rho_data_test.append(P[:,:n_vert].data)
            self.P_rho_indices_test.append(P[:,:n_vert].indices.astype(np.int32))
            self.P_rho_indptr_test.append(P[:,:n_vert].indptr.astype(np.int32))
            self.P_theta_test.append(P[:,n_vert:])
            self.P_theta_data_test.append(P[:,n_vert:].data)
            self.P_theta_indices_test.append(P[:,n_vert:].indices.astype(np.int32))
            self.P_theta_indptr_test.append(P[:,n_vert:].indptr.astype(np.int32))

        if (compute_neighbors_flag==True):
            print(os.getcwd())
            print(self.path_dump_neighbors)
            with open(self.path_dump_neighbors, 'wb') as f:  
                cPickle.dump([self.neighbors_train, self.neighbors_test], f)

        # loading the labels
        self.labels_3_train_in  = []
        self.labels_3_train_out = []
        self.labels_3_test_in   = []
        self.labels_3_test_out  = []
        self.labels_6_train_in  = []
        self.labels_6_train_out = []
        self.labels_6_test_in   = []
        self.labels_6_test_out  = []

        self.thick_3_train      = []
        self.thick_3_test       = []
        self.thick_6_train      = []
        self.thick_6_test       = []

        print("[i] Loading train labels")
        for name in self.names_train_in:
            tmp_3 = load_matlab_file(os.path.join(self.path_labels_3, name), 'desc')
            self.labels_3_train_in.append(tmp_3)
            tmp_6 = load_matlab_file(os.path.join(self.path_labels_6, name), 'desc')
            self.labels_6_train_in.append(tmp_6)

            tmp_thick_3 = load_matlab_file(os.path.join(self.path_thick_3, name), 'desc')
            self.thick_3_train.append(tmp_thick_3)
            tmp_thick_6 = load_matlab_file(os.path.join(self.path_thick_6, name), 'desc')
            self.thick_6_train.append(tmp_thick_6)

        for name in self.names_train_out:
            tmp_3 = load_matlab_file(os.path.join(self.path_labels_3, name), 'desc')
            self.labels_3_train_out.append(tmp_3)
            tmp_6 = load_matlab_file(os.path.join(self.path_labels_6, name), 'desc')
            self.labels_6_train_out.append(tmp_6)

        print("[i] Loading test labels")
        for name in self.names_test_in:
            tmp_3 = load_matlab_file(os.path.join(self.path_labels_3, name), 'desc')
            self.labels_3_test_in.append(tmp_3)
            tmp_6 = load_matlab_file(os.path.join(self.path_labels_6, name), 'desc')
            self.labels_6_test_in.append(tmp_6)

            tmp_thick_3 = load_matlab_file(os.path.join(self.path_thick_3, name), 'desc')
            self.thick_3_test.append(tmp_thick_3)
            tmp_thick_6 = load_matlab_file(os.path.join(self.path_thick_6, name), 'desc')
            self.thick_6_test.append(tmp_thick_6)

        for name in self.names_test_out:
            tmp_3 = load_matlab_file(os.path.join(self.path_labels_3, name), 'desc')
            self.labels_3_test_out.append(tmp_3)
            tmp_6 = load_matlab_file(os.path.join(self.path_labels_6, name), 'desc')
            self.labels_6_test_out.append(tmp_6)


    def compute_flags(self, flag_input):
        if (flag_input.mean()>=1e-1):
            flag = 1.0
        else:
            flag = 0.0
        return flag

    def compute_neighbors(self, cPr): 
        cPr.setdiag(1e-14)
        list_all_neighbors = (cPr>=1e-15).multiply(cPr<=self.max_dist_neighbor)
        return list_all_neighbors
    
    def train_iter(self):
        for i in range(self.epoch_size):
            idx = np.random.permutation(len(self.names_train_in))[0]
            yield (self.flags_3_train[idx], self.flags_6_train[idx], self.descs_0_train_in[idx], self.descs_0_train_out[idx], self.P_rho_data_train[idx], self.P_theta_data_train[idx], 
                    self.P_rho_indices_train[idx], self.P_rho_indptr_train[idx], self.labels_3_train_in[idx], self.labels_3_train_out[idx], self.labels_6_train_in[idx], self.labels_6_train_out[idx], self.thick_3_train[idx], self.thick_6_train[idx], 
                    self.P_rho_train[idx], self.P_theta_train[idx], self.neighbors_train[idx])
         
    def train_fwd(self):
        for idx in range(len(self.names_train_in)): 
            yield (self.flags_3_train[idx], self.flags_6_train[idx], self.descs_0_train_in[idx], self.descs_0_train_out[idx], self.P_rho_data_train[idx], self.P_theta_data_train[idx], 
                    self.P_rho_indices_train[idx], self.P_rho_indptr_train[idx], self.labels_3_train_in[idx], self.labels_3_train_out[idx], self.labels_6_train_in[idx], self.labels_6_train_out[idx], self.thick_3_train[idx], self.thick_6_train[idx], 
                    self.P_rho_train[idx], self.P_theta_train[idx], self.neighbors_train[idx])
         
    def test_fwd(self):
        for idx in range(len(self.names_test_in)):  
            yield (self.flags_3_test[idx], self.flags_6_test[idx], self.descs_0_test_in[idx], self.descs_0_test_out[idx], self.P_rho_data_test[idx], self.P_theta_data_test[idx], 
                    self.P_rho_indices_test[idx], self.P_rho_indptr_test[idx], self.labels_3_test_in[idx], self.labels_3_test_out[idx], self.labels_6_test_in[idx], self.labels_6_test_out[idx], self.thick_3_test[idx], self.thick_6_test[idx],  # start: 6
                    self.P_rho_test[idx], self.P_theta_test[idx], self.neighbors_test[idx])  # start: 14
