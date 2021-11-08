# extreme clustering– A clustering method via density extreme points
Extreme clustering ([paper link](https://www.sciencedirect.com/science/article/pii/S0020025520306587)) is a clustering algorithm, which is to identify density extreme points to find cluster centers. Extreme clustering performance is very outstanding, and it is not affected by the number, size, and shape of clusters, as well as the differences in density and compactness between clusters. Extreme clustering has high robustness on diverse datasets. On unbalance datasets and noise datasets, the clustering results of extreme clustering are vastly superior to other algorithms. we compared extreme clustering with other 10 clustering algorithms on 8 datasets, and the results show that extreme clustering consistent outperforms baselines.
## Code version
We provide two code versions, namely: 
+ Python
+ MATLAB
## Instructions for use
1. you should open MATLAB, put 'Extreme_Clustering.m' and 'Visualization.m'  into the current folder of MATLAB, and enter the following command in the MATLAB command window:
<pre><code>clear all
data=load('data-sets/s1.txt');    % s1.txt can be relpacecd by any other data set under the 'data-sets' folder. 
clustering_result = Extreme_Clustering(data,70000,false);   %'70000' is the value of δ meaning the radius of neighborhood, and 'false' is the value of  parameter 'isGaussian' which determines whether to calculate density by Gaussian Kernel.
Visualization(data,clustering_result,false);  %'false' is the value of parameter 'is_showingnoise' which determines whether to show noise.
</code></pre>
2. If you want to perform face clustering experiment, you should put all files under the folder 'Face Clustering' into the current folder of MATLAB, and enter the following command in the MATLAB command window:
<pre><code>clear all
Extreme_clustering_face
</code></pre>
## Note
If you want to test extreme clustering on 'flame', 'spiral' or 'a3' data set, you should set 'isGaussian' to 'true'.
