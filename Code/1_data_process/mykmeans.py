import pandas as pd
from sklearn.cluster import KMeans
from sklearn import metrics
import numpy as np
import matplotlib.pyplot as plt
import scipy.io as sio
import os
import sys
from tqdm import tqdm, trange


# Hyper-parameters
SAVE_PATH = 'D:/Seafile/Group/2020-C/Code/results/'
cur_data_index = 2
'''
0 - hair_dryer.mat   
1 - microwave.mat
2 - pacifier.mat

keys:
'cluster_weight', 'ts_weight', 'score', 'features', 'index', 'isverified', 'product', 'body_len'
'''
data_list = os.listdir(SAVE_PATH)
# data = sio.loadmat(SAVE_PATH + data_list[cur_data_index])
data = sio.loadmat(SAVE_PATH + 'pacifier.mat')

# print(data.keys())
index = data['index'].reshape(-1)
cluster_weight = data['cluster_weight'].reshape(-1)
features = data['features']
score = data['score'].reshape(-1)

isverified = (data['isverified'] == 1).reshape(-1)

# plt.hist(cluster_weight, bins=10)
# plt.show()

# masked variables
labels = np.ones_like(index) * -1
index = index[isverified]
cluster_weight = cluster_weight[isverified]
features = features[index, :]

# k-means cluster
N_list = [10, 18, 9]
labels_raw = KMeans(n_clusters=N_list[cur_data_index]).fit(features).labels_
for i in range(len(labels_raw)):
    labels[index[i]] = labels_raw[i]

data['labels'] = labels.reshape(-1)
# sio.savemat(SAVE_PATH + data_list[cur_data_index].split('.')[0] + '+labels.mat', data)
sio.savemat(SAVE_PATH + 'pacifier+labels.mat', data)


# k-means testing
# init_N = 2
# steps = 30
# scores_list = []
# for k in trange(init_N, init_N + steps):
#     labels = KMeans(n_clusters=k).fit(features).labels_
#     score = metrics.silhouette_score(features, labels)
#     scores_list.append(score)

# print(scores_list)
# plt.figure(data_list[cur_data_index].split('.')[0] + ' K-means Silhouette Coefficient')
# plt.plot(list(range(init_N, init_N + steps)), scores_list)
# plt.title(data_list[cur_data_index].split('.')[0] + ' K-means Silhouette Coefficient')
# plt.xlabel('N-Clusters')
# plt.ylabel('Silhouette Coefficient')
# plt.grid()
# plt.show()
# print(data)

pass