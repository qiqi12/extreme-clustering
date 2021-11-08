import numpy as np
from  Extreme_Clustering import Extreme_Clustreing
from  Visualization import Visualization


data = np.loadtxt("data-sets/s1.txt")
clusteringResult = Extreme_Clustreing(data, 70000, False)
Visualization(data, clusteringResult, False)