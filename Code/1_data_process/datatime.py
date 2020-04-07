import pandas as pd
from sklearn.cluster import KMeans
from sklearn import metrics
import numpy as np
import matplotlib.pyplot as plt
import scipy.io as sio
import os
import sys
from tqdm import tqdm, trange
import datetime
import time

# Hyper-parameters
SAVE_PATH = 'D:/Seafile/Group/2020-C/Code/results/'
# Hyper-parameters
DATA_PATH = 'D:/Seafile/Group/2020-C/Code/dataset/'
LOG_PATH = 'D:/Seafile/Group/2020-C/Code/log/'
cur_data_index = 2
'''
0 - hair_dryer.csv
1 - hair_dryer_title.csv
2 - microwave.csv
3 - microwave_title.csv
4 - pacifier.csv
5 - pacifier_title.csv

0 - hair_dryer.mat   2002/3/2
1 - microwave.mat    2004/6/19
2 - pacifier.mat     2010/6/30

keys:
'cluster_weight', 'ts_weight', 'score', 'features', 'index', 'isverified', 'product', 'body_len', 'labels'
'''

def date_convert(x):
    '''
    Args:
        x:          str.
    '''
    x_time = time.strptime(x, "%Y/%m/%d")
    x_datetime = datetime.datetime(x_time[0], x_time[1], x_time[2])
    return x_datetime

data_ori_list = os.listdir(DATA_PATH)
mat_ori_list = os.listdir(SAVE_PATH)
# df_date = pd.read_csv(DATA_PATH + data_ori_list[cur_data_index * 2 + 1])['review_date']
df_date = pd.read_csv(DATA_PATH + 'pacifier.csv')['review_date']
# data = sio.loadmat(SAVE_PATH + mat_ori_list[cur_data_index])
data = sio.loadmat(SAVE_PATH + 'pacifier+labels.mat')

dates_list = []

baseline_list = ['2002/3/2', '2004/6/19', '2010/6/30']
baseline_list = [date_convert(item) for item in baseline_list]

for i in df_date.index:
    item_datetime = date_convert(df_date.iloc[i])
    date = (item_datetime - baseline_list[cur_data_index]).days
    dates_list.append(date)

dates_list = np.stack(dates_list)
data['dates'] = dates_list
print(dates_list)

# sio.savemat(LOG_PATH + mat_ori_list[cur_data_index].split('.')[0] + '+dates.mat', data)
sio.savemat(LOG_PATH + 'pacifier+labels+dates.mat', data)

pass