import numpy as np
from scipy.spatial.distance import pdist
from scipy.spatial.distance import squareform
import matplotlib.pyplot as plt

def Extreme_Clustreing(data, neighbuorhood_radius = 0.2, isGaussian=False):
    number = data.shape[0]
    dim = data.shape[1]
    dist1 = pdist(data,metric='euclidean')
    dist = squareform(dist1)
    c = np.ones((number,number),dtype = int)
    b = dist
    for cow in range(number):
        c[cow] = np.argsort(b[cow])
        b[cow] = np.sort(dist[cow])
    
    #Computting density
    if isGaussian==False:
        density_radius = np.mean(b[:,(int)((number)*0.02)-1])
        density = np.zeros((number),dtype=int)
        for i in range(number):
            j = 0
            while b[i,j]<density_radius:
                j += 1
            density[i] = j+1
    else:
        position = np.round((number)*0.013) - 1
        dist = squareform(dist1)
        sda = np.sort(dist,axis = 0)
        cow = (int)(position%number)
        column = (int)(position/number)
        dc = sda[cow,column]
        density = np.zeros((number))
        for i in range(number-1):
            for j in range(i+1,number):
                density[i] = density[i] + np.exp(-(dist[i,j]/dc)*(dist[i,j]/dc))
                density[j] = density[j] + np.exp(-(dist[i,j]/dc)*(dist[i,j]/dc))
    
    #searching for extreme points
    extremePoint = np.zeros((number,dim+1))
    extremePoint_num = 0
    state = np.zeros((number),dtype = int)
    for i in range(number):
        if state[i] == 0:
            j = 1
            while density[i] >= density[c[i,j]] and b[i,j] < neighbuorhood_radius:
                if density[i] == density[c[i,j]]:
                    state[c[i,j]] = 1
                j += 1
            if b[i,j] >= neighbuorhood_radius:
                extremePoint_num += 1
                extremePoint[extremePoint_num-1,0:dim] = data[i,0:dim]
                extremePoint[extremePoint_num-1,dim] = i
    
    #assigning category
    clustering_result = np.zeros((number),dtype = int)
    for i in range(extremePoint_num):
        clustering_result[(int)(extremePoint[i][dim])] = i+1
        j = 1
        while b[(int)(extremePoint[i][dim])][j]<neighbuorhood_radius:
            if density[(int)(extremePoint[i][dim])] == density[c[(int)(extremePoint[i][dim]),j]]:
                clustering_result[c[(int)(extremePoint[i][dim]),j]] = i+1
            j += 1
    for i in range(number):
        if clustering_result[i]==0:
            queue = np.zeros((number), dtype = int)
            s = 0
            queue[s] = i
            while True:
                j = 0
                while density[queue[s]] >= density[c[queue[s],j]]:
                    j += 1
                if clustering_result[c[queue[s]][j]] == 0:
                    s += 1
                    queue[s] = c[queue[s-1]][j]
                else :
                    break
            for t in range(s+1):
                clustering_result[queue[t]] = clustering_result[c[queue[s]][j]]
     
    #detecting noises
    num = np.zeros((extremePoint_num))
    for i in range(number):
        num[clustering_result[i]-1] += 1
    num_mean = np.mean(num)
    for i in range(extremePoint_num):
        if num[i] < num_mean*0.05:
            for j in range(number):
                if clustering_result[j] == i+1:
                    clustering_result[j] = -1
    sortNum = 0
    sortNumMax = np.max(clustering_result)
    
    clustering = -np.ones((number),dtype = int)
    for i in range(sortNumMax):
        flag = 0
        for j in range(number):
            if clustering_result[j] == i+1:
                flag=1
                break
        if flag == 1:
            sortNum += 1
            for j in range(number):
                if clustering_result[j] == i+1:
                    clustering[j] = sortNum
    clustering_result = clustering
    return clustering_result