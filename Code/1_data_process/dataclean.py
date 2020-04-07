import pandas as pd 
import numpy as np 
import scipy.io as sio 
import os
import sys
import math
from tqdm import tqdm
from sklearn.cluster import KMeans

# Hyper-parameters
DATA_PATH = 'D:/Seafile/Group/2020-C/Code/dataset/'
SAVE_PATH = 'D:/Seafile/Group/2020-C/Code/results/'
cur_data_index = 4
'''
0 - hair_dryer.csv
1 - hair_dryer_title.csv
2 - microwave.csv
3 - microwave_title.csv
4 - pacifier.csv
5 - pacifier_title.csv

'''
# print(DATA_PATH)

# dataloading
data_list = os.listdir(DATA_PATH)
df_ori = pd.read_csv(DATA_PATH + data_list[cur_data_index])
df_ori_title = pd.read_csv(DATA_PATH + data_list[cur_data_index + 1])

# create data matrix
'''
construction law:
1.use company id to distinguish different source
2.use item id to help sorting the original information
3.only include the feature vectors
4.concerned variables:
    'product_parent', 'star_rating', 'helpful_votes', 'vine', 'verified_purchase',
    'review_date', 'helpful_rate', 'review_headline_score', 'review_body_score', 'features'
5.weight:
    'product_parent': product ID
    'star_rating', 'review_headline_score', 'review_body_score', 'features': main element 
    'helpful_votes', 'helpful_rate', 'vine', 'verified_purchase', 'review_length': determine the weight of review item
    'review_date': time ID

    weight = e^{helpful_rate - 1} * e^{normalized{helpful_votes} - 1} 
            * e^{normalized{review_length}} * e^{vine - 1} 
            NOTE NOT INCLUDE verified_purchase

6.TWO PROCEDURE:
    cluster:
        only choose:
            weight > threshold (according to statistic characteristic) OR vine = Y
            verified_purchase = Y
            
    time series statistic:
        all the sample:
            use KNN to help clustering, and generate time series 
            NOTE verified_purchase would be discounted by e^{verified_purchase - 1}
        
    NOTE only use informative items to do KMEANS while use ALL of the items to draw time series curve
'''

columns_mask = ['product_parent', 'star_rating', 'helpful_votes', 'vine', 'verified_purchase', 
                'review_date', 'helpful_rate', 'review_headline_score', 'review_body_score']
feature_mask = ['color', 'big',
       'animal', 'refundable', 'delivery fast', 'cheap', 'suitable', 'package',
       'certification', 'silicon', 'durable', 'convenient', 'giveaway',
       'safe']

df_masked = df_ori[columns_mask]
df_feature = df_ori[feature_mask]
df_title_feature = df_ori_title[feature_mask]
df_review_body = df_ori['review_body']
# print(df_masked)


def wgf(x):
    return math.exp(x - 1)

def bgf(x):
    if x == 'Y' or x == 'y':
        return 1
    elif x == 'N' or x == 'n':
        return 0
    else:
        raise KeyError('Error in bgf')

# compute well-organized data
data_dict = {}
cluster_weight_list = []
ts_weight_list = []
score_list = []
features_list = []
index_list = []
isverified_list = []
product_list = []
body_len_list = []

# compute the review body
for i in df_review_body.index:
    body_len_list.append(len(df_review_body.iloc[i]))

max_helpful_votes = max(df_masked['helpful_votes'])
max_review_length = max(body_len_list)


for i in tqdm(df_masked.index):
    item = df_masked.loc[i,:]

    # compute
    cluster_weight = wgf(item['helpful_votes'] / max_helpful_votes) * \
                    wgf(item['helpful_rate']) * \
                    wgf(body_len_list[i] / max_review_length) * \
                    wgf(bgf(item['vine']))
    isverified = bgf(item['verified_purchase'])
    ts_weight = wgf(isverified)
    if item['review_body_score'] == 'nan':
        body_weight = 0
    else:
        body_weight = np.float(item['review_body_score'])
    score = item['star_rating'] * item['review_headline_score'] * body_weight
    features = np.array(df_feature.loc[i, :]) * np.array(df_title_feature.loc[i, :])
    index = i
    product = item['product_parent']

    # append
    cluster_weight_list.append(cluster_weight)
    ts_weight_list.append(ts_weight)
    score_list.append(score)
    features_list.append(features)

    index_list.append(index)
    isverified_list.append(isverified)
    product_list.append(product)


cluster_weight_list = np.stack(cluster_weight_list)
cluster_weight_list = cluster_weight_list / np.max(cluster_weight_list)

ts_weight_list = np.stack(ts_weight_list)
ts_weight_list = ts_weight_list / np.max(ts_weight_list)

score_list = np.stack(score_list)
score_list = score_list / max(score_list)

features_list = np.stack(features_list)
features_max = np.expand_dims(np.max(features_list, axis=0), 0)
features_min = np.expand_dims(np.min(features_list, axis=0), 0)
features_list = (features_list - features_min) / (features_max - features_min)

# data save
data_dict['cluster_weight'] = cluster_weight_list
data_dict['ts_weight'] = ts_weight_list
data_dict['score'] = score_list
data_dict['features'] = features_list
data_dict['index'] = index_list
data_dict['isverified'] = isverified_list
data_dict['product'] = product_list
data_dict['body_len'] = body_len_list

sio.savemat(SAVE_PATH + data_list[cur_data_index].split('.')[0] + '.mat', data_dict)

pass






