# GCNN-for-Longitudinal-Prediction
Deep Modeling of Growth Trajectories for Longitudinal Prediction of Missing Infant Cortical Surfaces

Charting cortical growth trajectories is of paramount importance for understanding brain development. However, such analysis necessitates the collection of longitudinal data, which can be challenging due to subject dropouts and failed scans. In this paper, we will introduce a method for longitudinal prediction of cortical surfaces using a spatial graph convolutional neural network (GCNN), which extends conventional CNNs from Euclidean to curved manifolds. The proposed method is designed to model the cortical growth trajectories and jointly predict inner and outer cortical surfaces at multiple time points. Adopting a binary flag in loss calculation to deal with missing data, we fully utilize all available cortical surfaces for training our deep learning model, without requiring a complete collection of longitudinal data. Predicting the surfaces directly allows cortical attributes such as cortical thickness, curvature, and convexity to be computed for subsequent analysis. We will demonstrate with experimental results that our method is capable of capturing the nonlinearity of spatiotemporal cortical growth patterns and can predict cortical surfaces with improved accuracy.
