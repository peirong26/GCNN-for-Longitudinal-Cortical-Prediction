import theano.tensor as T
import lasagne.layers as LL
import numpy as np

#######################################Definition of the layers used for constructing the gmm model######################
class GaussianWeightsLayer(LL.MergeLayer):
    """
    Layer computing gaussian weights as patch operator
    """
    def __init__(self, incoming, n_rho, n_theta, **kwargs):
        super(GaussianWeightsLayer, self).__init__(incoming, **kwargs)
        # layer's attributes
        self.n_rho       = n_rho  
        self.n_theta     = n_theta 
        max_rho = 0.1 #0.04
        sigma_rho = 0.01 #0.005
        sigma_theta = 0.25
        self.range_rho   = [0.0, 0.1] #[0.0, 0.04]
        self.range_theta = [-np.pi, np.pi]
        self.sigma_rho   = 0.01 # 0.005
        self.sigma_theta = 0.25 #0.25

        print("n_rho = %03i, n_theta = %03i, max_rho = %03.6f, sigma_rho = %03.6f, sigma_theta = %03.6f" % (n_rho, n_theta, max_rho, sigma_rho, sigma_theta))
        
        grid_rho   = np.linspace(self.range_rho[0], self.range_rho[1], num=n_rho+1)
        grid_rho   = grid_rho[1:]
        grid_theta = np.linspace(self.range_theta[0], self.range_theta[1], num=n_theta+1)
        grid_theta = grid_theta[:-1]
        
        grid_rho_, grid_theta_ = np.meshgrid(grid_rho, grid_theta, sparse=False)
        grid_rho_   = grid_rho_.T   # the transpose here is needed to have the same behaviour as Matlab code
        grid_theta_ = grid_theta_.T # the transpose here is needed to have the same behaviour as Matlab code
        grid_rho_   = grid_rho_.flatten()
        grid_theta_ = grid_theta_.flatten()

        coords = np.concatenate((grid_rho_[None,:], grid_theta_[None,:]), axis = 0)
        coords = coords.T # every row contains the coordinates of a grid intersection
        
        self.coords = self.add_param(coords.astype(np.float_), coords.shape, name='coords') #float32
        self.sigma_rho = self.add_param((np.ones((coords.shape[0],))*self.sigma_rho).astype(np.float_), (coords.shape[0],), name='sigma_rho')  #float32
        self.sigma_theta = self.add_param((np.ones((coords.shape[0],))*self.sigma_theta).astype(np.float_), (coords.shape[0],), name='sigma_theta')  #float32
        self.sigma_rho = self.sigma_rho.dimshuffle('x','x', 0)
        self.sigma_theta = self.sigma_theta.dimshuffle('x','x', 0)   # A.dimshuffle('x','x', 0) => ([ [ [ A ] ] ])
            
    def get_output_shape_for(self, input_shapes):
        return (input_shapes[0][0], input_shapes[0][1], self.n_rho*self.n_theta)

    def get_output_for(self, inputs, **kwargs):

        P_rho, P_theta = inputs
        
        mu_rho   = self.coords[:,0]
        mu_theta = self.coords[:,1]
        mu_rho   = mu_rho.dimshuffle('x','x',0)
        mu_theta = mu_theta.dimshuffle('x','x',0)
        
        P_rho   = P_rho.dimshuffle(0, 1, 'x')
        P_theta = P_theta.dimshuffle(0, 1, 'x')

        weights_rho   = []
        weights_theta = []
        
        mask = T.ge(P_rho, 1e-15)
        
        weights_rho = T.exp(-0.5*T.sqr((P_rho-mu_rho)/(1e-14+self.sigma_rho)))
        weights_theta = T.exp(-0.5*T.sqr((P_theta-mu_theta)/(1e-14+self.sigma_theta)))
        weights = weights_rho * weights_theta
        
        weights = T.switch(mask, weights, 0)
        
        return weights
    
class ApplyDescLayer(LL.MergeLayer):
    """
    Layer computing the value of each bin. It retrieves a binning for each vertex
    """
    def __init__(self, incoming, **kwargs): #(self, incoming, params_opt, **kwargs):
        super(ApplyDescLayer, self).__init__(incoming, **kwargs)
        
    def get_output_shape_for(self, input_shapes):
        return (input_shapes[0][0], input_shapes[1][1], input_shapes[0][2]) #self.n_bin

    def get_output_for(self, inputs, **kwargs):
        weights, desc = inputs
        #import pdb
        #pdb.set_trace()
        res = T.dot(weights.dimshuffle(2,0,1), desc).dimshuffle(1,2,0) #num_samples, num_feat, num_bin

        return res
    
class ApplyDescLayerMask(LL.MergeLayer):
    """
    Layer computing the value of each bin. It retrieves a binning only for the vertices specified in the idx_node_to_compute_output
    """
    def __init__(self, incoming, **kwargs):
        super(ApplyDescLayerMask, self).__init__(incoming, **kwargs)
        
    def get_output_shape_for(self, input_shapes):
        return (input_shapes[3][0], input_shapes[1][1], input_shapes[0][2])

    def get_output_for(self, inputs, **kwargs):
        weights, desc, idx_node_to_compute_output, idx_neighbors_conv = inputs
        
        weights = weights[idx_node_to_compute_output, :, :][:, idx_neighbors_conv, :]
        res = T.dot(weights.dimshuffle(2,0,1), desc).dimshuffle(1,2,0)
      
        return res
    